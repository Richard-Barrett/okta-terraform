variable "label" { type = string }
variable "sso_url" { type = string }
variable "recipient" { type = string }
variable "destination" { type = string }
variable "audience" { type = string }
variable "status" { type = string }
variable "subject_name_id_template" { type = string }
variable "subject_name_id_format" { type = string }
variable "response_signed" { type = bool }
variable "assertion_signed" { type = bool }
variable "signature_algorithm" { type = string }
variable "digest_algorithm" { type = string }
variable "honor_force_authn" { type = bool }

variable "attribute_statements" {
  type = list(object({
    name         = string
    type         = string
    values       = optional(list(string), [])
    filter_type  = optional(string)
    filter_value = optional(string)
  }))
  default = []
}
