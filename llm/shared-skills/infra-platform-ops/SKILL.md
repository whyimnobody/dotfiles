---
name: infra-platform-ops
description: End-to-end infrastructure operations across repositories using Docker, Ansible, OpenTofu, and cloud provider CLIs (AWS, GCP, Azure). Use when Codex needs to build, validate, plan, apply, troubleshoot, or document infra and infra-component changes with safe, repeatable, and accuracy-focused workflows.
---

# Infra Platform Ops

Use this skill to execute infrastructure work with strong preflight checks, deterministic command flow, and explicit verification.

## Core operating rules

1. Start with environment discovery before changing anything.
2. Prefer validate/lint/plan/dry-run paths before apply/deploy paths.
3. Scope actions to explicit files, stacks, workspaces, and accounts.
4. Surface assumptions early: account, region, environment, workspace, and backend state.
5. Record what was changed, how it was validated, and rollback path.

## Preflight checklist

Run this checklist at the beginning of every infra task:

1. Identify tooling and versions in the target repo.
2. Detect active cloud identity and default region/project/subscription.
3. Confirm remote state backend and workspace (for OpenTofu/Terraform-compatible flows).
4. Identify blast radius: affected modules, inventories, services, and environments.
5. Choose a safety mode:
- `read-only`: inspect and report only
- `plan-only`: generate plans/checks without applying
- `apply`: perform approved writes/deployments

## Standard execution sequence

Use this order unless the user asks otherwise:

1. `discover`: gather repo/tool/context facts
2. `validate`: syntax, formatting, linting, static checks
3. `plan`: diff-oriented preview (`tofu plan`, `ansible --check`, etc.)
4. `apply`: execute narrowly scoped changes
5. `verify`: confirm post-change state and health
6. `document`: summarize commands run, results, and next steps

## Tool workflows

Use only the workflow file needed for the current task to keep context lean:

- Docker: [references/docker.md](references/docker.md)
- Ansible: [references/ansible.md](references/ansible.md)
- OpenTofu: [references/opentofu.md](references/opentofu.md)
- Cloud CLIs (AWS/GCP/Azure): [references/cloud-clis.md](references/cloud-clis.md)

## Accuracy guardrails

1. Never run broad destructive commands without explicit user intent.
2. Prefer explicit selectors (`-target`, `--limit`, named profiles, explicit project/subscription).
3. Re-check identity and context before any apply step.
4. If state drift or lock conflicts appear, stop and explain recovery options before proceeding.
5. When commands fail, provide root-cause hypothesis plus the smallest safe next command.

## Output contract

For each infra task, provide:

1. Context detected (tool versions, environment, identity, workspace).
2. Commands executed (or planned) in order.
3. Validation evidence (key output points and status).
4. Risk level and rollback notes.
5. Follow-up actions if additional hardening is needed.
