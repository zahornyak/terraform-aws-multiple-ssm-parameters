resource "aws_ssm_parameter" "this" {
  for_each = var.parameters

  name            = lookup(each.value, "name", null) == null ? each.key : lookup(each.value, "name")
  type            = lookup(each.value, "type", null)
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