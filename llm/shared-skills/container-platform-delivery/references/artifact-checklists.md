# Container Platform Delivery Checklists

Use this reference to choose the right artefacts and gather the missing deployment facts before generating them.

## Intake

Collect or infer these first:

- Application name and purpose
- Language/runtime and package manager
- Build command and start command
- Exposed ports
- Background workers, cron jobs, migrations, or one-off jobs
- Target platform: Docker, Compose, k3s, Kubernetes, Helm, OpenTofu, SOPS, CI/CD
- Environments: local, preview, staging, production
- Registry, namespace, cluster, and domain details if relevant
- Secret source and configuration strategy
- Storage, database, cache, queue, and third-party dependencies

## Repo Standard Discovery

Look for:

- Existing `Dockerfile`, `.dockerignore`, and image naming patterns
- Existing `compose.yaml` or `docker-compose.yml`
- Existing `charts/`, `helmfile`, `values*.yaml`, or release naming conventions
- Existing `k8s/`, `manifests/`, `base/`, `overlays/`, or GitOps layout
- Existing `tofu/`, `terraform/`, `infra/`, or environment directories
- Existing SOPS config, age keys, KMS usage, or encrypted secret files
- Existing deployment docs and CI workflows

If a standard exists, extend it instead of replacing it.

## Dockerfile

Usually define:

- Base image chosen for compatibility and size
- Build stages only when they reduce runtime size or improve reproducibility
- Working directory
- Dependency install steps
- Copy order that preserves build caching
- Runtime user, port, and entrypoint or command
- Health check only when the runtime supports a clear signal

## Compose

Usually define:

- Main app service
- Required dependent services only
- Volumes only where persistence matters
- Environment variable sources
- Health checks and dependency conditions when needed
- Local developer commands and exposed ports

Prefer Compose for local multi-service development, not cluster production, unless the user explicitly asks otherwise.

## Kubernetes / k3s

Usually define:

- Namespace if the repo or platform expects one
- Deployment for stateless workloads
- StatefulSet only when storage identity matters
- Service for network access
- Ingress when external access is needed
- ConfigMap and Secret references without embedding secret values
- Requests and limits with conservative defaults
- Readiness and liveness probes when the app exposes stable health endpoints

Prefer standard upstream Kubernetes resources that also work on k3s unless the request is k3s-specific.

## Helm

Use Helm when the repo already uses it or the user asks for reusable packaging.

Usually include:

- `Chart.yaml`
- `values.yaml`
- Template files for deployment, service, ingress, and optional config
- Minimal helper templates only when they reduce repetition
- Clear values for image, resources, env, ingress, and service settings

Avoid chart abstraction that hides the actual deployment model.

## OpenTofu / Terraform-Compatible Config

Usually define:

- Providers and versions only if the repo standard requires pinning here
- Variables with sensible defaults when safe
- Outputs that help downstream deployment or docs
- Environment-specific values in the repo's established pattern

Prefer extending existing modules and directory layout over inventing a new stack shape.

## SOPS and Secrets

Usually cover:

- Which secrets exist and where they are consumed
- Encryption mechanism already used by the repo or platform
- File naming and placement conventions
- Documentation for how operators rotate or update secrets

Never fabricate encrypted payloads just to complete a template.

## Documentation

Usually include:

- What was generated
- Required prerequisites
- Build, run, deploy, and rollback commands
- Secret and config expectations
- Environment-specific notes
- Follow-up work for production hardening

## Decision Defaults

- Prefer one artefact set per requested target, not every possible target.
- Prefer local-dev Compose plus cluster manifests only when the user clearly needs both.
- Prefer repo conventions over generic best-practice templates.
- Prefer explicit defaults over magic automation.
