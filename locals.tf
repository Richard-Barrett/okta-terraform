locals {
  catalog   = jsondecode(file("${path.root}/catalog/saml_apps.json"))
  saml_apps = local.catalog.applications
}
