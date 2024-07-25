module "appointment_creator" {
  source = "./modules/queue_topic"

  region = var.region

  sa_prefix_roles = [
    "appointment-service",
    "appointment-creator-service",
  ]

  is_fifo = true

  queue_name = "AppointmentQueue.fifo"
  topic_name = "AppointmentTopic"
}

module "review_processor" {
  source = "./modules/queue_topic"

  region = var.region

  sa_prefix_roles = [
    "appointment-service",
    "review-processor-service",
  ]

  queue_name = "ReviewQueue"
  topic_name = "ReviewTopic"
}
