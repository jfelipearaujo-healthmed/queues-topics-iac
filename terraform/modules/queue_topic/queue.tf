resource "aws_sqs_queue" "queue" {
  name                       = var.queue_name
  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400
  delay_seconds              = 1
  receive_wait_time_seconds  = 0

  fifo_queue = var.is_fifo

  depends_on = [
    aws_sns_topic.topic
  ]
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = aws_sqs_queue.queue.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = "*",
      Action    = "sqs:SendMessage",
      Resource  = aws_sqs_queue.queue.arn,
      Condition = {
        ArnEquals = {
          "aws:SourceArn" = aws_sns_topic.topic.arn
        }
      }
    }]
  })

  depends_on = [
    aws_sns_topic.topic,
    aws_sqs_queue.queue
  ]
}
