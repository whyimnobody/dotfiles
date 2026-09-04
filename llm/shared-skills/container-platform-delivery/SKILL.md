---
name: container-platform-delivery
description: Produce and update practical DevOps delivery artefacts for containerized applications and platform operations. Use when asked to create, revise, or troubleshoot Dockerfiles, docker-compose files, Helm charts, Kubernetes manifests, k3s deployments, OpenTofu/Terraform-compatible infra config, SOPS-encrypted secret workflows, CI/CD deployment config, or infra documentation, especially when the work should follow the repo standard, prefer simple defaults, and ask for the missing deployment facts up front.
---

Build deployable artefacts that match the repository's existing platform conventions and keep operational complexity low unless the user asks for something more advanced.

Prefer the simplest viable implementation that is functional, maintainable, and easy to operate.

## Core Rules

1. Discover project standards before inventing structure
- Inspect the repository for existing Dockerfiles, Compose files, Helm charts, Kubernetes manifests, OpenTofu modules, secret handling, CI config, and docs.
- Reuse the repo's naming, layout, image strategy, chart structure, label conventions, and environment patterns when they exist.
- If the repo already standardizes on one tool, prefer that tool over introducing an alternative.

2. Ask for the missing facts that materially affect the artefact
- Ask early for target runtime, deployment target, environment set, ports, ingress, domain, storage, secret source, image registry, CI system, and rollout expectations when those details are missing.
- Ask whether the target is local development, preview, staging, production, or a multi-environment setup.
- Ask for the application's build and run commands when they cannot be inferred safely.
- Ask once, with a focused set of questions that reduces rework.

3. Default to simple, good-enough operations
- Prefer a single container before splitting services without a clear need.
- Prefer straightforward health checks, resource requests, and probes over over-tuned settings.
- Prefer standard base images, explicit ports, and readable configuration.
- Prefer `Deployment` plus `Service` plus `Ingress` as a baseline Kubernetes shape unless the workload clearly needs something else.

4. Follow repo standard over tool preference
- Use Helm only when the repo already uses Helm or the user explicitly wants charts.
- Use raw manifests when the repo uses raw manifests or the scope is small.
- Use Compose for local multi-service workflows unless the repo has a different dev standard.
- Use OpenTofu and SOPS only when the repo or request indicates they are part of the stack.

5. Produce artefacts that can actually be used
- Include only the files needed for the requested scope.
- Keep values, defaults, and comments tight and operational.
- Document assumptions, required secrets, and apply or deploy steps.

## Delivery Workflow

1. Discover context
- Identify the application type, language/runtime, build system, deploy target, and environment model.
- Inspect existing infra artefacts and platform docs before drafting new ones.

2. Confirm target outcome
- Determine whether the user needs local development, cluster deployment, packaging, secret management, infrastructure provisioning, or documentation.
- Determine whether the task is greenfield, migration, or incremental change.

3. Resolve critical unknowns
- If missing details would force guesswork, ask for them before generating final artefacts.
- If the repo answers the question, use the repo instead of asking.

4. Generate the smallest viable artefact set
- Create only the files that move the requested outcome forward.
- Avoid speculative extras such as service meshes, autoscaling, operators, sidecars, or complex overlays unless required.

5. Verify coherence
- Ensure ports, image names, environment variables, probe paths, volume mounts, selectors, and references line up across files.
- Ensure docs match the generated config and commands.

## Output Requirements

- State the detected or assumed repo standard near the top of the response.
- State the target platform and environments covered.
- List unresolved inputs that would improve production fitness.
- Prefer concrete files and commands over abstract platform advice.

## Accuracy and Simplicity Guardrails

- Do not introduce tools that the repo does not use unless the user asks for them or no standard exists.
- Do not generate secret values or pretend encryption state exists.
- Do not assume cloud-specific resources for a generic Kubernetes request.
- Do not add operational complexity to look comprehensive.
- Do not skip questions when the answer changes the resulting artefact shape.

## Reference Use

Read [artifact-checklists.md](./references/artifact-checklists.md) when selecting files, gathering missing inputs, or deciding between Docker, Compose, Helm, Kubernetes, k3s, OpenTofu, SOPS, CI config, and infra documentation.
