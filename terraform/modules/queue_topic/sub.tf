resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.queue.arn

  depends_on = [
    aws_sns_topic.topic,
    aws_sqs_queue.queue,
    aws_sqs_queue_policy.queue_policy
  ]
}
