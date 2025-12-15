resource "aws_ssm_parameter" "aws_acm_certificate" {
  name  = "/${var.project_name}/${var.environment}/aws_acm_certificate_arn"
  type  = "String"
  value = aws_acm_certificate.aws76s.arn
} 