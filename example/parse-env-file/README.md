### Example parse env file
```hcl
module "parameters" {
  source  = "zahornyak/multiple-ssm-parameters/aws"

  file_path = ".env"

}
```

### Example parse and use custom parameters
```hcl
module "parameters_and_parse_files" {
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

  file_path = ".env"

}
```


### Example of tf plan output
```commandline
Terraform will perform the following actions:

  # module.parameters.aws_ssm_parameter.parsed["CERTIFICATE"] will be created
  + resource "aws_ssm_parameter" "parsed" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "CERTIFICATE"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

  # module.parameters.aws_ssm_parameter.parsed["DB_NAME"] will be created
  + resource "aws_ssm_parameter" "parsed" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "DB_NAME"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

  # module.parameters.aws_ssm_parameter.parsed["DB_PASSWORD"] will be created
  + resource "aws_ssm_parameter" "parsed" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "DB_PASSWORD"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

  # module.parameters.aws_ssm_parameter.parsed["SECRET"] will be created
  + resource "aws_ssm_parameter" "parsed" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "SECRET"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

```
```commandline
Terraform will perform the following actions:

  # module.parameters.aws_ssm_parameter.parsed["CERTIFICATE"] will be created
  + resource "aws_ssm_parameter" "parsed" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "CERTIFICATE"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

  # module.parameters.aws_ssm_parameter.parsed["DB_NAME"] will be created
  + resource "aws_ssm_parameter" "parsed" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "DB_NAME"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

  # module.parameters.aws_ssm_parameter.parsed["DB_PASSWORD"] will be created
  + resource "aws_ssm_parameter" "parsed" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "DB_PASSWORD"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

  # module.parameters.aws_ssm_parameter.parsed["SECRET"] will be created
  + resource "aws_ssm_parameter" "parsed" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "SECRET"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "SecureString"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

  # module.parameters.aws_ssm_parameter.this["db_name"] will be created
  + resource "aws_ssm_parameter" "this" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + description    = "name of the db"
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "foo"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "String"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

  # module.parameters.aws_ssm_parameter.this["db_password"] will be created
  + resource "aws_ssm_parameter" "this" {
      + arn            = (known after apply)
      + data_type      = (known after apply)
      + description    = "secure password"
      + id             = (known after apply)
      + insecure_value = (known after apply)
      + key_id         = (known after apply)
      + name           = "db_password"
      + tags_all       = (known after apply)
      + tier           = (known after apply)
      + type           = "String"
      + value          = (sensitive value)
      + version        = (known after apply)
    }

Plan: 6 to add, 0 to change, 0 to destroy.

```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.37 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_parameters_and_parse_files"></a> [parameters\_and\_parse\_files](#module\_parameters\_and\_parse\_files) | ../.. | n/a |
| <a name="module_parse_files"></a> [parse\_files](#module\_parse\_files) | ../.. | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->