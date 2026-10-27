# Terminology rules and their sources

Checked 27 October 2026. These checks cover the supported vocabulary model. They are not a full RDF validator, a legal compliance certificate or a substitute for an editor's decision. Taxonomy work here has no statutory notice period. The review dates and release criteria are local operating rules.

| Rule | What the desk does | Source |
|---|---|---|
| SKOS S13 | A literal in the same language cannot be both preferred, alternative or hidden on one concept. A database uniqueness constraint rejects it. | [W3C SKOS lexical labels](https://www.w3.org/TR/skos-reference/#labels) |
| SKOS S14 | At most one preferred label per concept per language. A database index rejects a second one. Missing labels in the scheme's required languages are a separate local rule. | [W3C SKOS lexical labels](https://www.w3.org/TR/skos-reference/#labels) |
| SKOS S27 | A related relation cannot also join a pair connected by a transitive broader path. Both relation additions and import check this. | [W3C SKOS semantic relations](https://www.w3.org/TR/skos-reference/#semantic-relations) |
| Related symmetry | Related links are stored once in canonical id order and exported in both directions. | [W3C SKOS semantic relations](https://www.w3.org/TR/skos-reference/#semantic-relations) |
| LOCAL-CYCLE | Reject self-links and hierarchy cycles. SKOS does not prohibit every hierarchy cycle; this stricter rule is ours. | [W3C SKOS cycles discussion](https://www.w3.org/TR/skos-reference/#semantic-relations) |
| LOCAL-EDITORIAL | Require a definition, owner and current review date before approval. Required languages must each have a preferred label. | Local policy in scripts/taxonomy.mjs |
| LOCAL-COLLISION | Identical labels, compared case-insensitively, across active terms in the same language require resolution before release. This is stricter than SKOS. | Local policy in scripts/taxonomy.mjs |
| LOCAL-RELEASE | Require at least one active concept, approval of all active concepts, current review dates, resolved requests and no active links to retired terms. | Local policy in scripts/taxonomy.mjs |

Changes to term definitions, owners, dates, labels and relations invalidate affected approvals. Relation changes invalidate both ends. New editorial requests and their decisions invalidate the term's approval. Retiring a term retains its URI and names a replacement. Active incoming links remain visible as blockers until reviewed and removed or replaced.

The actor is an operator-supplied name, not an authenticated signature. A release records a dated copy of the scheme, concepts, labels and relations. It does not publish anything. Database owners can bypass application rules, change audit records and alter snapshots. Restrict owner credentials and use database backups for independent recovery.

The supported model is a single scheme per concept, HTTP(S) identities, preferred/alternative/hidden labels, one plain-text definition, broader links and related links. Two- or three-letter language tags with subtags are accepted. Language tags are normalised to lowercase. Import retains unsupported source content in the evidence record and reports ignored subjects and predicates. It does not implement SKOS-XL, every SKOS mapping relation, arbitrary ontologies or reasoning.
