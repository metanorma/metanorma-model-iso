#!/usr/bin/env ruby
# frozen_string_literal: true

# Walk each of the six document-side grammars and emit a stub AsciiDoc file at
# documentation/schemas/<schema>/elements/<define-name>.adoc for every top-level
# `name = ...` define that doesn't already have a file. Idempotent — never
# overwrites existing content; safe to re-run after grammar changes to fill in
# new stubs.
#
# Phase 1 scope: ALL top-level defines land under elements/. The attribute and
# named-group splits into attributes/ and groups/ are deferred to a follow-up
# pass — once the SPA is producing content again (waiting on lutaml/rng#19) we
# can see the attribute-vs-element distinction the parser draws and align the
# tree to it. Premature splitting risks misclassifying.

require "fileutils"
require "pathname"

REPO_ROOT = Pathname.new(File.expand_path("../../..", __FILE__))
GRAMMARS  = REPO_ROOT / "grammars"
SCHEMAS   = REPO_ROOT / "documentation/schemas"

# Six document-side conceptual layers; each maps to one .rnc root in grammars/.
LAYERS = {
  "basicdoc"            => "basicdoc.rnc",
  "biblio"              => "biblio.rnc",
  "biblio-standoc"      => "biblio-standoc.rnc",
  "biblio-presentation" => "biblio-presentation.rnc",
  "isodoc"              => "isodoc.rnc",
  "isodoc-presentation" => "isodoc-presentation.rnc",
}

# Top-level define: a line at column 0 that starts with a non-terminal name
# followed by `=`. Excludes lines that are inside element/attribute/group bodies
# (those would be indented). Excludes `start =` (handled separately at the SPA
# level). Excludes lines inside `## ` doc-comments and inside `# `-stripped
# maintainer comments. The pattern is deliberately conservative.
DEFINE_RE = /\A([A-Za-z][A-Za-z0-9_.-]*)\s*=/.freeze

def extract_defines(rnc_path)
  defines = []
  rnc_path.each_line do |line|
    next if line.start_with?("#", " ", "\t", "}", "{")
    next if line.start_with?("include ", "namespace ", "default ", "start ")
    m = DEFINE_RE.match(line)
    next unless m

    defines << m[1]
  end
  defines.uniq.sort
end

def stub_body(name, schema)
  <<~ADOC
    [#'#{name}']
    = `#{name}`
    :schema: #{schema}

    // TODO: salvage prose for this non-terminal. The anchor `[##{name}]`
    // above is the canonical stable ID that grammar `## @see <<#{name}>>`
    // references will resolve to (per documentation/RNC-COMMENT-CONVENTIONS.adoc).
    //
    // Per-element structure (see plans/Schema-documentation-master-plan.md
    // §Per-element layer scheme):
    //   - one-line summary (TEI <desc>-style)
    //   - Relaton layer (citation-model elements only)
    //   - Semantic XML (StanDoc body + Flavours subsections)
    //   - Presentation XML (StanDoc body + Flavours subsections)
    //   - Rendering (HTML / PDF / DOC / Firelight / other formats)
    //   - Examples (XML usage exemplars)
    //   - See also (sibling / variant cross-references)

    [discrete]
    == Schema definition

    See the corresponding SPA panel: link:../../../../#{schema}.html#define-#{name}[#{schema}.html#define-#{name}]
  ADOC
    .sub(/\[#'(#{Regexp.escape(name)})'\]/, "[##{name}]") # ASCII anchor without surrounding quotes
end

total_created = 0
total_existing = 0

LAYERS.each do |schema, rnc_filename|
  rnc_path = GRAMMARS / rnc_filename
  unless rnc_path.exist?
    warn "  (skip: #{rnc_path} does not exist — submodule not fetched?)"
    next
  end

  defines = extract_defines(rnc_path)
  target  = SCHEMAS / schema / "elements"
  FileUtils.mkdir_p(target)

  created = 0
  existing = 0
  defines.each do |name|
    file = target / "#{name}.adoc"
    if file.exist?
      existing += 1
      next
    end
    File.write(file, stub_body(name, schema))
    created += 1
  end

  total_created += created
  total_existing += existing
  puts "  #{schema}: #{defines.size} defines, #{created} created, #{existing} already existed"
end

puts ""
puts "Total: #{total_created} stub files created, #{total_existing} preserved."
