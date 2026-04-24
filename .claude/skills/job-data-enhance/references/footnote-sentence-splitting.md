# Footnote Sentence Splitting

Date: 2026-04-13

Issue:
Multiple sources for different sentences were attached together at the end of one paragraph.

Bad:
`문장 A이다. 문장 B이다.[1][2]`

Good:
`문장 A이다.[1] 문장 B이다.[2]`

Why it matters:
- The page renders both footnotes, but the mapping from sentence to source becomes ambiguous.
- Users read sentence-by-sentence, so footnotes should follow the sentence they support.
- Mixed behavior across nearby fields looks inconsistent and lowers trust.

Operational rule:
- If a prose field contains 2 or more sentences and uses different sources for different sentences, place each `[N]` at the end of the sentence it supports.
- Do not collapse different sentence-level sources into a single tail pattern like `[1][2]`.

Harness note:
- `scripts/validate-job-edit.cjs` was updated on 2026-04-13 to reject the common collapsed-tail pattern in multi-sentence prose fields.
