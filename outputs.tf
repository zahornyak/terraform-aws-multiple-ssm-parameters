output "parameters_ids" {
  description = "Map of parameter keys to SSM parameter IDs."
  value       = { for k, v in local.all_parameters : k => v.id }
}

output "parameters_arns" {
  description = "Map of parameter keys to SSM parameter ARNs."
  value       = { for k, v in local.all_parameters : k => v.arn }
}

output "parameters_name_arns" {
  description = "Map of SSM parameter names to ARNs."
  value       = { for k, v in local.all_parameters : v.name => v.arn }
}

output "container_definitions_secrets" {
  description = "ECS container definition secrets block (name = map key, valueFrom = parameter ARN)."
  value = [
    for k, v in local.all_parameters : {
      name      = k
      valueFrom = v.arn
    }
  ]
}
