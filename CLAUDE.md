# Taxonomy for Claude Code

Run the internal terminology desk for the operator's organisation. Ask for the intended scheme when it is unclear. Read records before changing them. Every answer starts with CLI evidence.

## Routing

| Job | Command |
|---|---|
| help | node scripts/taxonomy.mjs help  |
| schemes | node scripts/taxonomy.mjs schemes  |
| concepts | node scripts/taxonomy.mjs concepts  |
| taxonomy-week | node scripts/taxonomy.mjs taxonomy-week  |
| review-terms | node scripts/taxonomy.mjs review-terms  |
| translation-gaps | node scripts/taxonomy.mjs translation-gaps  |
| label-collisions | node scripts/taxonomy.mjs label-collisions  |
| editorial-queue | node scripts/taxonomy.mjs editorial-queue  |
| attention | node scripts/taxonomy.mjs attention  |
| compliance | node scripts/taxonomy.mjs compliance  |
| insights | node scripts/taxonomy.mjs insights  |
| show | node scripts/taxonomy.mjs show <concept> |
| hierarchy | node scripts/taxonomy.mjs hierarchy <concept> |
| history | node scripts/taxonomy.mjs history <scheme> |
| release-check | node scripts/taxonomy.mjs release-check <scheme> |
| releases | node scripts/taxonomy.mjs releases <scheme> |
| add-scheme | node scripts/taxonomy.mjs add-scheme --code= --name= --uri= --owner= --languages=en,mi --actor= |
| add | node scripts/taxonomy.mjs add <scheme> --code= --uri= --label= --lang=en --definition= --owner= --review-due= --actor= |
| edit-term | node scripts/taxonomy.mjs edit-term <concept> --definition= --owner= --review-due= --note= --actor= |
| add-label | node scripts/taxonomy.mjs add-label <concept> --kind=pref / alt / hidden --lang= --value= --actor= |
| remove-label | node scripts/taxonomy.mjs remove-label <label-id> --note= --actor= |
| relate | node scripts/taxonomy.mjs relate <concept> --to= --kind=broader / related --actor= |
| unrelate | node scripts/taxonomy.mjs unrelate <relation-id> --note= --actor= |
| request-change | node scripts/taxonomy.mjs request-change <concept> --title= --owner= --due= --actor= |
| decide-request | node scripts/taxonomy.mjs decide-request <request-id> --decision=accepted / rejected --note= --actor= |
| approve | node scripts/taxonomy.mjs approve <concept> --review-due= --note= --actor= |
| retire | node scripts/taxonomy.mjs retire <concept> --replacement= --note= --actor= |
| log | node scripts/taxonomy.mjs log <concept> --note= --actor= |
| record-release | node scripts/taxonomy.mjs record-release <scheme> --version= --note= --actor= |
| import | node scripts/taxonomy.mjs import poolparty <csv-or-rdf-json> --scheme= --source= --map= --actor= [--dry-run] |
| export | node scripts/taxonomy.mjs export --out=<new.json> |
| export-skos | node scripts/taxonomy.mjs export-skos <scheme> --out=<new.json> |
| weekly-review | node scripts/taxonomy.mjs weekly-review  |
| draft-vocabulary | node scripts/taxonomy.mjs draft-vocabulary <scheme> |
| draft-release-note | node scripts/taxonomy.mjs draft-release-note <scheme> |

Each command has a recipe in .claude/commands. /customise changes fields and rules through a tested migration. /new-view adds a read-only report.

## Rules

- Never send, publish or operate a connected content system. A release is an internal snapshot.
- Obtain explicit approval before removing a label or relation. Removal retains an audit event. Prefer retirement for a concept.
- Never invent a translation, definition, review decision or source URI. Show ambiguous candidates.
- Inspect source exports and preview imports. Reconcile ignored predicates and counts.
- Approvals refer to the current term. Editing it returns it to review.
- The actor name is a recorded label, not verified identity. Database-owner access needs protection.
- Keep raw exports, drafts, credentials and working databases out of git.
- Do not seed a working database. Tests must use disposable data.
- Read docs/compliance.md and docs/replace-poolparty.md before changing rule or import behaviour.

## Files

scripts/taxonomy.mjs is the one CLI. supabase/migrations contains ordered migrations. views.json and documents.json define read-only output. brand.json controls business branding. DATABASE_URL selects Postgres; otherwise DATA_DIR selects the local PGlite folder.

Omni by Enterprise DNA installs, customises and runs this system: https://enterprisedna.co/omni/instead-of/poolparty
