resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "rds.amazonaws.com"
        }
      },
    ]
  })

    inline_policy  {
    name = "my_inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = [
            "kms:*",
            "s3:*"
            ]
          Effect   = "Allow"
          Resource = [
            "arn:aws:s3:::lane-devops-pairing-exercise-bucket-v2/*"
          ]
        },
      ]
    })
  }

  tags = {
    tag-key = "tag-value"
  }
}

output "s3_iam_role" {
  value = aws_iam_role.test_role.arn
}