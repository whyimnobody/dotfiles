# Cloud CLI workflow (AWS, GCP, Azure)

## Identity and context checks

Run before any write operation:

1. AWS: `aws sts get-caller-identity` and `aws configure list`
2. GCP: `gcloud auth list` and `gcloud config list`
3. Azure: `az account show`

## Region/project/subscription guardrails

1. Set explicit region for commands that support it.
2. Set explicit project (GCP) or subscription (Azure).
3. Prefer named profiles/service principals over implicit local defaults.

## Safe execution pattern

1. Read/list/describe resources first.
2. Use dry-run or what-if options when available.
3. Apply smallest scoped mutation command.
4. Re-read resource state and compare expected attributes.

## Troubleshooting pattern

1. Auth errors: re-check active account and token freshness.
2. Permission errors: identify missing IAM role/action exactly.
3. Not found errors: verify region/project/subscription mismatch first.
