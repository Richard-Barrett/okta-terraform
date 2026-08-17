resource "okta_app_saml" "this" {
  label       = var.label
  sso_url     = var.sso_url
  recipient   = var.recipient
  destination = var.destination
  audience    = var.audience
  status      = var.status

  subject_name_id_template = var.subject_name_id_template
  subject_name_id_format   = var.subject_name_id_format

  response_signed     = var.response_signed
  assertion_signed    = var.assertion_signed
  signature_algorithm = var.signature_algorithm
  digest_algorithm    = var.digest_algorithm
  honor_force_authn   = var.honor_force_authn

  authn_context_class_ref = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"

  dynamic "attribute_statements" {
    for_each = var.attribute_statements
    content {
      name         = attribute_statements.value.name
      type         = attribute_statements.value.type
      values       = length(attribute_statements.value.values) > 0 ? attribute_statements.value.values : null
      filter_type  = try(attribute_statements.value.filter_type, null)
      filter_value = try(attribute_statements.value.filter_value, null)
    }
  }
}
