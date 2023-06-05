#module "parse_files" {
#  source = "../.."
#
#  parameter_prefix = "/dev/"
#
#  file_path = ".env"
#
#}


module "parameters_and_parse_files" {
  source = "../.."

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