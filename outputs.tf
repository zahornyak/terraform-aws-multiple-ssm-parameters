output "parameters_ids" {
  description = "parameters ids map"
  value       = { for k, v in aws_ssm_parameter.this : k => v["id"] }
}

output "parameters_arns" {
  description = "parameters arns map"
  value       = { for k, v in aws_ssm_parameter.this : k => v["arn"] }
}

output "parameters_name_arns" {
  description = "parameters arns map with names of parameter"
  value = {
    for key, param in aws_ssm_parameter.this : param.name => aws_ssm_parameter.this[key].arn
  }
}