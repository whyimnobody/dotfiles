# Ansible workflow

## Discover

1. `ansible --version`
2. `ansible-inventory -i <inventory> --list`
3. Inspect variable precedence sources used by the repo.

## Validate

1. Syntax check: `ansible-playbook -i <inventory> <playbook> --syntax-check`
2. Dry run: `ansible-playbook -i <inventory> <playbook> --check --diff`
3. Scope execution with `--limit <group_or_host>` whenever possible.

## Apply

1. Run targeted hosts first, then broaden scope.
2. Use tags (`--tags`, `--skip-tags`) for controlled rollouts.
3. Keep secrets in vault-backed paths only.

## Verify

1. Re-run in `--check` mode to confirm idempotence.
2. Run service state checks or task-specific probes.
3. Capture changed/failed counts for summary.

## Common recovery

1. Re-run failed hosts: `--limit @<retry_file>` where supported.
2. Narrow to failed tasks with tags.
3. Fix inventory/group vars drift before rerunning broad playbooks.
