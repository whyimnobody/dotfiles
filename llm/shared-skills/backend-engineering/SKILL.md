---
name: backend-engineering
description: Design and implement production-grade backend systems with strong architecture, reliability, and maintainability. Use when asked to build or modify APIs, services, data models, background jobs, integrations, migrations, security controls, performance-critical paths, or backend test suites.
---

Build robust backend solutions that are clear, correct, and maintainable.

Treat each request as production work: preserve behaviour, protect data integrity, and make operational impact explicit.

## Work Process

1. Define scope and constraints
- Identify user goal, domain boundaries, runtime environment, and compatibility requirements.
- Confirm contracts first: API shape, model invariants, side effects, and failure modes.

2. Model before implementation
- Design data flow, state transitions, and transactional boundaries.
- Choose patterns that fit the existing codebase and framework conventions.

3. Implement for correctness and operability
- Prefer explicit domain logic over hidden coupling.
- Keep interfaces stable and composable.
- Add clear error handling, logging, and idempotency where needed.

4. Validate deeply
- Add or update tests near changed behaviour.
- Check edge cases, regressions, and backwards compatibility.
- Document assumptions and migration implications.

## Engineering Standards

### Architecture
- Keep responsibilities separated: handlers/controllers, services, repositories/models, and background workflows.
- Encapsulate business rules in domain/service layers, not transport layers.
- Avoid leaking framework details into core domain decisions when practical.

### Data and Migrations
- Protect data integrity with constraints and transactional updates.
- Design safe migrations for live systems (backfills, defaults, phased rollouts).
- Preserve migration history; do not rewrite shipped migrations.

### APIs and Contracts
- Treat API contracts as stable interfaces.
- Use explicit validation and predictable error responses.
- Version or gate behavioural changes when compatibility risk exists.

### Performance and Reliability
- Identify hotspots before optimising.
- Optimise query patterns, batching, caching, and queue usage deliberately.
- Prefer deterministic behaviour under retries, partial failures, and concurrent access.

### Security
- Apply least privilege, input validation, output encoding, and secret hygiene.
- Guard authn/authz boundaries explicitly.
- Consider abuse paths, multi-tenant risk, and auditability.

### Testing
- Prioritise behaviour and regression tests over brittle implementation-detail tests.
- Cover unhappy paths, boundary conditions, and state transitions.
- Keep tests fast, deterministic, and readable.

## Hard Constraints

- Never trade correctness for speed without explicit user direction.
- Never make silent breaking changes to public interfaces.
- Never couple business-critical logic to environment-specific assumptions.
- Keep operational impact clear: migration risk, rollout plan, and fallback strategy.

## Output Expectations

- Provide complete backend code changes with tests where behaviour changes.
- Explain key tradeoffs and any residual risks.
- Include concrete verification steps for local/CI execution.
