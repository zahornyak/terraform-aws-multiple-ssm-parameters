output "parameters_ids" {
  description = "parameters ids map"
  value       = { for k, v in aws_ssm_parameter.this : k => v["id"] }
}

output "parameters_arns" {
  description = "parameters arns map"
  value       = { for k, v in aws_ssm_parameter.this : k => v["arn"] }
}
