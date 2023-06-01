resource "aws_ssm_parameter" "this" {
  for_each = var.parameters

  name            = lookup(each.value, "name", null) == null ? each.key : lookup(each.value, "name")
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


data "local_file" "config_file" {
  count    = var.file_path != null ? 1 : 0
  filename = var.file_path
}

locals {
  file_content = data.local_file.config_file[0].content
  parsed_data = { for line in split("\n", local.file_content) :
    regex("(.*?)\\s*=\\s*(.*)$", line)[0] => regex("(.*?)\\s*=\\s*(.*)$", line)[1]
  }
}

resource "aws_ssm_parameter" "parsed" {
  for_each = local.parsed_data

  name  = each.key
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