# Move a vocabulary from PoolParty

PoolParty now sits in the Graphwise platform. Its [former price overview](https://www.poolparty.biz/priceoverview) redirects to a platform page asking for a quote, checked 27 October 2026. This desk replaces a bounded internal terminology workflow. It does not reproduce Graphwise's extraction, search, connected content systems or full ontology platform.

## Export first

Use the vendor's [RDF project export](https://help.poolparty.biz/pp2025r1/en/user-guide-for-knowledge-engineers/basic-features/import%2C-export-and-reporting-with-poolparty/poolparty-rdf-import---export/export-rdf-project-data.html): open Project, Export, RDF Project Export. Choose RDF/JSON and download the thesaurus data. Unzip the download locally if it is compressed. Do not choose JSON-LD, which is a different format. Export one scheme for each import. Save the original privately.

PoolParty also supports [tabular exports](https://help.poolparty.biz/en/user-guide-for-knowledge-engineers/basic-features/import%2C-export-and-reporting-with-poolparty/poolparty-excel---csv-tabular-import---export---overview.html). Choose CSV, inspect its actual headings and save a column map. There is no universal PoolParty CSV layout asserted here. Prefer RDF/JSON when preserving multilingual labels and relations matters.

## Start empty

Use a fresh DATA_DIR and run npm run migrate without the demo seed. Add a local scheme with the source scheme's URI, its owner and required languages. This example uses fictional identities. Replace them with yours.

```bash
node scripts/taxonomy.mjs add-scheme --code=OPERATIONS --name="Operations vocabulary" --uri=https://example.org/schemes/operations --owner="Editor" --languages=en --actor="Editor"
node scripts/taxonomy.mjs import poolparty imports/vocabulary.json --scheme=OPERATIONS --source=poolparty/project/scheme --actor="Editor" --dry-run
node scripts/taxonomy.mjs import poolparty imports/vocabulary.json --scheme=OPERATIONS --source=poolparty/project/scheme --actor="Editor"
```

One import command loads one extracted RDF/JSON export. For CSV:

```bash
node scripts/taxonomy.mjs import poolparty imports/terms.csv --scheme=OPERATIONS --source=poolparty/project/scheme --map=imports/columns.json --actor="Editor" --dry-run
```

Remove --dry-run to apply. The example CSV and map in examples are synthetic fixtures, not a captured vendor export.

## Mapping and reconciliation

CSV requires one row per concept. The map names the source columns for uri and label, and optionally lang, definition and broader. The label is preferred. Language defaults to en if omitted. The broader cell is an explicit pipe-separated list of parent URIs, not a hierarchy path or term name. If the export does not contain that shape, omit broader and import the relationships using RDF/JSON into an empty scheme instead. Duplicate concept URIs are rejected. CSV cannot carry multilingual repeated rows, alternative labels, hidden labels or arbitrary relationships.

RDF/JSON preserves concept URIs, label languages and kinds, broader/narrower and related relations. Narrower is normalised to its inverse broader relation. Definitions become one plain-text field; language-specific definition metadata remains in the raw evidence. Scheme membership must match the destination URI when the source supplies it. Missing relation targets, cycles and conflicting labels fail the whole batch. Unrecognised subjects and predicates are listed in the import result and retained in the raw import evidence. Review that list; retention is not conversion into working features.

Imports start as drafts with no owner, review date or approval. Set those deliberately. Source workflow decisions do not become local approvals. Source labels without a language default to en, so review the export before using that default. Owner assignments, requests, reviews and release history are new local operating records, not a migrated vendor workflow.

A repeat of the same source and identical content returns an unchanged count. A changed file containing an existing URI stops for reconciliation rather than overwriting edits. Missing rows never delete local terms. Preview runs validate and roll back every write, including audit records. Every applied batch keeps the source content and a digest.

Compare concept counts, language counts and relationships with the source. Inspect every ignored predicate. Test the review queue, translation gaps, collisions and release check. Bring the original export and a native database backup before switching the working process. There is no promised automatic conversion of custom ontologies or connected systems.

## Take your data out

```bash
node scripts/taxonomy.mjs export --out=exports/all-records.json
node scripts/taxonomy.mjs export-skos OPERATIONS --out=exports/vocabulary.rdf.json
```

The first command includes all eight domain relations, raw imports and releases. It is a portable evidence export, not a tested disaster-recovery restore tool. The second exports the supported active vocabulary as RDF/JSON, including draft terms. Check release readiness before using it externally. Existing output files are never overwritten. Exports and drafts can contain private records and use restrictive file permissions where supported; also secure the folder on Windows.
