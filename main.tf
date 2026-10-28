data "local_file" "config_file" {
  count    = var.file_path != null ? 1 : 0
  filename = var.file_path
}

locals {
  env_lines = var.file_path != null ? [
    for line in split("\n", data.local_file.config_file[0].content) :
    trimspace(line)
    if trimspace(line) != "" && !startswith(trimspace(line), "#")
  ] : []

  env_matches = [
    for line in local.env_lines : regexall("^([^=]+)=(.*)$", line)[0]
    if length(regexall("^([^=]+)=(.*)$", line)) > 0
  ]

  parsed_data = {
    for groups in local.env_matches :
    trimspace(groups[0]) => trim(trimspace(groups[1]), "\"")
    if trimspace(groups[0]) != ""
  }

  is_data_source = {
    for k, v in var.parameters :
    k => var.data || try(v.data, false)
  }

  is_unlocked = {
    for k, v in var.parameters :
    k => var.unlocked || try(v.unlocked, false)
  }

  managed_parameters = {
    for k, v in var.parameters :
    k => v
    if !local.is_data_source[k] && !local.is_unlocked[k]
  }

  unlocked_parameters = {
    for k, v in var.parameters :
    k => v
    if !local.is_data_source[k] && local.is_unlocked[k]
  }

  data_parameters = {
    for k, v in var.parameters :
    k => v
    if local.is_data_source[k]
  }

  parameter_names = {
    for k, v in var.parameters :
    k => var.parameter_prefix != null ? "${var.parameter_prefix}${coalesce(try(v.name, null), k)}" : coalesce(try(v.name, null), k)
  }

  all_parameters = merge(
    aws_ssm_parameter.this,
    aws_ssm_parameter.unlocked,
    aws_ssm_parameter.parsed,
    data.aws_ssm_parameter.data,
  )
}

resource "aws_ssm_parameter" "this" {
  for_each = local.managed_parameters

  name            = local.parameter_names[each.key]
  type            = try(each.value.type, "SecureString")
  value           = try(each.value.value, null)
  description     = try(each.value.description, null)
  allowed_pattern = try(each.value.allowed_pattern, null)
  data_type       = try(each.value.data_type, null)
  insecure_value  = try(each.value.insecure_value, null)
  key_id          = try(each.value.key_id, null)
  overwrite       = try(each.value.overwrite, null)
  tier            = try(each.value.tier, null)

  tags = merge(var.tags, try(each.value.tags, {}))
}

resource "aws_ssm_parameter" "unlocked" {
  for_each = local.unlocked_parameters

  name            = local.parameter_names[each.key]
  type            = try(each.value.type, "SecureString")
  value           = try(each.value.value, null)
  description     = try(each.value.description, null)
  allowed_pattern = try(each.value.allowed_pattern, null)
  data_type       = try(each.value.data_type, null)
  insecure_value  = try(each.value.insecure_value, null)
  key_id          = try(each.value.key_id, null)
  overwrite       = try(each.value.overwrite, null)
  tier            = try(each.value.tier, null)

  tags = merge(var.tags, try(each.value.tags, {}))

  lifecycle {
    ignore_changes = [value]
  }
}

resource "aws_ssm_parameter" "parsed" {
  for_each = local.parsed_data

  name  = var.parameter_prefix != null ? "${var.parameter_prefix}${each.key}" : each.key
  type  = "SecureString"
  value = each.value

  tags = var.tags
}

data "aws_ssm_parameter" "data" {
  for_each = local.data_parameters

  name = local.parameter_names[each.key]
}
