# Playwright Guidance

Use this reference when writing or repairing tests, reproducing a UI issue, or debugging a failing Playwright run.

## Selector Order

Prefer selectors in this order:

1. `getByRole`
2. `getByLabel`
3. `getByPlaceholder`
4. `getByText`
5. `getByTestId`
6. CSS selectors only as a last resort

Rules:

- Prefer selectors tied to accessible UX.
- Avoid brittle `nth-child` chains.
- Avoid styling-class selectors unless they are stable and intentional.
- If stable selectors are missing, note that as a product or testability issue.

## Assertion Policy

Prefer user-visible outcomes such as:

- URL changes
- Headings
- Alerts or toasts
- Table rows
- Form values
- Enabled or disabled states

Use network-visible outcomes only when UI evidence is insufficient.

Avoid asserting implementation details.

## Waiting Policy

- Rely on Playwright locators and assertions first.
- Avoid `waitForTimeout()` except for temporary debugging.
- Avoid manual sleeps in committed tests.

Use explicit waits only for:

- navigation
- download events
- popup creation
- known async state transitions not covered by locator assertions

## Auth Policy

- Prefer existing auth fixtures or stored state.
- Do not repeat full UI login in every test unless the login flow itself is under test.
- If creating auth setup, isolate it in setup files or fixtures.
- Keep secrets out of test files.
- Never hardcode credentials.

## Failure Artifacts

Collect when useful or available:

- Playwright trace
- Screenshot
- Video
- HTML report or focused test output
- Exact failing step and assertion

Inspect trace before changing selectors blindly.

## Repair Loop

When a test fails:

1. Classify the failure.
2. Inspect traces and existing helpers.
3. Make the minimal fix.
4. Rerun only the affected test.
5. Widen scope only after the narrow case passes.

## Preferred Test Shape

```ts
import { test, expect } from '@playwright/test';

test('user can complete checkout', async ({ page }) => {
  await page.goto('/');

  await page.getByRole('link', { name: /shop/i }).click();
  await page.getByRole('button', { name: /add to cart/i }).click();
  await page.getByRole('link', { name: /cart/i }).click();
  await page.getByRole('button', { name: /checkout/i }).click();

  await expect(page.getByRole('heading', { name: /checkout/i })).toBeVisible();
});
```
