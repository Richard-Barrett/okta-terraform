.PHONY: init fmt validate catalog plan apply

init:
	terraform init

fmt:
	terraform fmt -recursive

validate:
	terraform validate

catalog:
	python3 -m pip install -q jsonschema && python3 scripts/validate_catalog.py

plan:
	terraform plan

apply:
	terraform apply
