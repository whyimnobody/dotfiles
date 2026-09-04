---
name: playwright-testing
description: Use Playwright to reproduce browser issues, validate user flows end to end, generate or repair Playwright tests, and collect actionable failure artifacts. Use when the task involves web UI regression testing, browser bug reproduction, executable verification of frontend behaviour, or Playwright-based debugging and automation. Do not use for pure unit tests, backend-only validation, or design critique without browser execution.
---

Reproduce the behaviour in the browser first, then write or repair the smallest useful Playwright test that proves it.

Prefer maintainable tests, user-facing selectors, and high-signal failure artifacts over broad or fragile automation.

## Default Goals

1. Reproduce the issue or verify the flow in the browser.
2. Prefer robust, user-facing selectors.
3. Produce maintainable Playwright code.
4. Capture artifacts that make failures diagnosable.
5. Distinguish product bugs from test bugs.

## Workflow

1. Inspect the project
- Locate `package.json`.
- Locate `playwright.config.*`.
- Inspect existing tests under common paths such as `tests/`, `e2e/`, `playwright/`, and `specs/`.
- Inspect fixtures, helpers, page objects, auth setup, and global setup files.
- Detect the package manager from lockfiles and prefer existing project scripts over invented commands.

2. Choose the smallest useful test
- Start with one user flow, one browser, one environment, and one clear assertion.
- Avoid starting with a matrix unless the user specifically asks for coverage expansion.
- Reproduce the issue manually or through the smallest targeted test before widening scope.

3. Reuse the repo's conventions
- Reuse existing fixtures, stored auth state, page objects, and helper patterns when they already exist.
- Prefer local project structure over introducing a new abstraction layer.
- Avoid introducing a large page-object framework for a small or isolated test.

4. Write or repair the test
- Keep tests short, linear, and named for user intent.
- Assert user-visible outcomes first.
- Fix the narrow failing case before broadening coverage.

5. Debug with evidence
- Collect trace, screenshot, and other enabled artifacts on failures.
- Inspect the exact failing step before changing selectors or timing.
- Classify failures as selector drift, timing or state issue, environment or setup issue, or product regression.

## Working Rules

- Prefer existing Playwright config, fixtures, and auth helpers.
- Do not invent project-specific commands if package scripts or docs already define them.
- Do not hardcode credentials.
- Do not commit `waitForTimeout()` or manual sleeps except as temporary debugging aids that are removed before finalizing.
- Note missing stable selectors or inaccessible UI hooks as testability issues when they block robust automation.

## Output Requirements

- List files created or edited.
- Summarize what the test covers.
- State assumptions made.
- Provide the command for running the narrow affected test.
- Call out unresolved risks, likely flaky points, or evidence of a product bug.

## Reference Use

Read [playwright-guidance.md](./references/playwright-guidance.md) when selecting locators, choosing assertions, handling auth, deciding wait strategy, debugging failures, or shaping the final Playwright test.
