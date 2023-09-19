output "parameters_ids" {
  description = "parameters ids map"
  value       = { for k, v in merge(aws_ssm_parameter.this, aws_ssm_parameter.parsed, aws_ssm_parameter.unlocked, data.aws_ssm_parameter.data) : k => v["id"] }
}

output "parameters_arns" {
  description = "parameters arns map"
  value       = { for k, v in merge(aws_ssm_parameter.this, aws_ssm_parameter.parsed, aws_ssm_parameter.unlocked, data.aws_ssm_parameter.data) : k => v["arn"] }
}

output "parameters_name_arns" {
  description = "merged parameters arns map with names of parameter"
  value = {
    for key, param in merge(aws_ssm_parameter.this, aws_ssm_parameter.parsed, aws_ssm_parameter.unlocked, data.aws_ssm_parameter.data) : param.name => param.arn
  }
}

locals {
  parameter_arns = { for k, v in merge(aws_ssm_parameter.this, aws_ssm_parameter.parsed, aws_ssm_parameter.unlocked, data.aws_ssm_parameter.data) : k => v["arn"] }
}

output "container_definitions_secrets" {
  value = [
    for k, v in local.parameter_arns : {
      name      = k
      valueFrom = v
    }
  ]
  description = "useful output for container definition secrets variable"
}
