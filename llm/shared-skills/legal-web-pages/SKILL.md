---
name: legal-web-pages
description: Generate, localize, and update product-facing legal pages for websites and web apps. Use when asked to draft or revise privacy policies, terms of use, terms of service, cookie policies, acceptable use policies, community guidelines, disclaimers, refund policies, subscription terms, consent notices, or similar legal copy that must match a specific jurisdiction, locale, spelling convention, or governing region.
---

Draft legal product pages that are accurate to the product's real behaviour, readable to end users, and explicit about jurisdictional scope.

Prioritise correctness over speed. Treat unsupported legal claims as risks, not writing opportunities.

## Workflow

1. Identify the page type and product surface
- Determine whether the request is for a privacy policy, terms of use, cookie policy, subscription terms, disclaimer, or another legal page.
- Determine whether the page applies to a marketing site, authenticated web app, mobile app, marketplace, SaaS product, community, or e-commerce flow.

2. Require jurisdiction and locale before drafting
- Ask for jurisdiction if it is not already provided.
- Ask for locale if it is not already provided.
- Capture the narrowest governing region that matters to the request: country, state or province, county, district, municipality, or other relevant subdivision.
- Capture the language and spelling convention needed for the final copy, such as `en-US`, `en-GB`, `en-ZA`, `fr-CA`, or `es-MX`.
- If the user gives conflicting geography and language signals, resolve that conflict before writing.

3. Gather product facts from source material
- Use the real product behaviour, settings, flows, pricing, data practices, support channels, and business model as the source of truth.
- Ask for missing facts that change legal meaning, especially data collection, cookies, payments, subscriptions, refunds, user-generated content, age gates, moderation, or cross-border transfers.
- Do not invent compliance mechanisms, regulators, retention periods, response timelines, or statutory rights.

4. Draft for legal-product fit
- Write for the actual product, not a generic company.
- Use headings and clauses that help users and operators find the right rule quickly.
- Reflect the requested jurisdiction and locale in terminology, spelling, date format, and governing-law language.
- Use placeholders only when the missing fact is specific and unavoidable, and label each placeholder clearly.

5. Separate facts, assumptions, and review items
- Mark assumptions explicitly.
- Call out clauses that require attorney or compliance review.
- Flag high-risk areas early: health, finance, insurance, children, employment, biometric data, AI decisioning, regulated communications, consumer credits, or marketplace liability.

## Output Requirements

- State the jurisdiction and locale used for the draft near the top of the response.
- If either jurisdiction or locale is missing, ask for them before producing final copy.
- Prefer publishable page copy over abstract commentary unless the user asks for analysis.
- Keep language plain, specific, and operationally useful to the product team.
- Include a short review note listing unresolved legal or factual gaps.

## Accuracy Rules

- Do not claim legal compliance unless the user provides a basis for that claim.
- Do not cite statutes, regulators, or mandatory disclosures from memory when accuracy is uncertain.
- Do not collapse multiple regions into one rule set unless the user explicitly wants a unified global draft.
- Do not treat spelling as cosmetic; locale controls legal readability and user trust.
- Do not present the output as a substitute for qualified legal counsel.

## Reference Use

Read [page-checklists.md](./references/page-checklists.md) when choosing sections, collecting missing inputs, or adapting the draft for privacy, terms, cookies, subscriptions, refunds, disclaimers, or community rules.
