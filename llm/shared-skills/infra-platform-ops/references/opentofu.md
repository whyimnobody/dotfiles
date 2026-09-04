# OpenTofu workflow

## Discover

1. `tofu version`
2. `tofu workspace list`
3. Confirm backend and state lock behavior from configuration.

## Validate

1. `tofu fmt -check -recursive`
2. `tofu init` (with correct backend config)
3. `tofu validate`
4. `tofu plan -out=tfplan` (optionally scoped via `-target`)

## Apply

1. Apply reviewed plan file: `tofu apply tfplan`
2. Avoid direct `tofu apply` without a reviewed plan in shared environments.
3. Use explicit var files and workspace selection.

## Verify

1. `tofu show`
2. `tofu state list`
3. Validate critical outputs: `tofu output`

## Common recovery

1. Lock issues: stop and resolve lock ownership first.
2. Drift: run fresh plan and isolate unexpected changes.
3. Import existing resources before managing them declaratively.
