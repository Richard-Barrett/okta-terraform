# GMF Okta Terraform

Terraform repository for managing Okta SAML applications from a single flat catalog. Application requesters do not edit HCL; the FastAPI intake service changes `catalog/saml_apps.json` through pull requests.

## Repository model

```text
catalog/saml_apps.json
        |
        v
     locals.tf
        |
        v
for_each module instance
        |
        v
modules/okta-saml-application
        |
        v
   okta_app_saml
```

## 1. Prepare the Okta API Services app

In the Okta Admin Console:

1. Create an **API Services** app integration for Terraform.
2. Assign an admin role sufficient to manage the resources in scope. For a trial, Organization Administrator/Super Administrator is convenient; production should use least privilege/custom admin roles.
3. Grant `okta.apps.read` and `okta.apps.manage` under **Okta API Scopes**.
4. Set client authentication to **Public key / Private key**.
5. Generate or upload a key pair. Save the private key securely in PKCS#1 RSA format (`-----BEGIN RSA PRIVATE KEY-----`).
6. Copy the API Services application's Client ID.

## 2. Local Mac authentication

Keep the private key outside this repo:

```bash
mkdir -p ~/.config/okta
chmod 700 ~/.config/okta
# save your PEM as ~/.config/okta/terraform.key
chmod 600 ~/.config/okta/terraform.key
```

Then:

```bash
cp examples/local.env.example /tmp/okta-local.env
# edit /tmp/okta-local.env
source /tmp/okta-local.env
```

The Okta provider accepts either the private-key value or a path to the private-key file.

## 3. Test locally

The example catalog app is `INACTIVE` so you can safely inspect the plan first.

```bash
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan
```

When ready, replace/remove the example entry and add your actual application payload.

## 4. Flat catalog

`catalog/saml_apps.json` is the application contract. Governance metadata (`owner`, `requested_by`, `environment`, `sal`) lives next to the Okta configuration but is not blindly passed into the provider resource.

The FastAPI repository is designed to mutate this file and raise a PR.

## 5. CI secrets

Configure these GitHub Actions secrets in this repository:

- `OKTA_ORG_NAME`
- `OKTA_BASE_URL`
- `OKTA_CLIENT_ID`
- `OKTA_PRIVATE_KEY`

For `OKTA_PRIVATE_KEY`, store the PEM content as the secret rather than a local filesystem path.

## 6. State warning

Do **not** enable unattended merge-to-main applies while using local Terraform state. Configure HCP Terraform, AzureRM, S3, or another durable remote backend first. `terraform-apply.yml` is intentionally `workflow_dispatch` only until that is done.

## Provider version

This starter pins `okta/okta` to `6.15.0` for reproducibility. If you need to isolate a provider regression, `6.12.0` is also a documented June 10, 2026 release and can be tested by changing `versions.tf` and re-running `terraform init -upgrade`.
