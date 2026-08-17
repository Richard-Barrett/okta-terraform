variable "okta_org_name" {
  description = "Okta organization name, e.g. trial-1234567 (not the full hostname)."
  type        = string
}

variable "okta_base_url" {
  description = "Okta base domain, e.g. okta.com, oktapreview.com, or okta-emea.com."
  type        = string
  default     = "okta.com"
}

variable "okta_client_id" {
  description = "Client ID of the Okta API Services application used by Terraform."
  type        = string
  sensitive   = true
}

variable "okta_private_key" {
  description = "PKCS#1 RSA private key content or a path to the private key file."
  type        = string
  sensitive   = true
}
