# terraform-aws-multiple-ssm-parameters

Create many AWS SSM Parameter Store entries from a map and/or a `.env` file.

```hcl
module "parameters" {
  source = "zahornyak/multiple-ssm-parameters/aws"

  parameter_prefix = "/myapp/dev/"

  parameters = {
    db_name = {
      name  = "DB_NAME"
      value = "mydb"
      type  = "String"
    }
    db_password = {
      value    = "initial-only"
      unlocked = true # Terraform will not update the value after create
    }
  }
}
```

## `.env` file

Set `file_path` to load `KEY=value` lines. Comments (`#`) and empty lines are skipped. Values may be quoted.

```hcl
module "parameters" {
  source           = "zahornyak/multiple-ssm-parameters/aws"
  parameter_prefix = "/myapp/dev/"
  file_path        = ".env"
}
```

You can combine `parameters` and `file_path` in the same module call.

## Read existing parameters

Use `data = true` on one entry or set `data = true` on the module to look up parameters that already exist:

```hcl
parameters = {
  existing_secret = {
    name = "EXISTING_PARAM"
    data = true
  }
}
```

## ECS secrets

`container_definitions_secrets` is shaped for the Cloud Posse ECS container definition module: each item uses the **map key** as the container env name and the parameter ARN as `valueFrom`.

## Examples

See [`examples/simple`](examples/simple) and [`examples/parse-env-file`](examples/parse-env-file).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.37 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 2.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.37 |
| <a name="provider_local"></a> [local](#provider\_local) | >= 2.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.parsed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.unlocked](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [local_file.config_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data"></a> [data](#input\_data) | When true, read existing parameters instead of creating them (same as `data = true` on each entry). | `bool` | `false` | no |
| <a name="input_file_path"></a> [file\_path](#input\_file\_path) | Optional path to a `.env` file (`KEY=value` lines; `#` comments and blank lines are ignored). | `string` | `null` | no |
| <a name="input_parameter_prefix"></a> [parameter\_prefix](#input\_parameter\_prefix) | Prefix prepended to every parameter name (for example `/myapp/dev/`). | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | Map of SSM parameters. Map key is used in outputs and ECS secrets; optional `name` sets the Parameter Store path. | <pre>map(object({<br>    name            = optional(string)<br>    value           = optional(string)<br>    type            = optional(string, "SecureString")<br>    description     = optional(string)<br>    allowed_pattern = optional(string)<br>    data_type       = optional(string)<br>    insecure_value  = optional(string)<br>    key_id          = optional(string)<br>    overwrite       = optional(bool)<br>    tier            = optional(string)<br>    tags            = optional(map(string), {})<br>    unlocked        = optional(bool, false)<br>    data            = optional(bool, false)<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to every created parameter. | `map(string)` | `{}` | no |
| <a name="input_unlocked"></a> [unlocked](#input\_unlocked) | When true, Terraform ignores value changes for all parameters (same as `unlocked = true` on each entry). | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_definitions_secrets"></a> [container\_definitions\_secrets](#output\_container\_definitions\_secrets) | ECS container definition secrets block (name = map key, valueFrom = parameter ARN). |
| <a name="output_parameters_arns"></a> [parameters\_arns](#output\_parameters\_arns) | Map of parameter keys to SSM parameter ARNs. |
| <a name="output_parameters_ids"></a> [parameters\_ids](#output\_parameters\_ids) | Map of parameter keys to SSM parameter IDs. |
| <a name="output_parameters_name_arns"></a> [parameters\_name\_arns](#output\_parameters\_name\_arns) | Map of SSM parameter names to ARNs. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->