# Taxonomy for Claude Code

Keep the words your business agrees on, and the evidence behind each change. An owned database for controlled vocabularies, multilingual labels, hierarchy review and internal release records. Built by Enterprise DNA.

| Do it yourself | We customise it | We run it for you |
|---|---|---|
| Free, MIT. Install the database and command recipes. | Your terms, fields, review rules and PoolParty export mapping. A web front end or different stack if wanted. | Installed and operated through Omni by Enterprise DNA. One setup fee, then a retainer. |

[Get your version built](https://enterprisedna.co/omni/book/?offer=replace-software&utm_source=github&utm_campaign=poolparty)

## Start with the weekly work

Review terms, fill translation gaps, resolve colliding labels, decide editorial requests and prepare an internal release snapshot. Definitions and relations are records you can inspect. Changing a term invalidates its approval. A release waits for current approvals, resolved requests, complete required languages and a clean quality check.

PoolParty is now part of Graphwise. Its [pricing link](https://www.poolparty.biz/priceoverview) redirects to the platform page asking for a quote, checked 27 October 2026. This free desk covers the internal vocabulary work; semantic extraction, search services, graph editing and live content connections are separate scope for your version.

## Quick start

Node 20 or newer. Works with Claude Code, Codex, OpenCode or Cursor. No paid model API is needed by the CLI.

```bash
npm install
npm run demo
node scripts/taxonomy.mjs review-terms
node scripts/taxonomy.mjs translation-gaps
node scripts/taxonomy.mjs release-check OPS --json
npm run view
npm run docs
npm test
```

The demo contains fictional records, overdue requests and missing translations. For your business, use a fresh DATA_DIR and run npm run migrate without seeding. DATABASE_URL selects a dedicated Postgres service; otherwise PGlite runs locally. One process at a time uses the embedded database. Shared use needs a secured server and managed backups.

## Commands

Prefix each with node scripts/taxonomy.mjs. Every command supports --json. Partial ids and case-insensitive names work; ambiguous matches list candidates and exit with status 1.

- `help`
- `schemes`
- `concepts`
- `taxonomy-week`
- `review-terms`
- `translation-gaps`
- `label-collisions`
- `editorial-queue`
- `attention`
- `compliance`
- `insights`
- `show <concept>`
- `hierarchy <concept>`
- `history <scheme>`
- `release-check <scheme>`
- `releases <scheme>`
- `add-scheme --code= --name= --uri= --owner= --languages=en,mi --actor=`
- `add <scheme> --code= --uri= --label= --lang=en --definition= --owner= --review-due= --actor=`
- `edit-term <concept> --definition= --owner= --review-due= --note= --actor=`
- `add-label <concept> --kind=pref|alt|hidden --lang= --value= --actor=`
- `remove-label <label-id> --note= --actor=`
- `relate <concept> --to= --kind=broader|related --actor=`
- `unrelate <relation-id> --note= --actor=`
- `request-change <concept> --title= --owner= --due= --actor=`
- `decide-request <request-id> --decision=accepted|rejected --note= --actor=`
- `approve <concept> --review-due= --note= --actor=`
- `retire <concept> --replacement= --note= --actor=`
- `log <concept> --note= --actor=`
- `record-release <scheme> --version= --note= --actor=`
- `import poolparty <csv-or-rdf-json> --scheme= --source= --map= --actor= [--dry-run]`
- `export --out=<new.json>`
- `export-skos <scheme> --out=<new.json>`
- `weekly-review`
- `draft-vocabulary <scheme>`
- `draft-release-note <scheme>`

35 CLI commands with matching recipes, plus /customise and /new-view. Mutations require an actor name. Label and relation removals preserve the before value in the history.

## Bring your vocabulary

PoolParty exports RDF/JSON and CSV. One import command reads a single unzipped RDF/JSON export or a mapped CSV. Preview first, inspect ignored predicates, apply, and reconcile counts. Imported terms await an owner, a review date and approval.

```bash
node scripts/taxonomy.mjs import poolparty examples/poolparty.csv --scheme=GUIDES --source=demo/terms --map=examples/column-map.json --actor=Editor --dry-run
node scripts/taxonomy.mjs export --out=exports/taxonomy.json
```

The examples are synthetic, not a universal vendor layout. Repeat imports skip identical batches. Changed source records stop for reconciliation. Raw evidence is retained. [Mapping and switch guide](docs/replace-poolparty.md).

## Ten questions to ask

The insights command answers all ten from current records. These combine your editorial rules and working history. They do not claim the vendor can never produce a similar report.

1. Which overdue terms also have open requests?
2. Which language gaps belong to overdue terms?
3. Which labels mean more than one thing?
4. Which active terms lack a definition?
5. Which active terms have no owner?
6. Which active terms point to a retired term?
7. Which terms have more than one broader parent?
8. Which draft terms have gone untouched for a month?
9. Which requests are overdue, grouped by owner?
10. Which schemes have no recorded release?

## Your first hour: ten things to ask for

1. Put our business name, logo and colours in brand.json.
2. Add our vocabulary with its existing scheme URI.
3. Set the languages our editors actually maintain.
4. Preview a saved PoolParty export and inspect the ignored fields.
5. Reconcile the imported term and relationship counts.
6. Assign an owner and review date to each active term.
7. Find labels that identify more than one thing.
8. Record the editorial requests needed to resolve those clashes.
9. Read the release blockers before recording a baseline.
10. Add our review rule through /customise and test it.

## Documents and views

Three read-only dashboards show the week, quality gaps and review work. npm run docs renders a vocabulary register and editorial review brief for each scheme, plus a release record for each recorded release. brand.json controls the business name, logo and colours. Draft vocabulary reviews and release notes stay in drafts. Nothing sends or publishes.

## Boundaries

This is one organisation's internal terminology desk. It supports one scheme per concept, stable HTTP(S) URIs, preferred/alternative/hidden labels, broader and related links, editorial requests and release snapshots. Standards checks cite [W3C SKOS](docs/compliance.md); extra review and hierarchy restrictions are labelled local rules. It is not a full semantic platform or legal compliance certification.

There is no browser editing, mobile application, offline shared capture, authenticated approval, attachment store, public portal, semantic extraction, reasoning engine or live content connection. See [why no front end](docs/why-no-front-end.md).

Public database roles have no access by default. A database owner can bypass those restrictions and application rules, including audit history. Actor labels are not verified identities. Use protected credentials, secured hosting and native backups. JSON exports contain private source records and are not a tested restore system. RDF/JSON export includes active draft terms, so check readiness before external use. Generated files use restrictive permissions where supported; secure Windows folders separately.

[Verification scope](docs/verification.md). MIT. Built by Enterprise DNA.
