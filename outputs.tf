output "saml_applications" {
  description = "Managed SAML application IDs keyed by catalog key."
  value = {
    for key, app in module.saml_application : key => {
      id    = app.id
      label = app.label
    }
  }
}
