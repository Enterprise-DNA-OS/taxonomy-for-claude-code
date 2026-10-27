# Verification

npm test creates a disposable database, applies migrations twice, seeds twice and exercises all 35 CLI commands. It asserts label integrity, transitive hierarchy cycle rejection, related/hierarchy conflicts, approval invalidation, immutable release content through the CLI, import atomicity, repeated imports, changed-source refusal, export protection, drafts and escaped HTML. It also checks that every CLI command has an agent recipe.

The suite uses PGlite by default. TEST_DATABASE_URL can point at a fresh disposable Postgres database. It refuses a database that already has the concepts relation. Never use a business database for tests. DATABASE_URL alone is deliberately ignored by the test suite.

The manual GitHub workflow covers Node 20 and 22 on Windows and Linux, plus Postgres 17. Actual execution results are recorded in the delivery report; a workflow definition alone is not proof of a pass.

The seed is fictional and idempotent. Dates are relative to the day it is first loaded. Subsequent seeds do not move old review dates or overwrite operator changes. The demo deliberately includes overdue editorial work, missing translations and a colliding synonym.

No vendor account, customer export, live connector, hosted multiuser deployment or external publishing was tested. Fixtures are synthetic. Read docs/replace-poolparty.md before importing real exports.

## Delivery checks on 27 October 2026

The full suite passed locally on Linux with Node 22 against both PGlite and a disposable native Postgres instance. The demo and HTML rendering passed. Desktop and mobile page checks confirmed noindex metadata, all three paths, attributed booking links and working demo tabs.

[GitHub run 40599746234](https://github.com/Enterprise-DNA-OS/taxonomy-for-claude-code/actions/runs/40599746234) was requested for Windows/Linux on Node 20/22 and Postgres 17. GitHub refused to start all jobs because recent account payments failed or the spending limit needs increasing. No job steps ran. Windows and Node 20 execution are therefore unverified; this is not a passing cross-platform result.
