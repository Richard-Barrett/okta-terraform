resource "okta_app_saml" "this" {
  label       = var.label
  sso_url     = var.sso_url
  recipient   = var.recipient
  destination = var.destination
  audience    = var.audience
  status      = var.status

  # Let Okta retain its default authentication policy.
  # Terraform will not attempt to read or modify it.
  skip_authentication_policy = true

  subject_name_id_template = var.subject_name_id_template

  subject_name_id_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

  response_signed  = true
  assertion_signed = true

  signature_algorithm = "RSA_SHA256"
  digest_algorithm    = "SHA256"

  authn_context_class_ref = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

  dynamic "attribute_statements" {
    for_each = var.attribute_statements

    content {
      name         = attribute_statements.value.name
      namespace    = try(attribute_statements.value.namespace, null)
      type         = try(attribute_statements.value.type, null)
      values       = try(attribute_statements.value.values, null)
      filter_type  = try(attribute_statements.value.filter_type, null)
      filter_value = try(attribute_statements.value.filter_value, null)
    }
  }
}
