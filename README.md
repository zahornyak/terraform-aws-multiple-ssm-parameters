# Terraform aws ssm multiple parameters creation
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/zahornyak/terraform-aws-multiple-ssm-parameters)

Terraform module that simplifies multiple parameters creation on parameter store.
Especially useful with Terragrunt.


### Example usage
```hcl
module "parameters" {
  source  = "zahornyak/multiple-ssm-parameters/aws"

  parameters = {
    db_name = {
      name        = "foo"
      value       = "bar"
      type        = "String"
      description = "name of the db"
    }
    db_password = {
      value       = "password"
      type        = "String"
      description = "secure password"
    }
  }
}
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.37 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.37 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_parameters"></a> [parameters](#input\_parameters) | map of parameters for parameter store | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies a tags | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_parameters_arns"></a> [parameters\_arns](#output\_parameters\_arns) | parameters arns map |
| <a name="output_parameters_ids"></a> [parameters\_ids](#output\_parameters\_ids) | parameters ids map |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->