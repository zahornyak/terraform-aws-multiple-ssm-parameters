# Terraform aws ssm multiple parameters creation
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/zahornyak/terraform-aws-multiple-ssm-parameters)

Terraform module that simplifies multiple parameters creation on parameter store. Also can parse .env files
Especially useful with Terragrunt.


### Example usage
```hcl
module "parameters" {
  source  = "zahornyak/multiple-ssm-parameters/aws"

  # prefix for parameter name
  parameter_prefix = "/dev/"
  
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

### Example parse env file
```hcl
module "parameters" {
  source  = "zahornyak/multiple-ssm-parameters/aws"

  # prefix for parameter name
  parameter_prefix = "/dev/"
  
  file_path = ".env"

}
```
#### .env example:
```commandline
DB_NAME=mysql
DB_PASSWORD=password

# example comment here
CERTIFICATE="dawjhjdkl;aefjhguwyidhjakenka"
SECRET="sjkbfdksnjwdjewlknfkj"
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

#### Unlocked variables example(wont be changed by terraform):
You can lock each parameter or all the parameters
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
      unlocked = true
    }
  }

  #  unlocked = true
}
```

#### You can use all the environments for container definition secrets:
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
      unlocked = true
    }
  }
}

module "service_container_definition" {
  source  = "registry.terraform.io/cloudposse/ecs-container-definition/aws"

  container_image = "nginx:latest"
  container_name  = "example"
  essential       = true

  stop_timeout = 5
  
  port_mappings = [
    {
      containerPort = 80
      protocol      = "tcp"
      hostPort      = null
    }
  ]
  
  secrets = module.parameters.container_definitions_secrets

}
```



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.37 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.37 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

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
| <a name="input_data"></a> [data](#input\_data) | data to store in parameter store | `bool` | `false` | no |
| <a name="input_file_path"></a> [file\_path](#input\_file\_path) | file to parse | `string` | `null` | no |
| <a name="input_parameter_prefix"></a> [parameter\_prefix](#input\_parameter\_prefix) | prefix for parameter names. For example you wanna split dev/prod parameters so you wanna add /service\_name/development/ prefix before parameter name | `string` | `null` | no |
| <a name="input_parameters"></a> [parameters](#input\_parameters) | map of parameters for parameter store | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies a tags | `any` | `{}` | no |
| <a name="input_unlocked"></a> [unlocked](#input\_unlocked) | if true - sets the ignore lifecycle policy and disable terraform managing the version of the resource | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_definitions_secrets"></a> [container\_definitions\_secrets](#output\_container\_definitions\_secrets) | useful output for container definition secrets variable |
| <a name="output_parameters_arns"></a> [parameters\_arns](#output\_parameters\_arns) | parameters arns map |
| <a name="output_parameters_ids"></a> [parameters\_ids](#output\_parameters\_ids) | parameters ids map |
| <a name="output_parameters_name_arns"></a> [parameters\_name\_arns](#output\_parameters\_name\_arns) | merged parameters arns map with names of parameter |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->