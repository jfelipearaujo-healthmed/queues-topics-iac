resource "aws_sns_topic" "topic" {
  name = var.topic_name

  fifo_topic = var.is_fifo
}
