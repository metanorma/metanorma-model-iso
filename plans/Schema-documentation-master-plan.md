# Plan — schema documentation for `metanorma-model-iso` (issue #90)

## Context

The audience is **metanorma developers**, not end users. `metanorma.org` covers end users; its `develop/` subfolder covers dev-side config; this work covers the **XML schemas themselves**, which neither of those does. Relaton ultimately folds into the same structure.

The schemas that matter, conceptually, are four: `biblio < relaton < isodoc (= metanorma) < isodoc-presentation`. As **grammar artefacts** in `grammars/`, however, those four conceptual layers correspond to a wider set of `.rnc` files that need separate documentation trees:

- `basicdoc.rnc` — BasicDocument foundation. Conceptually part of the same subject matter as `isodoc.rnc` (document content), but a separate artefact in `grammars/`. The split is irritating conceptually but the grammar reality, so the documentation preserves it.
- `biblio.rnc` — base Relaton citation model. **Grammar-incomplete standalone**: references `BasicBlockNoId` (and likely other patterns) defined in `basicdoc.rnc` without including it. Expected to be composed with basicdoc at assembly time. The SPA needs to handle these cross-grammar references gracefully (emit cross-grammar links into the basicdoc SPA, not choke).
- `biblio-standoc.rnc` — biblio expanded to **document metadata** (the bibliographic description of a standards document itself, used through `bibdata`). Includes `biblio.rnc`. Distinct from relaton-as-conceptual-layer — see mapping below.
- `biblio-presentation.rnc` — Presentation form of metadata. Includes `biblio.rnc`.
- `isodoc.rnc` — StanDoc semantic document model. Includes `basicdoc.rnc` and `reqt.rnc` (the requirements model).
- `isodoc-presentation.rnc` — Presentation form. Includes `isodoc.rnc`.

Grammar dependency graph (verified by `include` chains and unresolved-reference inspection):

```
basicdoc.rnc  ←  biblio.rnc (via unresolved refs)
basicdoc.rnc  ←  isodoc.rnc (via include)
biblio.rnc    ←  biblio-standoc.rnc, biblio-presentation.rnc (via include)
reqt.rnc      ←  isodoc.rnc (via include)
isodoc.rnc    ←  isodoc-presentation.rnc (via include)
```

The deprecation distinction matters and is easy to get wrong:

- **Document-level flavour grammars** — `isostandard.rnc` / `isostandard-compile.rnc` / `isostandard-amd.rnc` and the flavour wrappers (`iso.rnc`, `bsi.rnc`, `iec.rnc`, `ietf.rnc`, `nist.rnc`, `cc.rnc`, `m3d.rnc`, `plateau.rnc`, `itu.rnc`, `jis.rnc`, `ieee.rnc`, `iho.rnc`, `bipm.rnc`, `gbstandard.rnc`, `ribose.rnc`, `generic.rnc`, `ogc.rnc`) — **are deprecated**. They will go away, with two narrow exceptions: `ietf` attribute customisation, and `nist` custom elements pending upstream refactoring.
- **Per-flavour relaton grammars** — `relaton-iso.rnc`, `relaton-bsi.rnc`, `relaton-iec.rnc`, `relaton-ieee.rnc`, `relaton-ietf.rnc`, `relaton-nist.rnc`, `relaton-itu.rnc`, `relaton-jis.rnc`, `relaton-bipm.rnc`, `relaton-plateau.rnc`, `relaton-ogc.rnc`, the rest of the family — **are not deprecated**. Per-SDO bibliographic metadata genuinely differs (ISO has TC/SC structure, IEEE has subcommittees, etc.) and that's legitimate variation worth preserving. They are first-class current grammar artefacts.

The plan therefore targets the grammar-artefact set above (excluding the deprecated document-level flavour wrappers) plus the `relaton-*.rnc` family. For Phase 0 the relaton flavour set is represented by `relaton-iso` as an exemplar; the rest follow the same parallel pattern and can be added once the exemplar works.

#### Conceptual layers ↔ grammar artefact mapping

The four conceptual layers don't map one-to-one onto the grammar artefacts; the relationship has to be spelled out before salvage so the documentation organisation doesn't drift apart from the source structure. Spelled out:

| Conceptual layer | Subject matter | Grammar artefact(s) | Status |
|---|---|---|---|
| `biblio` | base citation model | `biblio.rnc` | current |
| `relaton` | biblio expanded to flavour-specific bibliographic data | per-flavour `relaton-iso.rnc`, `relaton-ietf.rnc`, `relaton-bsi.rnc`, … (the whole relaton-*.rnc family) | **current and first-class** — per-SDO citation data legitimately differs, preserved. For Phase 0 represented by `relaton-iso` as an exemplar; rest follow same pattern |
| `isodoc` (= metanorma) | document content | `basicdoc.rnc` + `isodoc.rnc` (same subject matter split across two grammar artefacts) | current |
| `isodoc-presentation` | presentation form of document content | `isodoc-presentation.rnc` | current |

Sideways from the four-layer ladder, with its own per-element documentation tree:

| Not a conceptual layer in the ladder | Subject matter | Grammar artefact | Status |
|---|---|---|---|
| (biblio expanded for document metadata) | bibliographic description of standards documents, used through `bibdata` | `biblio-standoc.rnc` | current |
| (presentation form of document metadata) | presentation of `bibdata` | `biblio-presentation.rnc` | current |

Read this as a sanity check before authoring: if a salvaged paragraph talks about "Relaton flavours" it belongs in the `relaton` (per-flavour) documentation, currently realised by `relaton-*.rnc`; if it talks about document metadata in `bibdata` it belongs in `biblio-standoc/`; if it talks about basic document structure (paragraphs, sections, blocks) it goes to `basicdoc/` *or* `isodoc/` depending on whether the construct is foundation-level or StanDoc-specific (and the basicdoc-vs-isodoc judgement falls out of which `.rnc` defines the pattern).

The opening post of `metanorma/metanorma-model-iso#90` already formulates the editorial strategy (verbatim): take `cc-lightweight-doc` as scaffolding; under each element, layer Conceptual grouping → Model-level discussion (ontology, relations) → Semantic XML → Presentation XML → Rendering concerns → Flavour idiosyncrasies; cut-and-paste consolidation first pass, refine in-place. Single document, no replication.

`@ronaldtse` and `@HassanAkbar` have meanwhile shipped infrastructure that the user wasn't consulted on:

- `lutaml/rng` parses `.rnc`/`.rng` with full `##`-comment / `<a:documentation>` round-trip support and recursive `include` resolution.
- `lutaml/lutaml-xsd` ships a Vue-SPA documentation generator that accepts `.rnc`/`.rng` directly and inlines into one self-contained `.html`. The engine is sound (verified: `iec.rnc` is 12 lines, the rendered `iec-test.html` exemplar in the gem's fixtures is 238 KB — transitive include resolution works). The fixture set inside the gem is, however, a stale and contaminated copy of this repo's `grammars/` (different `biblio.rnc`, missing submodule trees, extraneous test grammars mingled in), and the configs are naive single-file smoke tests with no notion of metanorma-flavour assembly.

Critically, the **SPA in its current form only carries `##`-comment text** — short, line-level annotations against a `define`/`element`/`attribute`. That is **not sufficient** for the documentation the user needs. The user needs the SPA to carry **multi-paragraph prose**, layered per the issue-90 structure, sourced from accumulated material across several repos.

The corpus to fold in is scattered and partly abandoned:

1. **In-grammar `##` comments** — present and dense in the big files (`isodoc.rnc` 531, `basicdoc.rnc` 348, `biblio.rnc` 510, `isodoc-presentation.rnc` 542) and in the four target schemas overall.
2. **`CalConnect/cc-lightweight-doc`** — documents BasicDoc. Obsolete but contains real prose. Tree: `sources/cc-36010.adoc`, `sources/iso-36010.adoc`, `sources/sections/`, `sources/sections-cc/`, `sources/sections-iso/`, `sources/models/`, `sources/basicdoc-models/`.
3. **`CalConnect/cc-citation-models`** — documents the Relaton model (not the XML). Obsolete but contains real prose. Tree: `sources/cc-6900.adoc`, `sources/iso-6900.adoc`, `sources/sections/`, `sources/sections-cc/`, `sources/sections-iso/`, `sources/data/`, `sources/relaton-models/`.
4. **Three abandoned commits in this repo on `main`** (April 9 2025, same day, never built upon):
   - `fa72827e` seeds `documentation/document.adoc` + 9 section stubs (`00-intro` through `08-common-attributes`)
   - `f87523e8` fleshes out 00-intro, 01-models, 03-document, 04-metadata (+344 lines)
   - `fefdc23d` extends 04-metadata, 08-common-attributes (+56 lines)
5. **Local `documentation/` renders** (untracked, untouched since April 10 2025) — **this is the primary salvage target, not a fallback**. The user continued editing `sections/*.adoc` locally past the last committed commit (`fefdc23d`, April 9), so the rendered outputs from the next day's build (April 10) are a **superset** of what's on GitHub. The sources were subsequently deleted from disk but the renders survive:
   - `document.xml` (172 KB) — metanorma Semantic XML; the canonical reverse-engineerable source
   - `document.html` (218 KB) — rendered visual reference
   - `document.pdf` (941 KB), `document.doc` (332 KB) — output-format renders
   - `document.presentation.xml` (237 KB) — Presentation XML
   - `plantuml/*.png` × 16 — diagrams generated April 9–10 by `asciidoctor-plantuml`, content-hashed filenames; the source PlantUML lived inside `sections/*.adoc` and is reachable from `document.xml` (PlantUML source is preserved in the Semantic XML)
   - `document.rxl` — Relaton bib record for the document
   No `.adoc` sources remain on disk; sources are recoverable by reversing `document.xml` back to AsciiDoc (and folding in the three GitHub commits as a sanity cross-check, since they're a subset).

The user's reframe: **"the existing SPA framework can be a starting point for getting the documentation readable, but it needs all that prose folded in, and updated."** Big task; lots of abandoned pieces. Implementation needs to be **scaled** — a phased editorial-plus-engineering programme, not a single sprint.

## Strategy

The end-state is a **twin artefact**: a long-form narrative document (metanorma-rendered AsciiDoc, descended from the CalConnect / April-2025 lineage) and a schema-side SPA (lutaml-xsd's Vue output), **bidirectionally cross-linked** at compile time on stable element IDs. Two outputs, one editorial corpus, no replication. The model is **TEI ODD** (see "Bidirectional cross-linking" section below for the precedent and operational mechanism).

This implies two parallel tracks, both phased.

**Track 1 — Editorial.** Consolidate, salvage, and update the prose corpus into a single canonical AsciiDoc source tree in this repo, structured per the issue-90 layered model, organised against the four target schemas (`biblio` → `relaton` → `isodoc` → `isodoc-presentation`). Stable anchors per element. Owned by the user.

**Track 2 — Engineering.** Extend `lutaml/lutaml-xsd` so its SPA can (a) ingest the AsciiDoc prose corpus and render it alongside the schema nodes, (b) emit stable URL-fragment IDs per element, (c) link out to the narrative document per element. Requires coordination with `@ronaldtse` / `@HassanAkbar`; the SPA's `schema_serializer.rb` and Vue frontend will need to grow.

Both tracks need to converge for the twin-artefact end-state, but each is independently useful: Track 1 produces a standalone narrative (the CalConnect precedent, extended); Track 2 produces a richer SPA. The final state is the bidirectionally-crosslinked pair.

## Layered structure — refined against the April 2025 corpus

The opening post of #90 proposes a per-element layered structure: Conceptual grouping → Model-level discussion (ontology, relations) → Semantic XML → Presentation XML → Rendering concerns → Flavour idiosyncrasies. The April 2025 corpus (`documentation/document.xml`) shows how that scheme was actually lived once the user started writing — and several layers behave differently from how the opening post predicted. The plan adopts the **lived structure** as authoritative, with a small number of additions for cases that didn't come up in April but will under the four-schema architecture.

### Two-tier organisation

Documentation lives at two scopes, not one. Cross-link contracts and authoring conventions differ.

**Section-scope (cross-cutting chapters).** Material that doesn't reduce to a single `define`. Lives in `documentation/sections/0X-*.adoc`. No `#<define>` anchor contract (these chapters don't correspond to grammar non-terminals). Carries:

- Prefatory: `00-intro` (introduction, document conventions, currency)
- Architectural: `01-models` (the four-schema inheritance story, with PlantUML diagrams — note: the salvaged April 2025 version treats `basicdoc.rnc` as a separate model (correct, stays) AND the per-flavour `relaton-*.rnc` family as first-class (correct, stays — these are not deprecated). The bit that no longer holds is the treatment of **document-level flavour schemas** (`isostandard.rnc`, `ietf.rnc`, `nist.rnc`, `iso.rnc`, `bsi.rnc`, …) as first-class. Phase 1 rewrite is scoped to removing / updating that document-flavour-as-first-class treatment; the `basicdoc` / `biblio` / `biblio-standoc` / `isodoc` / `isodoc-presentation` / `relaton-*` skeleton + the PlantUML inheritance diagrams are preserved.)
- Ontological: `02-ontology` (element categories — Document / Content / Metadata — plus Containing and Referencing relations across the graph)
- The category-introducing chapters `03-document`, `04-metadata`, `05-section`, `06-block`, `07-inline` each open with a short cross-cutting blurb then descend into per-element pages
- `08-common-attributes` is a special cross-cutting chapter for attributes (see below)

**Element-scope (per-`define` pages).** One file per top-level RNG non-terminal that defines an element. Lives in `documentation/schemas/<schema>/elements/<define-name>.adoc`. Carries the `[#<define-name>]` anchor contract. Layered as below.

### Per-element layer scheme

Following the April-2025 lived structure verbatim, with Relaton elevated, Rendering folded, and three additions from doc-schema prior art (Examples, See also, Constraints — see "Prior-art additions" below):

**Header lines (always present, before the first layer):**

- The `[#<define-name>]` anchor
- A `Classes:` line listing the named-pattern memberships of this element in the grammar (e.g. `Classes: BasicBlock, Section-Attributes`). Lifted directly from the grammar; not authored.
- A one-or-two sentence summary (TEI `<desc>`-style); usually matches or extends the grammar `##` short form.

**Layers, in order:**

1. **Relaton** (only for citation-model elements — `bibdata` and its descendants). Describes the element's role in the Relaton citation model.
2. **Semantic XML** (always present for elements in `isodoc`). Sub-structured as:
   - **StanDoc** — the canonical body
   - **Flavours** — deltas off StanDoc; see "Flavour-deletion roadmap" below
3. **Presentation XML** (always present for elements in `isodoc-presentation`). Same sub-structure: StanDoc + Flavours.
4. **Rendering** (separate top layer, *not* folded into Presentation). Format-specific post-Presentation-XML behaviour. Sub-structured per output format: HTML / PDF / DOC / Firelight / future-formats-as-they-emerge. Firelight is a third-party HTML renderer; its maintainer is the primary intended reader of this documentation and reachable only through the documentation itself, so this layer is load-bearing for that channel — it must not be collapsed into Presentation XML even where currently sparse.
5. **Examples**. XML usage exemplars — short canonical snippets. Each example optionally paired with its rendered output for visual context. Universal in TEI / JATS / BITS / DocBook documentation; gap in the April 2025 corpus.
6. **See also**. Sibling / variant / related-element prose cross-references ("this is the inline variant of `<<eref>>`", "compare with `<<note>>` for unmarked admonitions"). Resolves through the AsciiDoc anchor scheme to peer per-element pages or to chapter anchors. Merged at SPA-render time with any grammar-declared secondary cross-references (see "Cross-link cardinality" under the Bidirectional cross-linking architecture section).

For elements that exist in only one of Semantic / Presentation, the missing layer is omitted (no "N/A" placeholders). Empty Examples / See also are stubs.

### Prior-art additions

The three layers added beyond what the April 2025 corpus contained — **Examples**, **See also**, **Constraints** — come from doc-schema prior art (TEI ODD `<exemplum>` / `<listRef>` / `<constraintSpec>`; JATS Tag Library "Tagged Examples" / "Related Elements"; BITS likewise; DocBook: The Definitive Guide "Examples" / "See also" / "Processing expectations"). They were universal across the surveyed schemas; their absence in the April 2025 corpus is a gap rather than a deliberate choice. The plan adopts them as first-class per-element layers.

Lower-priority additions surveyed and *not* adopted in the layer scheme:

- **Used-in / reverse containment.** Leave to the SPA — computable from the grammar at build time. No per-element authoring.
- **Cross-schema equivalents** (this element ↔ DocBook X / JATS Y / TEI Z). Skipped per explicit decision.
- **Lifecycle metadata** (deprecation / since-version) and **Authority / provenance**. Skipped at the per-element layer. Release-level versioning is handled separately — see "Version control and release alignment" below.

### Common attributes — parallel tree

Attribute names (`@language`, `@script`, `@id`) and named attribute groups (`LocalizedStringAttributes`, `Section-Attributes`) recur across many elements. They need their own tree, parallel to `elements/`:

- `documentation/schemas/<schema>/attributes/<name>.adoc` for individual attributes, anchor `#attr-<name>` (SPA URL `#attr-<name>` similarly)
- `documentation/schemas/<schema>/groups/<name>.adoc` for named attribute groups, anchor `#group-<name>`

Per-element pages reference these by anchor rather than re-documenting in place. The Phase-2 invariant checker walks attributes and named patterns in the RNG (not just element-bearing `define`s) and asserts matching files exist.

### Flavour-deletion roadmap

The April 2025 corpus carries Flavours stanzas for 12 flavours per element (ISO, IETF, IEEE, ITU, NIST, IHO, Ribose, JIS, IEC, BSI, BIPM, Plateau). These appear inside the *document-side* element pages (under `metanorma` semantic XML, under structural elements, etc.) and describe how the document-level flavour schemas (`isostandard.rnc`, `iso.rnc`, `bsi.rnc`, …) extend the base. Those document-level flavour schemas are the deprecated set — `ietf` attribute customisation and `nist` custom elements as narrow survivors. The plan's salvage rule for *those* document-side Flavours stanzas:

- **Collapse on salvage.** As each per-element page in the document-side trees (`basicdoc/`, `isodoc/`, `isodoc-presentation/`) is salvaged in Phase 1, the per-flavour stanzas under Semantic XML and Presentation XML get folded into a single `Flavours` sub-section under each layer, with the prose preserved per-flavour but the structure flattened. A `[NOTE]` callout at the top of `Flavours` documents the deprecation trajectory and names ietf/nist as the survivors.
- **Drop the flavour-specific chapters wholesale** (if any survive in the salvage corpus that didn't fold into per-element pages).
- **The two surviving exceptions** — ietf attributes and nist custom elements — get their own first-class sub-sections, not buried inside a generic `Flavours` stanza, so they don't get casually deleted when the rest goes.

**This does not apply to the relaton-side trees.** Per-element pages in `relaton-iso/`, `relaton-bsi/`, etc. (one parallel tree per flavour) carry first-class Flavour content because the underlying grammars are not deprecated — the per-SDO bibliographic metadata is the whole point of those grammars existing. Collapse-on-salvage is a document-side rule only.

### Optional future avenue — machine-readable constraints in the grammar

Non-RNG constraints (uniqueness, conditional presence, cross-reference validity) exist informally in metanorma but are not currently machine-readable. Per the single-source-of-truth principle, if they're ever encoded, they belong in the **grammar source**, not the prose documentation. Plausible shapes to explore when the time comes:

- A new `## @constraint <expression>` directive convention in RNC comments, harvested by the lutaml/rng parser like the other `##` content
- Embedded Schematron in RNC (the Schematron-NG dialect supports embedding constraints inside RelaxNG schemas)
- A separate `.sch` co-file per grammar, with the SPA correlating constraints to elements by element-name

When (and if) this lands, the SPA's per-element panel gains a Constraints sub-section under Semantic XML, populated from grammar-side metadata — the doc still consumes; the grammar remains the source of truth. Not for now; flagged here so the option doesn't get lost.

### Version control and release alignment

The documentation corpus tracks the schemas it documents — a developer reading metanorma-model-iso v3.0.3 should see the v3.0.3 docs, not whatever happens to be on `main`. Operationally:

- **Tag in lockstep.** `documentation/` lives in the same repo as `grammars/` and is tagged with the same release tags. No separate doc release cadence — the doc *is* part of the schema release.
- **Surface the version in the SPA.** Each generated SPA carries the schema version it documents prominently in the header (Phase-3 work in lutaml-xsd — likely already supported via `--title`, but verify the version field is first-class).
- **Historical versions accessible, with noise control.** Phase-4 publishing keeps older versions at versioned URLs rather than overwriting — but only at the **major-or-minor** granularity (`/v2.x/isodoc.html`, `/v3.0/isodoc.html`, `/v3.1/isodoc.html`), not per-patch. Patch releases collapse into their minor URL (so `/v3.0/` always points at the latest 3.0.x docs, not each of 3.0.0/3.0.1/3.0.2/3.0.3). `/latest/` aliases the most recent. Archived versions carry a banner at the top of every page: "This is the schema documentation for v3.0; the current version is v3.1 → \[link\]". Trades off completeness against URL proliferation; we err on the side of keeping history accessible, but capped at the granularity developers actually reference.
- **Anchor stability is the cross-version contract.** The `#define-<name>` URL fragment that worked in v2 must continue to resolve in v3, OR a `documentation/_redirects.adoc` entry must capture the rename. Per the bidirectional cross-linking section.
- **Per-element lifecycle metadata is not authored manually.** No "since v2.5" / "deprecated in v3" stanzas in the per-element files. If lifecycle information is ever needed in the SPA, it gets generated by diffing across tagged grammar versions, not hand-maintained.

This is mostly a Phase-4 publication concern, but the *contract* (anchor stability, no manual lifecycle metadata, repo-tag alignment) is set from Phase 1 so the published version transitions work cleanly.

### Cross-cutting chapter conventions

The `sections/0X-*.adoc` chapters carry no `#<define>` anchor contract — they're not tied to grammar non-terminals. But they still benefit from stable anchors for inbound links from per-element pages. Convention:

- `[#chapter-<short-name>]` at the top of each chapter (`#chapter-ontology`, `#chapter-models`, …)
- `[#concept-<term>]` for ontological concepts introduced in chapter text and referenced elsewhere (`#concept-containing`, `#concept-referencing`)
- Per-element pages can link out: `see <<concept-containing>>` resolves to the right chapter anchor.

## Bidirectional cross-linking architecture

Per `metanorma/metanorma-model-iso#90`'s opening directive ("I'm not going to commit to live updates of both separate documentation and inline schema documentation") and the user's reframe ("the document and the annotated schema need to converge into a twin artefact, and crosslink bidirectionally"), the SPA and the narrative are not two artefacts that happen to link — they are two views of one editorial corpus, joined at stable element IDs.

**Prior art.** The mature, directly-applicable precedent is **TEI ODD** (Text Encoding Initiative, One Document Does it all, mid-2000s onwards). TEI authors write a single ODD source per element (`<elementSpec ident="amend">`) carrying schema constraints + short `<desc>` + long-form `<remarks>` + `<exemplum>`. ODD compiles to (a) RelaxNG/RNC/XSD; (b) the TEI Guidelines HTML, where Guidelines chapters use `<gi>amend</gi>` resolving at compile time to links into the element reference, and reference pages back-link to chapters. End result: `tei-c.org/.../REF-ELEMENTS.html` and the Guidelines are a single bidirectionally-linked artefact. Supporting precedents along the same axis: **W3C Bikeshed** (autolinking `<dfn>` ↔ IDL/schema defs); **DocBook: The Definitive Guide** (Walsh; reference appendix bidirectionally linked to prose chapters); **Sphinx + `autodoc` + `intersphinx`** (Python API reference auto-generated from docstrings, prose chapters cross-link by symbol with `:py:func:`); **Asciidoctor's own documentation** (reference section data-driven from definitions, cross-linked with stable `[#xxx]` anchors). The lesson uniform across all five: the link lives **at the same stable ID on both sides**, resolved at build time, not at runtime.

We are not rewriting the RNC grammars as ODD — that's out of scope. We are adopting only the *link model*.

**Operational mechanism.**

1. **The RNG non-terminal (the `define` name) is the canonical stable ID — not the XML tag name.** In `foo = element bar { ... }`, the non-terminal is `foo` and the XML tag is `bar`; the anchor is `#foo`. XML tags are ambiguous in these grammars — the same tag is emitted by multiple non-terminals in different contexts (`term`, `name`, `id`, etc.); the non-terminal disambiguates. RNG non-terminals are unambiguous within a grammar by definition, and `include` keeps them unambiguous across the layered four-schema stack — an `isodoc`-level redefine of a `biblio`-originated non-terminal is the *same* non-terminal, not a new one, so it shares the anchor. The cross-link contract is therefore: `amend` (non-terminal in `isodoc.rnc`) ↔ `[#amend]` anchor in `documentation/schemas/isodoc/elements/amend.adoc` ↔ SPA URL fragment `isodoc.html#define-amend`. Phase-3 work in lutaml-xsd's Vue router needs to commit to this scheme explicitly and treat it as a public contract.

2. **Short form lives in the grammar.** The `##` comment is the one-to-two-sentence summary — TEI's `<desc>`. It's what appears on the SPA element panel by default and is what RNC readers see when reading the schema directly. Stays terse.

3. **Long form lives in the narrative.** `documentation/schemas/<schema>/elements/<name>.adoc` carries the issue-90 layered structure (Concept / Model / Semantic / Presentation / Rendering / Flavours). This is TEI's `<remarks>` + `<exemplum>`. Multi-paragraph, links to other elements, includes diagrams.

4. **SPA → narrative direction.** Every SPA element panel renders a "Discussion" link to `document.html#amend` (or whatever the published narrative URL becomes). Phase-3 engineering in lutaml-xsd: (a) one new field in `schema_serializer.rb`'s JSON payload (e.g. `discussion_url`), (b) one new link in the Vue element-panel component, (c) a build-time option to pass the narrative base URL (`lutaml-xsd spa … --narrative-base https://metanorma.org/develop/iso-schema/document.html`).

5. **Narrative → SPA direction.** Every per-element AsciiDoc section ends with a "Schema definition" callout linking to the SPA URL fragment. Done with an AsciiDoc inline macro or a tiny Liquid template invoked from `[lutaml_rng]` in metanorma-plugin-lutaml. Phase-2 / 3.

6. **Compile-time invariant.** A check script (Ruby, ~50 lines) asserts: for every `define X` in the four target grammars, there exists `documentation/schemas/<schema>/elements/X.adoc` *or* an entry in an opt-out manifest at `documentation/schemas/<schema>/_no-narrative.txt`. And conversely: every per-element narrative file matches a real `define` in the corresponding grammar. This catches drift the moment it lands. Runs in CI in Phase 4; runs locally throughout Phase 2.

7. **Anchor stability is a contract.** Once published, both the AsciiDoc `[#X]` anchors and the SPA `#define-X` URL fragments must not change. If a grammar `define` is renamed, the narrative anchor follows, and a `301-like` redirect entry is added to a `documentation/_redirects.adoc` (or equivalent) so existing external citations don't break. Discuss in the Phase-3 lutaml-xsd design issue.

8. **One twist Track 2 needs to negotiate.** lutaml-xsd today serialises by **namespace**, not by source grammar. When the four target schemas overlap on namespace (which they will — `isodoc` extends `biblio` which extends `relaton`, all under metanorma's namespace family), the SPA must still preserve per-grammar identity for the cross-link to resolve to the right narrative. Phase-3 design issue: either emit one SPA per grammar (current model, four SPAs), or one combined SPA with grammar-of-origin metadata on each node. Both are workable; the first is simpler and matches the four-narrative-document organisation; recommend it.

## Phasing

### Kick-off — raise a ticket per phase, with `#90` as the parent index (today, before any code)

This is a very long plan. Colleagues — `@ronaldtse`, `@HassanAkbar`, anyone else watching — will refuse to read it as a single wall of text on `#90`, and they shouldn't have to. The plan record is split:

- **`#90` becomes the parent index.** A single coordination comment on `#90` carries the high-level summary and the table of links to phase tickets. Nothing else of substance goes on `#90` itself.
- **Each phase gets its own ticket** on `metanorma/metanorma-model-iso`, titled `Schema documentation — Phase N: <topic>`. Each phase ticket links back to `#90` in its opening line (`Part of <https://github.com/metanorma/metanorma-model-iso/issues/90>`). The phase tickets themselves are big — they get the **indexed-multi-comment pattern** internally (one short index comment at the top, topical follow-up comments below), same legibility fix as before but scoped to one phase.

Phase tickets (filed 2026-05-19):

1. **Phase 0a** — [#115](https://github.com/metanorma/metanorma-model-iso/issues/115) — `Schema documentation — Phase 0a: setup the documentation pipeline` (assigned `@kwkwan`)
2. **Phase 0b** — [#116](https://github.com/metanorma/metanorma-model-iso/issues/116) — `Schema documentation — Phase 0b: engine validation against real grammars` (assigned `opoudjis`; blocked on 0a)
3. **Phase 0.5** — [#117](https://github.com/metanorma/metanorma-model-iso/issues/117) — `Schema documentation — Phase 0.5: RNC comment conventions spec` (assigned `opoudjis`)
4. **Phase 1** — [#118](https://github.com/metanorma/metanorma-model-iso/issues/118) — `Schema documentation — Phase 1: corpus salvage with anchors baked in` (assigned `opoudjis`)
5. **Phase 2** — [#119](https://github.com/metanorma/metanorma-model-iso/issues/119) — `Schema documentation — Phase 2: gap-fill editorial (open-ended)` (assigned `opoudjis`)
6. **Phase 3** — [#120](https://github.com/metanorma/metanorma-model-iso/issues/120) — `Schema documentation — Phase 3: lutaml-xsd engineering` (assigned `@HassanAkbar`)
7. **Phase 4** — [#121](https://github.com/metanorma/metanorma-model-iso/issues/121) — `Schema documentation — Phase 4: publication and version-aligned hosting` (assigned `opoudjis`)

Coordination comment on the parent ticket: [#90 comment](https://github.com/metanorma/metanorma-model-iso/issues/90#issuecomment-4488258134). All seven phase tickets added to the org-level Metanorma project (project 15) on filing.

Phase 2–4 tickets are raised at the same time as 0a / 0b / 0.5 / 1 even though their substantive work is later — the structure is what's published up front, so colleagues can see the whole shape. Phase 2–4 tickets carry a "blocked on Phase N-1" note at the top until predecessor work completes.

Each issue is assigned to `opoudjis` (metanorma-model-iso is an owned gem). Each issue gets `gh project item-add 15 --owner metanorma --url <issue-url>` after creation so it lands on the dashboard. Every issue body and every internal comment goes through a temp file. Every substantive narrative comment carries the robot footer.

**The `#90` coordination comment** (the parent index) — short. Roughly:

> Schema-documentation work is now broken out into per-phase tickets:
>
> - Phase 0 — engine validation: <link>
> - Phase 0.5 — RNC comment conventions spec: <link>
> - Phase 1 — corpus salvage: <link>
> - Phase 2 — gap-fill editorial: <link>
> - Phase 3 — lutaml-xsd engineering: <link>
> - Phase 4 — publication: <link>
>
> Each phase ticket carries its own indexed multi-comment plan. This ticket (#90) remains the parent index. Substantive discussion happens on the per-phase tickets.

**Each phase ticket's internal structure** (the indexed multi-comment pattern, same as I'd previously proposed for `#90`):

- Comment 1 — Index of follow-up comments
- Comment 2 — Scope / outcome / audience for this phase
- Comment 3 onwards — topical content (varies per phase; for Phase 0 these include: target build matrix, decision point on engine-vs-grammar, lutaml-side issues to file; for Phase 1: salvage corpus inventory + anchor discipline + per-source mapping; etc.)

The body of each phase ticket covers the relevant section(s) of this plan file expanded for that phase's reader. Material that's truly cross-cutting (the per-element layered structure; the bidirectional cross-linking architecture; the conceptual↔grammar mapping; the salvage corpus inventory) is duplicated across the phase tickets that need it, *not* extracted to `#90` — `#90` stays an index, no body content, because anything that lands there becomes the wall-of-text we're trying to avoid.

**Sequencing for posting:**

1. Raise Phase 0 ticket first (the substantive work for today).
2. Raise Phase 0.5 ticket next.
3. Raise Phase 1, 2, 3, 4 tickets as forward placeholders with the relevant plan content + "blocked on Phase N-1" notes.
4. Post the `#90` coordination comment with all six links.
5. Run `gh project item-add 15 --owner metanorma --url <each-url>` for each new ticket to land them on the dashboard.

Operational rules for posting (as before):

- Temp file → `gh issue create -F`; same for comments inside each phase ticket.
- Back-edit each phase ticket's index comment with the actual comment URLs after all follow-up comments land (`gh api repos/metanorma/metanorma-model-iso/issues/comments/<id> -X PATCH -f body=@<file>`).
- Robot footer on every substantive comment.

**Comment 1 — Index.** Short. Plain table of contents with anchor links to each follow-up comment (using GitHub's `#issuecomment-<id>` URLs, fetched from each comment's own URL after posting and back-edited into the index). Roughly:

> The schema-documentation plan is laid out across the following follow-up comments. Read whichever applies; comment 2 is the high-level summary if you only have a minute.
>
> 1. [Index — this comment]
> 2. Scope, outcome, audience — what this is, who it's for
> 3. Grammar artefact set and dependency graph
> 4. Twin-artefact end state and bidirectional cross-linking (TEI-ODD precedent)
> 5. Per-element layered structure, cross-cutting chapters, common attributes
> 6. Salvage corpus — what to mine from where
> 7. Phasing — Kick-off, 0, 1, 2, 3, 4
> 8. Risks, coordination, version control, optional future avenues

**Comment 2 — Scope, outcome, audience.** What this is (twin-artefact: narrative metanorma document + lutaml-xsd Vue SPA, bidirectionally cross-linked), what it isn't (not for end users — metanorma.org's job; not the deprecated document-level flavour schemas (`isostandard`, `iso`, `bsi`, etc., going away with `ietf`/`nist` as narrow exceptions); not a quick win — multi-month). Per-flavour relaton metadata grammars *are* first-class and stay. Who it's for: metanorma developers, with Firelight's maintainer as the asymmetric-channel primary reader. Implementation needs to be scaled.

**Comment 3 — Grammar artefact set and dependency graph.** The four conceptual layers (`biblio < relaton < isodoc < isodoc-presentation`) vs. the core grammar artefacts that need documentation trees (`basicdoc`, `biblio`, `biblio-standoc`, `biblio-presentation`, `isodoc`, `isodoc-presentation`) plus the `relaton-*.rnc` flavour family (current, first-class). The dependency graph in ASCII. The `biblio` → `basicdoc` cross-grammar reference (`BasicBlockNoId`) and what it means for engine handling. The deprecation distinction: document-level flavour grammars deprecated; per-flavour relaton metadata grammars preserved.

**Comment 4 — Twin-artefact end state and bidirectional cross-linking.** TEI ODD as the canonical precedent (single source, schema + Guidelines bidirectionally linked at stable element IDs at compile time). Supporting precedents in passing (Bikeshed, DocBook, Sphinx, Asciidoctor). The operational mechanism: non-terminal-keyed anchors (not XML-tag-keyed), single primary `Discussion` link + multiple `See also` secondary refs, build-time invariant checker, anchor-stability contract.

**Comment 5 — Per-element layered structure, cross-cutting chapters, common attributes.** The six per-element layers (Relaton / Semantic XML / Presentation XML / Rendering / Examples / See also) with the April-2025 lived-structure grounding and the prior-art additions. The cross-cutting chapters (`sections/00-intro` through `08-common-attributes`) with the `[#chapter-<name>]` / `[#concept-<term>]` anchor convention. The parallel `attributes/` and `groups/` trees for common attributes that recur across many elements. Flavour-deletion roadmap (collapse on salvage).

**Comment 6 — Salvage corpus.** The five corpus sources, ranked: (1) local `documentation/document.{xml,html,pdf,doc}` April 10 2025 renders — primary, the superset; (2) the three abandoned commits `fa72827e` / `f87523e8` / `fefdc23d` — subset, structural cross-check; (3) CalConnect `cc-lightweight-doc` and `cc-citation-models` — obsolete but rich; (4) `metanorma-model-standoc/{models,views}`, `basicdoc-models/`, `relaton-models/` UML — reference, not authoritative; (5) `metanorma.org` — secondary, different range of concerns.

**Comment 7 — Phasing.** Phase 0 today (engine validation against the real grammars; decision point on engine-vs-grammar, recorded preference that the engine bends not the grammar). Phase 1 (salvage with anchors baked in, 1–2 weeks). Phase 2 (extended editorial gap-fill, multi-month, anchor discipline carries). Phase 3 (lutaml-xsd engineering for prose ingestion + bidirectional crosslinks + stable URL scheme; coordinate with `@HassanAkbar`). Phase 4 (publication with version-aligned tagging and noise-controlled historical URLs).

**Comment 8 — Risks, coordination, version control, optional future avenues.** Fixture-drift in lutaml-xsd (separate side-issue, raise but don't block). No-releases-until-coordinated discipline. Phase-3 gated on Hassan/Ronald. Version control / release alignment (lockstep tagging, anchor stability, no manual lifecycle). Optional future avenue: machine-readable constraints in the grammar (Schematron-in-RNC or `## @constraint` directive) — flagged so it doesn't get lost.

**Operational rules for posting**:

- write each comment body to a temp file (`/tmp/issue-90-comment-N.md`) and post with `gh issue comment 90 --repo metanorma/metanorma-model-iso -F <file>`. No inline `-b "..."` heredocs; the bilingual content + AsciiDoc-style references would trip shell quoting.
- Post comments 2–8 in order, capture each comment's URL from the gh response, then back-edit comment 1 (the index) with the actual `#issuecomment-<id>` anchors. `gh issue comment 90 --edit-last` doesn't target an arbitrary comment, so use `gh api repos/metanorma/metanorma-model-iso/issues/comments/<id> -X PATCH -f body=@/tmp/issue-90-index-final.md` to update the index.
- every comment carries the robot footer (`
- After posting, run `gh project item-add 15 --owner metanorma --url <issue-url>` is **not** needed (it's a comment thread on an existing issue, not a new issue) — the rule scope is issue creation, not commenting.
- The follow-up comments cross-referencing each Phase-0-surfaced lutaml-side issue (when filed) are separate from this initial plan-record set — they land on `#90` *after* the lutaml-side issues are filed, with each follow-up linking to the relevant lutaml issue.

### Phase 0a + 0b — setup by @kwkwan, then engine validation by opoudjis

**Reframed after exchange with `@ronaldtse`.** Originally Phase 0 was a single ticket: "user iterates on the engine and files bugs". @ronaldtse pointed out that `@kwkwan` knows how to set the pipeline up (he authored the `metanorma/plateau-iur-schema-browser` exemplar) and is the right person to do the setup for `metanorma-model-iso` before the user-side validation begins. So Phase 0 splits into two tickets, one per person.

The canonical pipeline (`@ronaldtse`'s words):

> RNC ⇒ lutaml-xsd builds a fully resolved LXR package ⇒ lutaml-xsd builds an SPA for the LXR package.

Three components, three maintainers:

1. `lutaml/lutaml-xsd` — reads RNG/RNC, builds the LXR package, builds the SPA (`@HassanAkbar`)
2. `lutaml/rng` — parses RNG/RNC grammars (`@HassanAkbar`)
3. **Site for documentation** — the integration / config / workflow / hosting layer (`@kwkwan`)

**Phase 0a — setup (assigned to @kwkwan).** Wa sets up the schema-documentation pipeline for `metanorma-model-iso` in the shape his `plateau-iur-schema-browser` exemplar established — `config.yml` with metanorma metadata / namespace mappings / branding, `.github/workflows/deploy.yml` adapted from plateau's, decisions on the three grammars lacking a `*-compile.rnc` at the right documentation scope, decisions on the hosting venue (gh-pages on this repo? separate `metanorma-model-iso-schema-browser` repo? sub-path under metanorma.org?). Delivers via PR with a minimal README explaining how opoudjis runs the pipeline locally. Fallback: opoudjis adapts plateau directly if Wa's plate doesn't fit it.

**Phase 0b — engine validation (assigned to opoudjis, blocked on 0a).** Once Wa's setup PR lands, opoudjis runs the pipeline against the seven real metanorma-model-iso schema roots — `basicdoc.rnc`, `biblio.rnc` (the cross-grammar-reference canary, referencing `BasicBlockNoId` from `basicdoc.rnc`), `biblio-standoc.rnc`, `biblio-presentation.rnc`, `relaton-iso-compile.rnc` (relaton-flavour exemplar), `isodoc-compile.rnc`, `isodoc-presentation-compile.rnc`. Where the engine struggles, file the resulting issues against `lutaml/rng` or `lutaml/lutaml-xsd` with `@HassanAkbar`. **The strong preference**: the engine bends, not the grammar (see decision point below) — `biblio.rnc` rewrite is mutual-recursion hell and we'd rather wait for the lutaml-side fix.

Steps:

- Add `gem "lutaml-xsd", path: "../lutaml-xsd"` to `grammars/Gemfile` (sibling clone). `bundle install` from `grammars/`.
- Author configs at `grammars/doc-build/configs/<schema>.yml` against the canonical compile roots. The existing `*-compile.rnc` wrappers in `grammars/` are the roots metanorma itself compiles against (see `grammars/make.sh:65-69`); use them where they exist, and author thin doc-only wrappers in `grammars/doc-build/roots/` for the two compile-roots that don't currently exist. Initial set:

  | Config | Root | Source of root | Documents |
  |---|---|---|---|
  | `basicdoc.yml` | `basicdoc.rnc` | existing (standalone, no compile variant needed) | basicdoc foundation |
  | `biblio.yml` | `grammars/doc-build/roots/biblio-doc.rnc` | **author thin wrapper** (`include "basicdoc.rnc"; include "biblio.rnc"; start = bibitem`) | biblio base citation model only |
  | `biblio-standoc.yml` | `grammars/doc-build/roots/biblio-standoc-doc.rnc` | **author thin wrapper** (`include "basicdoc.rnc"; include "biblio.rnc"; include "biblio-standoc.rnc"; start = bibdata`) | biblio + biblio-standoc, the citation-as-document-metadata layer |
  | `biblio-presentation.yml` | `grammars/doc-build/roots/biblio-presentation-doc.rnc` | **author thin wrapper** (compose basicdoc + biblio + biblio-presentation) | presentation form of metadata |
  | `relaton-iso.yml` | `relaton-iso-compile.rnc` | existing | relaton-flavour exemplar (ISO). The per-flavour relaton-*.rnc family is current and first-class; one exemplar in Phase 0 to validate the pattern, the rest (relaton-bsi, relaton-iec, relaton-ieee, …) follow in parallel as documentation expands. |
  | `isodoc.yml` | `isodoc-compile.rnc` | existing | StanDoc semantic schema |
  | `isodoc-presentation.yml` | `isodoc-presentation-compile.rnc` | existing | StanDoc presentation schema |

  Authored thin wrappers go into a separate `roots/` directory inside `doc-build/` so they're visibly distinct from the grammar's own compile wrappers (which serve a different purpose — they set `start` rules and resolve includes for validation, not documentation scope). The thin wrappers exist only so each conceptual layer gets a SPA scoped to its own non-terminals; without them, biblio-standoc elements appear inside the biblio SPA and the biblio-presentation elements inside the isodoc-presentation SPA, blurring the per-layer cross-link contract.

  `biblio.yml` (against the thin wrapper) is the cross-grammar-reference test case: biblio.rnc references basicdoc-defined patterns (`BasicBlockNoId`) and the thin wrapper resolves them by including basicdoc.rnc explicitly. If lutaml-xsd handles this cleanly the rest follows; if it chokes that's the first issue against `lutaml/rng` or `lutaml/lutaml-xsd`.

**Phase-0 decision point — engine vs. grammar.** When biblio.rnc (and any other grammar-incomplete artefact we discover the same way) is built as a standalone root, one of three outcomes follows; the plan's response to each is fixed in advance:

1. **Engine handles cross-grammar references gracefully** — emits placeholder anchors that resolve at SPA-composition time into links pointing at the sibling SPA. Proceed to Phase 1 unchanged.
2. **Engine warns / produces a usable but degraded SPA** — unresolved patterns surface as blank panels or warnings. File a `lutaml/rng` or `lutaml/lutaml-xsd` issue for the polish; proceed to Phase 1 in parallel using the degraded output as the baseline.
3. **Engine errors / refuses to build** — file the issue, **but do not rewrite the grammar to fix it**. Making biblio.rnc standalone forces one of: duplicating basicdoc patterns into biblio (drift), inverting the layering (biblio becomes the foundation), or introducing a third "commons" file that both depend on (mutual-recursion / cyclic-include risk). All three are worse than waiting for the engine to catch up. Pause Phase 1's biblio-side work, continue with `basicdoc`, `isodoc`, `isodoc-presentation` while lutaml-side fixes ship, and resume biblio work after.

The strong preference, recorded here so it doesn't get re-litigated under pressure: **the engine bends, not the grammar.** Grammar rewrite is a last-resort, not a first-resort response to engine limitations.
- Build all six:
  ```sh
  cd grammars
  for s in basicdoc biblio biblio-standoc biblio-presentation relaton-iso isodoc isodoc-presentation; do
    bundle exec lutaml-xsd build from-config doc-build/configs/$s.yml -o doc-build/out/$s.lxr 2>&1 | tee doc-build/out/$s.build.log
    bundle exec lutaml-xsd spa doc-build/out/$s.lxr -o doc-build/out/$s.html --title "Metanorma $s schema" 2>&1 | tee doc-build/out/$s.spa.log
  done
  ```
- `.gitignore` `grammars/doc-build/out/`. Configs are committed; outputs and logs are not.
- For any build that fails, errors, hangs, or produces visibly wrong output (missing namespaces, dropped `##` comments, mangled include resolution, partial element trees):
  - Reduce to a minimal reproducer (typically one `.rnc` file plus the smallest subset of its `include`d files that still trips the bug).
  - File against `lutaml/rng` (parser-level bugs, comment-loss, include resolution) or `lutaml/lutaml-xsd` (XSD conversion, SPA serialiser, frontend rendering). assign+review to `@HassanAkbar` (he maintains both per the default-maintainer table).
  - Per `github-content-via-file.md`, write the issue body to a temp file and post with `gh issue create --repo lutaml/<repo> --assignee HassanAkbar --reviewer HassanAkbar -F /tmp/...`.
  - Cross-reference each lutaml-side issue from a follow-up comment on `metanorma-model-iso#90` so the metanorma-side ticket carries the trail.
- For each build that succeeds, open the `.html` and assess: structure, navigability, whether the `##` content the user already wrote in the source renders against the right nodes, where the documentation-density gaps are. This is the **baseline** the rest of the plan measures against.

Expected outcomes:

- Best case: four SPAs that look like the `iec-test.html` exemplar but with the real grammar content. Confirms the engine works on non-toy input.
- Likely case: one or two of the four fail in ways the gem maintainers haven't seen, because they only tested with `iec.rnc`/`bsi.rnc`. Today's value is the bug report, not the SPA.
- Worst case: all four fail. Phase 1 then waits on lutaml-side fixes before salvage authoring begins.

### Phase 0.5 — document the RNC comment conventions (≤ 1 day, after Phase 0)

Goal: lock the RNC comment conventions in writing before Phase 1 authoring touches them, and lock them in a place lutaml/rng and lutaml-xsd can implement against. The conventions have to exist as a contract on paper — not just as ad-hoc behaviour in three tools that drift apart.

The spec lives at `documentation/RNC-COMMENT-CONVENTIONS.adoc` (in this repo, because the schemas live here; lutaml/rng and lutaml-xsd reference it). Contents:

- **Baseline `##` doc-comments.** Already implemented in lutaml/rng. One or more `##` lines immediately preceding a `define`/`element`/`attribute`/`start` are documentation attached to that non-terminal; round-trip to `<a:documentation>` in RNG; round-trip back. Quote the lutaml/rng implementation references (`rnc_parser.rb:27-28, 270, 281, 382, 391`) so the spec and the implementation stay tied.
- **Plain `#` comments stripped.** Documented as deliberately ignored — author intent: `#` is for inline annotations to grammar maintainers (commented-out alternatives, ALERT-style notes, ad-hoc TODOs), not user-facing documentation.
- **Multi-line continuation.** Adjacent `## ` lines coalesce into one documentation block, preserving line breaks. AsciiDoc-style markup is permitted inside (paragraphs, inline emphasis, code spans) — the documentation pipeline renders it.
- **Cross-reference directives.** `## @see <<anchor>>` declares the *primary* cross-reference target for the non-terminal — typically into a chapter (`<<chapter-ontology>>`) or a concept (`<<concept-containing>>`). Multiple `## @see-also <<anchor>>` lines declare secondary cross-references — typically to peer element pages. Both types render in the SPA's element panel as "See also" entries, merged with prose-declared cross-references. Anchors resolve at SPA-composition time against the AsciiDoc anchor scheme.
- **Reserved directive namespace `## @*`.** Any `##` line starting with `@<keyword>` is reserved for grammar-side directives, not prose. Authors writing prose that happens to start with `@` use a leading space or rephrase. Current allocations: `@see`, `@see-also`. Future allocations to be filed against this spec, not invented in-line.
- **Anchor naming contract.** The non-terminal name (the `define` name, *not* the XML tag) is the canonical stable ID. Three derivations: AsciiDoc anchor `[#<name>]`; SPA URL fragment `#define-<name>`; XML tag is *not* the anchor source (see Bidirectional cross-linking section for the ambiguity rationale).
- **Examples.** Worked examples for each directive, drawn from the actual grammars where possible (so the spec is testable against `grep` in `grammars/`).

After the spec is written:

- Commit on a feature branch in this repo, open a draft PR against `main` so the conventions are reviewable on the ticket.
- Post the spec as an additional comment on `#90` (one comment outside the index pattern — a "convention update" between the kick-off plan record and Phase-0 results); link from the index comment after the fact.
- File a coordination issue on `lutaml/rng` — assigned + reviewed by `@HassanAkbar` — capturing any directives beyond plain `##` that need parser support (`## @see` / `## @see-also` recognition; the reserved-namespace rule). File a parallel issue on `lutaml/lutaml-xsd` for the SPA-side render of the directives.
- Spec is **versioned with the schemas** (per the version-control section) — bumps in lockstep, anchor stability contract carries.

### Phase 1 — corpus salvage with anchors baked in (1–2 weeks of editorial effort)

Goal: gather the existing scattered prose into a single canonical source tree, organised against the four schemas, **with the cross-link anchors baked into every file as it's written**. No new writing yet — just consolidation. The anchor discipline is a Phase-1 deliverable, not a Phase-2 retrofit: every salvaged section lands with its `[#<name>]` already in place, because retrofitting anchors across hundreds of files later is the kind of churn that just doesn't happen and the cross-link contract erodes silently.

- **Reverse-engineer the local `documentation/document.xml` (April 10 2025) back to AsciiDoc** — this is the primary source, because it embodies one extra day of editing past the last commit. Approach: `document.xml` is metanorma Semantic XML, so either (a) run it through `metanorma-iso` / `metanorma-standoc`'s reverse path if one exists, (b) write a one-shot XSLT that emits AsciiDoc per metanorma's `to_adoc` conventions, or (c) extract paragraph-by-paragraph by parsing `document.xml` with Nokogiri and emitting AsciiDoc piecewise. (c) is the pragmatic floor — produces editable AsciiDoc even if rough, the user cleans up by hand.
- **Cross-check against the three GitHub commits** `fa72827e` / `f87523e8` / `fefdc23d`. They are a subset of the April 10 render but are useful as a structural diff: any prose in the commits but missing from the reversed `document.xml` flags a parse error in step above. Either `gh api repos/metanorma/metanorma-model-iso/contents/documentation/sections/...?ref=<sha>` per file, or `gh api repos/metanorma/metanorma-model-iso/commits/<sha>` and reconstruct from the diff. The 00-intro through 08-common-attributes scaffold and the section ordering come from here.
- **Preserve the 16 PlantUML PNGs.** They live at `documentation/plantuml/plantuml20250409-*.png` and `plantuml20250410-*.png`. The PlantUML source is embedded in `document.xml` (`asciidoctor-plantuml` carries the source through). Extract the source blocks during the reverse pass and store as `documentation/plantuml/*.puml` so they can be regenerated cleanly; keep the existing PNGs as a visual reference until the regenerated diagrams are verified equivalent.
- Pull prose from `CalConnect/cc-lightweight-doc/sources/sections/`, `sections-iso/`, and `models/` — anything documenting BasicDoc constructs. Map each section to the appropriate point in the resurrected `documentation/sections/0X-*.adoc` per the issue-90 layering.
- Pull prose from `CalConnect/cc-citation-models/sources/sections/`, `sections-iso/`, and `relaton-models/` — anything documenting the Relaton model. Map similarly. This is the prose for the `biblio` and `relaton` schema layers.
- **Pull from `metanorma/metanorma.org` as a secondary source** (addresses a different range of concerns — primarily end-user docs and dev-side config, not the XML schemas directly — but any prose that touches the document model, terminology, conceptual structure, or the semantic-vs-presentation distinction is salvageable). Focus on `develop/` and `build/` subfolders for dev-relevant material, plus any end-user pages whose explanations of metanorma's structure can be repurposed for the schema narrative. Tag salvaged passages with their origin so we can flag when content has drifted out of step with metanorma.org versus our schema-side fork of it.
- Cross-reference each consolidated section against the in-grammar `##` comments. Where the grammar comment already says X, keep the prose version (richer) and let the grammar comment remain as the short-form summary. Where prose is missing, flag for Phase 2 writing.
- Layout in this repo:
  ```
  documentation/
    document.adoc           # master, includes sections/
    sections/
      00-intro.adoc
      01-models.adoc        # the four-schema architecture itself
      02-ontology.adoc
      03-document.adoc      # structure layer
      04-metadata.adoc
      05-section.adoc
      06-block.adoc
      07-inline.adoc
      08-common-attributes.adoc
    schemas/                # NEW — one folder per target schema
      biblio/
        intro.adoc
        elements/<name>.adoc      # one file per top-level define, layered per issue-90
      relaton/...
      isodoc/...
      isodoc-presentation/...
  ```
  The `sections/` tree is the cross-cutting narrative (the original April 2025 scaffold). The `schemas/` tree is the per-element documentation that the SPA will eventually ingest.

Deliverable: a complete `documentation/` source tree committed to this repo, no new prose yet, just consolidation. PR against `main`. Issue #90 comment narrating what was salvaged from where.

### Phase 2 — gap-filling and authoring (open-ended, multi-month)

Goal: bring the corpus up to coverage. Where Phase 1 left gaps (any element in any of the four schemas without a corresponding prose stanza), write them. Apply the issue-90 layered structure consistently. This is the bulk of the editorial work, and is explicitly open-ended — incremental PRs, no end-date commitment. Anchor discipline carries over from Phase 1 unchanged: any new stub created here lands with its `[#<name>]` anchor and "Schema definition" callout in place at file-creation time. **Phase 2 is the latest acceptable point for cross-links to be present in the prose corpus** — anything later is retrofit territory and degrades.

- Prioritise by reader impact: `isodoc` (the metanorma core) → `isodoc-presentation` → `relaton` → `biblio`.
- For each top-level `define` in each schema, the per-element file at `schemas/<schema>/elements/<name>.adoc` should have:
  - A stable AsciiDoc anchor `[#<name>]` at the top, matching the grammar `define` name exactly (this is the cross-link contract — see "Bidirectional cross-linking architecture" above).
  - Concept (what this element represents)
  - Model-level discussion (ontology / relations)
  - Semantic XML notes (its role in the semantic schema)
  - Presentation XML notes (how it's rendered / transformed in presentation)
  - Rendering concerns (if any)
  - Flavour idiosyncrasies (`ietf` attribute overrides, `nist` custom elements, etc., as the narrow exceptions to the four-schema target)
  - A "Schema definition" callout at the bottom linking to the SPA URL fragment (narrative → SPA direction of the bidirectional link).
- Empty stanzas are OK as long as they're explicitly stubbed — they're queues for future work, not silences. A stub that exists with just the anchor and a TODO line still satisfies the cross-link invariant; that's the minimum unit.
- **Build the cross-link invariant checker** (Ruby, ~50 lines) — walks `grammars/<schema>.rnc`, lists every top-level `define`, asserts a matching `schemas/<schema>/elements/<name>.adoc` exists (or the name appears in `documentation/schemas/<schema>/_no-narrative.txt`). Runs in CI from Phase 4 onwards; runs locally throughout Phase 2 to catch drift early.

Deliverable: `schemas/` tree populated to whatever coverage threshold the user sets. Iterative PRs.

### Phase 3 — extend lutaml-xsd to consume the corpus + emit bidirectional crosslinks (engineering against `../lutaml-xsd`)

Goal: teach the SPA to (a) render the Track-1 prose alongside the schema nodes, (b) emit stable per-element URL fragments, (c) link out to the narrative document — i.e. the SPA half of the twin-artefact bidirectional contract.

The feature gap, located:

- **Schema serializer** at `../lutaml-xsd/lib/lutaml/xsd/spa/schema_serializer.rb:1461-1469` (`extract_documentation`) — currently emits a flat string per node. Needs to emit a richer structure (per-section AsciiDoc-rendered HTML, keyed by the issue-90 layers: concept / model / semantic / presentation / rendering / flavours) plus a `discussion_url` field for the narrative link.
- **HTML document builder** at `../lutaml-xsd/lib/lutaml/xsd/spa/html_document_builder.rb` — inlines the JSON payload. Will carry more content per node.
- **Vue frontend** at `../lutaml-xsd/frontend/src/` — needs (i) new components to display the layered sections (probably a tabbed panel per element, one tab per issue-90 layer), (ii) a documented stable URL-fragment scheme `#define-<name>` per element that we treat as a public contract going forward (renames are versioned with redirect entries; see Architecture §7), (iii) a "Discussion" outbound link on each element panel pointing at `<narrative-base>#<name>`.
- **Input plumbing.** A `--prose-dir <path>` flag on `lutaml-xsd spa` pointing at this repo's `documentation/schemas/<schema>/elements/` tree, plus a `--narrative-base <url>` flag for the discussion link target. Match-by-filename (`amend.adoc` ↔ `define amend = …`).
- **AsciiDoc rendering.** Two options: (a) ship `asciidoctor` as a runtime dep of lutaml-xsd and render at SPA-generation time; (b) require the prose to be pre-rendered to HTML fragments before ingest. Recommend (a) — simpler for the user, costs lutaml-xsd one dependency.
- **Anchor-stability contract.** Document in `lutaml-xsd`'s README that the `#define-<name>` URL scheme is part of the gem's public contract. Adopt the same TEI-style discipline: rename invalidates URLs, so a rename should be paired with a redirect entry on the narrative side (`documentation/_redirects.adoc` or equivalent) — out of lutaml-xsd's scope to implement, but document the contract so the gem's release notes will surface it on bumps.

This is **engineering work in lutaml-xsd**, not in metanorma-model-iso. Coordinate with `@HassanAkbar` (maintainer of `lutaml/rng`; lutaml-xsd is also non-owned — `@HassanAkbar` is the listed maintainer for `lutaml/*`). PR(s) against `lutaml/lutaml-xsd`. Per `github-no-releases`, pin via `Gemfile.devel` (git branch) until a coordinated release.

While we're there, raise the **fixture-drift issue** the implementer left behind: `lutaml-xsd/spec/fixtures/metanorma-model-iso-grammars/` should either become a git submodule pointing at this repo, or be reduced to a minimal synthetic grammar suite. The current stale copy is a maintenance trap.

### Phase 4 — publish (deferred until 1–3 are real)

Goal: a hosted URL where developers reading the schemas can land.

- Add a GitHub Action to `metanorma/metanorma-model-iso` that runs the Phase 0/3 build on each push to `main` and publishes the four SPAs to `gh-pages` (or whatever metanorma's canonical dev-docs URL becomes).
- Replace the dormant `lutaml.github.io/lutaml-xsd` redirect chain — that was an aspirational target set in `lutaml-xsd/docs/DEPLOYMENT_GUIDE.adoc` that the gem team never actually wired up.
- Cross-link from `metanorma.org/develop/` (or wherever the dev-facing docs index lives) to the four SPAs.

Not addressed in this plan beyond the placeholder. Revisit once Phase 3 ships.

## Critical files / paths

**Engine (read-only here, eventual edits in `../lutaml-xsd` and `../rng` are Phase 3):**

- `../rng/lib/rng/rnc_parser.rb` lines 23, 27-28, 270-391 — `##` comment parsing
- `../rng/lib/rng/include_processor.rb` lines 102-210 — transitive include resolution
- `../lutaml-xsd/lib/lutaml/xsd/cli.rb` — CLI surface (`build from-config`, `spa`)
- `../lutaml-xsd/lib/lutaml/xsd/rng_to_xsd_converter.rb` lines 41-130, 976-984 — RNC/RNG → XSD with documentation passthrough
- `../lutaml-xsd/lib/lutaml/xsd/spa/schema_serializer.rb` lines 1461-1469 — **the choke point that needs extending in Phase 3**
- `../lutaml-xsd/spec/fixtures/metanorma-model-iso-grammars/output/iec-test.html` — exemplar to open first thing

**Authoring in this repo (Phases 0–2):**

- `grammars/Gemfile` — add `gem "lutaml-xsd", path: "../lutaml-xsd"`
- `grammars/doc-build/configs/{biblio,relaton,isodoc,isodoc-presentation}.yml` — the four configs
- `grammars/.gitignore` — add `doc-build/out/`
- `documentation/document.adoc` — resurrect (originated `fa72827e`)
- `documentation/sections/0X-*.adoc` — resurrect from `fa72827e`/`f87523e8`/`fefdc23d`
- `documentation/schemas/{biblio,relaton,isodoc,isodoc-presentation}/elements/<name>.adoc` — new per-element files, layered per issue 90

**Salvage sources (read-only, external):**

- `CalConnect/cc-lightweight-doc` (`sources/sections/`, `sections-iso/`, `models/`, `basicdoc-models/`)
- `CalConnect/cc-citation-models` (`sources/sections/`, `sections-iso/`, `data/`, `relaton-models/`)
- **UML class visualisations** at `metanorma/metanorma-model-standoc/models/` and `metanorma/metanorma-model-standoc/views/`, plus the local submodule trees `grammars/basicdoc-models/` and `grammars/relaton-models/`. Treat as reference, not authoritative — possibly out of step with current `.rnc`; verify before lifting. Useful for: the `Classes:` header line on per-element pages (where named-pattern membership is visualised), the `02-ontology` chapter's class hierarchy and relations material, and any structural diagrams worth folding into the cross-cutting chapters.
- `metanorma/metanorma.org` — **secondary source**, different range of concerns (end-user docs + dev-side config rather than XML schemas), mine for transferable prose on document model, terminology, conceptual structure, semantic-vs-presentation explanations. Focus areas: `develop/`, `build/`, plus end-user explanations of metanorma's structure.
- `https://relaton.org` — Relaton documentation site, **for relaton-specific documentation when it gets actioned** (not in Phase 1 — see explicit disclaimer below). Combined with `CalConnect/cc-citation-models` and the `grammars/relaton-models/` submodule, this is the corpus when the relaton-side documentation effort begins.

### Explicit disclaimer — relaton documentation deferred

Relaton documentation already exists at `https://relaton.org` and in `CalConnect/cc-citation-models`. The per-flavour relaton metadata grammars (`relaton-iso.rnc`, `relaton-bsi.rnc`, …) are first-class current artefacts and *will* eventually get their own documentation trees in `documentation/schemas/relaton-iso/`, `documentation/schemas/relaton-bsi/`, etc. But Phase 1's salvage scope **excludes** them. Phase 0's `relaton-iso` build target stays — that's engine validation against a current grammar, not documentation authoring. Phase 1 and later focus the editorial effort on `basicdoc`, `biblio`, `biblio-standoc`, `biblio-presentation`, `isodoc`, `isodoc-presentation`. Relaton documentation gets its own phase when scheduled, with the relaton.org + CalConnect + submodule corpus folded in then.
- **Local `documentation/document.xml`** (172 KB Semantic XML, April 10 2025) — **primary salvage source**, superset of the GitHub commits
- Local `documentation/document.{html,pdf,doc,presentation.xml}` — same render, visual / format reference
- Local `documentation/plantuml/*.png` × 16 — diagrams from the same render; PlantUML source recoverable from `document.xml`
- Three commits on `main` in `metanorma/metanorma-model-iso`: `fa72827e`, `f87523e8`, `fefdc23d` — subset of the above, useful as structural cross-check

## Verification

**After Phase 0:**

- Four SPAs build cleanly from this repo's grammars without error.
- Sanity-check structural equivalence of `doc-build/out/isodoc.html` to the existing `iec-test.html` exemplar (similar Vue SPA shell, namespace/sidebar populated, fuzzy search works).
- Opening `doc-build/out/isodoc.html` in a browser shows the `##` comments the user already wrote in `isodoc.rnc` against the corresponding elements (e.g. searching `amend` finds the element with its existing one-line description).

**After Phase 1:**

- `documentation/` tree committed; `metanorma document.adoc` produces an updated `document.html` comparable in size and coverage to the 2025-04-10 render (~220 KB HTML) but with the salvaged CalConnect prose folded in.
- Every per-element file in `documentation/schemas/<schema>/elements/` either has content or is an explicit stub.
- Every per-element file carries a stable `[#<name>]` anchor matching its grammar `define`.

**After Phase 2:**

- The cross-link invariant checker passes: every `define` in the four grammars has a matching anchored AsciiDoc file (or `_no-narrative.txt` opt-out).

**After Phase 3:**

- A `lutaml-xsd spa --prose-dir ../documentation/schemas/isodoc --narrative-base https://example/develop/isodoc/document.html isodoc.lxr -o isodoc.html` invocation produces a SPA where each element panel has tabs (Concept / Model / Semantic / Presentation / Rendering / Flavours) with the rendered AsciiDoc from the corresponding `documentation/schemas/isodoc/elements/<name>.adoc`, plus a "Discussion" link to `<narrative-base>#<name>`.
- The SPA emits stable `#define-<name>` URL fragments; navigating to one directly opens the right element panel.
- Round-trip: change one prose file, rebuild, refresh — change appears.
- **Twin-artefact verification.** Pick `isodoc/amend`: navigate from the narrative document's `[#amend]` link to the SPA's `#define-amend` and back. Both directions work. Repeat for one element with a stub-only narrative (link still works, just thinly populated). Repeat for one element with an opt-out (no link emitted, SPA renders only `##` short form).

**After Phase 4:**

- The four SPAs are hosted, linked from metanorma's dev-docs index, and the link from `lutaml-xsd/docs/DEPLOYMENT_GUIDE.adoc` is either updated to point at this hosting or removed as obsolete.

## Risks / coordination notes

- **Phase 3 is gated on `@HassanAkbar` / `@ronaldtse`.** This isn't a unilateral change. Raise the Phase 3 design as a separate issue on `lutaml/lutaml-xsd` before writing code, since the SPA serialiser changes will have to land in a coordinated release per `github-no-releases`.
- **Fixture drift in lutaml-xsd.** The stale `metanorma-model-iso-grammars/` fixture inside lutaml-xsd should be raised — either submodule it from this repo or drop and replace with synthetic grammars. Side-task at most; not Phase 3's load.
- **No releases until coordinated.** Per `github-no-releases`, all version bumps wait for the fortnightly batch. Use `Gemfile.devel` for in-flight branch testing of lutaml-xsd Phase 3 work.
- **Document-level flavour grammars (deprecated).** Don't waste effort documenting `isostandard.rnc` / `iso.rnc` / `bsi.rnc` / `iec.rnc` / etc. They're going away. The two exceptions (ietf attribute customisation, nist custom elements) get a flavour-idiosyncrasies stanza inside the relevant element files — not their own SPA.
- **Per-flavour relaton metadata grammars (first-class).** The `relaton-*.rnc` family is *not* deprecated — per-SDO bibliographic metadata legitimately differs. `relaton-iso` is the Phase 0 exemplar; the rest (`relaton-bsi`, `relaton-iec`, `relaton-ieee`, `relaton-ietf`, `relaton-nist`, `relaton-itu`, `relaton-jis`, `relaton-bipm`, `relaton-plateau`, `relaton-ogc`, …) get their own SPAs in parallel as the corpus expands. Same documentation treatment as the core schemas.
- **Phase 2 is open-ended.** The editorial effort is the long pole. Phasing the SPA work (Phases 0, 3, 4) before Phase 2 finishes is fine — the SPA just renders whatever's there, with stubs visible as stubs.
- **Don't replicate.** The opening post of issue #90 was emphatic: single source, no parallel maintenance. The grammars' inline `##` comments stay the *short* form; the `documentation/schemas/<schema>/elements/<name>.adoc` files carry the *long* form. The SPA shows both — long form when present, falling back to `##` short form when not.

---

🤖 Generated with [Claude Code](https://claude.com/claude-code)
