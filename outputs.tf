output "parameters_ids" {
  description = "parameters ids map"
  value       = { for k, v in aws_ssm_parameter.this : k => v["id"] }
}

output "parameters_arns" {
  description = "parameters arns map"
  value       = { for k, v in aws_ssm_parameter.this : k => v["arn"] }
}

output "parameters_name_arns" {
  description = "merged parameters arns map with names of parameter"
  value = {
    for key, param in merge(aws_ssm_parameter.this, aws_ssm_parameter.parsed) : param.name => param.arn
  }
}
