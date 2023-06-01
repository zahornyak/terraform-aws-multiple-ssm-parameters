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
