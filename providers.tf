provider "okta" {
  org_name    = var.okta_org_name
  base_url    = var.okta_base_url
  client_id   = var.okta_client_id
  private_key = var.okta_private_key

  scopes = [
    "okta.apps.read",
    "okta.apps.manage",
  ]
}
