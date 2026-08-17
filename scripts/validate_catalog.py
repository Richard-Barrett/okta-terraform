#!/usr/bin/env python3
import json
import sys
from pathlib import Path

try:
    import jsonschema
except ImportError:
    print("Install validator: pip install jsonschema", file=sys.stderr)
    raise

root = Path(__file__).resolve().parents[1]
schema = json.loads((root / "catalog/saml_apps.schema.json").read_text())
catalog = json.loads((root / "catalog/saml_apps.json").read_text())
jsonschema.Draft202012Validator(schema, format_checker=jsonschema.FormatChecker()).validate(catalog)
print(f"Catalog valid: {len(catalog['applications'])} application(s)")
