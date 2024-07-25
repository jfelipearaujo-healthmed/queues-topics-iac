resource "aws_iam_policy" "queue_policy" {
  for_each = { for prefix in var.sa_prefix_roles : prefix => prefix }

  name = "queue-${var.queue_name}-${each.value}-sa-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:*",
        ]
        Resource = "arn:aws:sqs:${var.region}:*"
      },
    ]
  })
}

resource "aws_iam_policy" "sns_policy" {
  for_each = { for prefix in var.sa_prefix_roles : prefix => prefix }

  name = "sns-${var.topic_name}-${each.value}-sa-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sns:*",
        ]
        Resource = "arn:aws:sns:${var.region}:*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "queue_policy_attachment" {
  for_each = { for prefix in var.sa_prefix_roles : prefix => prefix }

  role       = "${each.value}-service-account-role"
  policy_arn = aws_iam_policy.queue_policy[each.value].arn
}

resource "aws_iam_role_policy_attachment" "sns_policy_attachment" {
  for_each = { for prefix in var.sa_prefix_roles : prefix => prefix }

  role       = "${each.value}-service-account-role"
  policy_arn = aws_iam_policy.sns_policy[each.value].arn
}
