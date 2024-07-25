variable "region" {
  type        = string
  description = "The default region to use for AWS"
}

variable "queue_name" {
  type        = string
  description = "The name of the queue"
}

variable "topic_name" {
  type        = string
  description = "The name of the topic"
}

variable "sa_prefix_roles" {
  type        = list(string)
  description = "The list of prefix of SA to be used in the roles"
}

variable "is_fifo" {
  type        = bool
  description = "The type of queue"
  default     = false
}
