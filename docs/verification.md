# Verification

npm test creates a disposable database, applies migrations twice, seeds twice and exercises all 35 CLI commands. It asserts label integrity, transitive hierarchy cycle rejection, related/hierarchy conflicts, approval invalidation, immutable release content through the CLI, import atomicity, repeated imports, changed-source refusal, export protection, drafts and escaped HTML. It also checks that every CLI command has an agent recipe.

The suite uses PGlite by default. TEST_DATABASE_URL can point at a fresh disposable Postgres database. It refuses a database that already has the concepts relation. Never use a business database for tests. DATABASE_URL alone is deliberately ignored by the test suite.

The manual GitHub workflow covers Node 20 and 22 on Windows and Linux, plus Postgres 17. Actual execution results are recorded in the delivery report; a workflow definition alone is not proof of a pass.

The seed is fictional and idempotent. Dates are relative to the day it is first loaded. Subsequent seeds do not move old review dates or overwrite operator changes. The demo deliberately includes overdue editorial work, missing translations and a colliding synonym.

No vendor account, customer export, live connector, hosted multiuser deployment or external publishing was tested. Fixtures are synthetic. Read docs/replace-poolparty.md before importing real exports.
