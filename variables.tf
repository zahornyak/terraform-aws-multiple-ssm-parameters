variable "parameters" {
  description = "Map of SSM parameters. Map key is used in outputs and ECS secrets; optional `name` sets the Parameter Store path."
  type = map(object({
    name            = optional(string)
    value           = optional(string)
    type            = optional(string, "SecureString")
    description     = optional(string)
    allowed_pattern = optional(string)
    data_type       = optional(string)
    insecure_value  = optional(string)
    key_id          = optional(string)
    overwrite       = optional(bool)
    tier            = optional(string)
    tags            = optional(map(string), {})
    unlocked        = optional(bool, false)
    data            = optional(bool, false)
  }))
  default = {}
}

variable "tags" {
  description = "Tags applied to every created parameter."
  type        = map(string)
  default     = {}
}

variable "file_path" {
  description = "Optional path to a `.env` file (`KEY=value` lines; `#` comments and blank lines are ignored)."
  type        = string
  default     = null
}

variable "parameter_prefix" {
  description = "Prefix prepended to every parameter name (for example `/myapp/dev/`)."
  type        = string
  default     = null
}

variable "unlocked" {
  description = "When true, Terraform ignores value changes for all parameters (same as `unlocked = true` on each entry)."
  type        = bool
  default     = false
}

variable "data" {
  description = "When true, read existing parameters instead of creating them (same as `data = true` on each entry)."
  type        = bool
  default     = false
}
