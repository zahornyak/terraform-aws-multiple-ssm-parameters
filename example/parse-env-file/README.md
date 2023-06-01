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