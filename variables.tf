variable "parameters" {
  description = "map of parameters for parameter store"
  type        = any
  default     = {}
}

variable "tags" {
  description = "Specifies a tags"
  type        = any
  default     = {}
}

variable "file_path" {
  description = "file to parse"
  default     = null
  type        = string
}

variable "parameter_prefix" {
  description = "prefix for parameter names. For example you wanna split dev/prod parameters so you wanna add /service_name/development/ prefix before parameter name"
  default     = null
  type        = string
}

variable "unlocked" {
  description = "if true - sets the ignore lifecycle policy and disable terraform managing the version of the resource"
  type        = bool
  default     = false
}
