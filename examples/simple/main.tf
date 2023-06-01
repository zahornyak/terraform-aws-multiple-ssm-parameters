module "parameters" {
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
}