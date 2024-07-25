variable "tags" {
  type        = map(string)
  description = "The default tags to use for AWS resources"
  default = {
    App = "queue_topic"
  }
}

variable "region" {
  type        = string
  description = "The default region to use for AWS"
  default     = "us-east-1"
}
