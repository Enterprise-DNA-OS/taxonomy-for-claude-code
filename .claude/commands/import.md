# import

Run `node scripts/taxonomy.mjs import poolparty <csv-or-rdf-json> --scheme= --source= --map= --actor= [--dry-run]` with the operator's actual values. Read the relevant scheme and term first. Use `--json` when composing a report.

Read docs/replace-poolparty.md. Inspect headers or RDF predicates. Run --dry-run first, show counts and ignored predicates, then import the approved source. Reconcile concepts and relationships; do not infer approval from the source export.

Report the evidence from the command. Preserve URI identities. Never invent a translation or approval. A release is an internal snapshot, never a publication. Drafts stay in drafts and nothing sends.
