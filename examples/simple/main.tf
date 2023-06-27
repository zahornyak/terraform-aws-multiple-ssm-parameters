module "parameters" {
  source = "../.."

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
      unlocked    = true
    }
  }

  #  unlocked = true
}