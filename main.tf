resource "aws_ssm_parameter" "this" {
  for_each = { for k, v in var.parameters : k => v if !var.unlocked && try(v.unlocked, false) == false }

  name            = var.parameter_prefix != null ? "${var.parameter_prefix}${lookup(each.value, "name", null) == null ? each.key : lookup(each.value, "name")}" : lookup(each.value, "name", null) == null ? each.key : lookup(each.value, "name")
  type            = lookup(each.value, "type", "SecureString")
  value           = lookup(each.value, "value", null)
  description     = lookup(each.value, "description", null)
  allowed_pattern = lookup(each.value, "allowed_pattern", null)
  data_type       = lookup(each.value, "data_type", null)
  insecure_value  = lookup(each.value, "insecure_value", null)
  key_id          = lookup(each.value, "key_id", null)
  overwrite       = lookup(each.value, "overwrite", null)
  tier            = lookup(each.value, "tier", null)

  tags = merge(var.tags, lookup(each.value, "tags", null))
}

resource "aws_ssm_parameter" "unlocked" {
  for_each = { for k, v in var.parameters : k => v if var.unlocked || try(v.unlocked, false) == true }

  name            = var.parameter_prefix != null ? "${var.parameter_prefix}${lookup(each.value, "name", null) == null ? each.key : lookup(each.value, "name")}" : lookup(each.value, "name", null) == null ? each.key : lookup(each.value, "name")
  type            = lookup(each.value, "type", "SecureString")
  value           = lookup(each.value, "value", null)
  description     = lookup(each.value, "description", null)
  allowed_pattern = lookup(each.value, "allowed_pattern", null)
  data_type       = lookup(each.value, "data_type", null)
  insecure_value  = lookup(each.value, "insecure_value", null)
  key_id          = lookup(each.value, "key_id", null)
  overwrite       = lookup(each.value, "overwrite", null)
  tier            = lookup(each.value, "tier", null)

  tags = merge(var.tags, lookup(each.value, "tags", null))

  lifecycle {
    ignore_changes = [value]
  }
}


data "local_file" "config_file" {
  count    = var.file_path != null ? 1 : 0
  filename = var.file_path
}

locals {
  #  parsed_data = var.file_path != null ? {
  #    for line in split("\n", data.local_file.config_file[0].content) :
  #    split("=", line)[0] => split("=", line)[1]
  #  } : {}
  parsed_data = var.file_path != null ? {
    for line in split("\n", data.local_file.config_file[0].content) :
    split("=", line)[0] => split("=", line)[1]
    if can(split("=", line)[1])
  } : {}
}

resource "aws_ssm_parameter" "parsed" {
  for_each = local.parsed_data

  name  = var.parameter_prefix != null ? "${var.parameter_prefix}${each.key}" : each.key
  type  = "SecureString"
  value = each.value
  #  description     = null
  #  allowed_pattern = null
  #  data_type       = null
  #  insecure_value  = null
  #  key_id          = null
  #  overwrite       = null
  #  tier            = null

  tags = merge(var.tags, {})
}