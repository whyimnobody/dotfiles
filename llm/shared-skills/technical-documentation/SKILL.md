---
name: technical-documentation
description: Produce clear, accurate technical documentation for software systems and teams. Use when asked to write or improve README files, architecture docs, API references, runbooks, onboarding guides, migration notes, design records, release notes, or operational playbooks.
---

Write technical documentation that is correct, actionable, and maintainable.

Focus on decision-grade clarity for engineers, operators, and stakeholders.

## Work Process

1. Define audience and purpose
- Identify who will use the document and what decision or action it must support.
- Clarify scope, prerequisites, and expected outcomes.

2. Gather source-of-truth inputs
- Prioritise code, configs, APIs, tests, and existing docs over assumptions.
- Mark unknowns explicitly and avoid inventing details.

3. Structure for navigation
- Lead with context, then procedures, then references.
- Use concise sections, stable headings, and scannable steps.

4. Write for execution
- Provide concrete commands, examples, inputs, and expected outputs.
- Include edge cases, failure handling, and rollback guidance where relevant.

5. Keep docs operationally useful
- Add ownership signals, update triggers, and maintenance expectations.
- Ensure the document can be used during incidents and handoffs.

## Documentation Standards

### Clarity
- Prefer plain, precise language over jargon-heavy prose.
- Define terms once and keep naming consistent with code and system concepts.
- Avoid ambiguity in steps, conditions, and responsibilities.

### Accuracy
- Tie statements to current implementation behaviour.
- Distinguish facts from recommendations.
- Surface assumptions and version-specific constraints.

### Actionability
- Every procedure should be runnable by a competent engineer.
- Include prerequisites, verification steps, and completion criteria.
- Document common failure modes and recovery paths.

### Maintainability
- Keep content modular and easy to update.
- Remove stale or duplicated guidance.
- Prefer references to canonical sources instead of copy-pasting volatile details.

## Common Artifacts

- README and contributor guides
- Architecture and system-overview docs
- API endpoint/reference docs
- Runbooks and incident-response playbooks
- Migration and rollout plans
- ADRs and technical decision records
- Release notes and change communication

## Hard Constraints

- Do not include unverified implementation claims.
- Do not bury critical warnings or prerequisites.
- Do not mix normative guidance and historical notes without clear labels.
- Do not ship documentation that cannot be followed end-to-end.

## Output Expectations

- Deliver structured, audience-specific documentation.
- Include practical examples and verification steps.
- Highlight known limitations, risks, and follow-up updates required.
