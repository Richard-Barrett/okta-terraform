module "saml_application" {
  source   = "./modules/okta-saml-application"
  for_each = local.saml_apps

  label                    = each.value.label
  sso_url                  = each.value.sso_url
  audience                 = each.value.audience
  recipient                = try(each.value.recipient, each.value.sso_url)
  destination              = try(each.value.destination, each.value.sso_url)
  subject_name_id_template = try(each.value.subject_name_id_template, "$${user.email}")
  subject_name_id_format   = try(each.value.subject_name_id_format, "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress")
  status                   = try(each.value.status, "ACTIVE")
  response_signed          = try(each.value.response_signed, true)
  assertion_signed         = try(each.value.assertion_signed, true)
  signature_algorithm      = try(each.value.signature_algorithm, "RSA_SHA256")
  digest_algorithm         = try(each.value.digest_algorithm, "SHA256")
  honor_force_authn        = try(each.value.honor_force_authn, false)
  attribute_statements     = try(each.value.attribute_statements, [])
}
