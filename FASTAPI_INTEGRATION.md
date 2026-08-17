# FastAPI Integration Contract

The companion `gmf-okta-saml-api` repository should be configured with:

```text
GITHUB_REPO=gmf-okta-terraform
GITHUB_CATALOG_PATH=catalog/saml_apps.json
```

The API creates a branch, updates only the catalog, and opens a PR. This repository owns all Terraform execution and Okta credentials.
