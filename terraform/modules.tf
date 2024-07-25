module "appointment_creator" {
  source = "./modules/queue_topic"

  region = var.region

  sa_prefix_roles = [
    "appointments",
    "appointment-creator",
  ]

  is_fifo = true

  queue_name = "AppointmentQueue.fifo"
  topic_name = "AppointmentTopic.fifo"
}

module "review_processor" {
  source = "./modules/queue_topic"

  region = var.region

  sa_prefix_roles = [
    "appointments",
    "review-processor",
  ]

  queue_name = "ReviewQueue"
  topic_name = "ReviewTopic"
}
