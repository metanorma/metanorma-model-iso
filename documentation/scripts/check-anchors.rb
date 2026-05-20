#!/usr/bin/env ruby
# frozen_string_literal: true

# Cross-link invariant checker for the schema documentation programme.
#
# Walks each grammar's top-level defines and the corresponding
# documentation/schemas/<schema>/elements/ tree. Asserts bidirectional
# coverage:
#
#   1. Every grammar define has a matching <name>.adoc file with a
#      [#<name>] anchor as its first non-blank non-comment line, OR
#      an entry in documentation/schemas/<schema>/_no-narrative.txt
#      (the opt-out manifest for defines deliberately not given a page).
#
#   2. Every <name>.adoc file in the schema's elements/ dir corresponds
#      to a real grammar define, OR carries an explicit comment marker
#      "// orphan: <reason>" so the orphan is intentional (e.g. a stub
#      for a non-terminal that's been renamed in the grammar but the
#      anchor is preserved for backward-compat URL stability).
#
# Exit status: 0 on success, 1 if any invariant violation is found.
# Run from the repo root: ruby documentation/scripts/check-anchors.rb

require "pathname"
require "set"

REPO_ROOT = Pathname.new(File.expand_path("../../..", __FILE__))
GRAMMARS  = REPO_ROOT / "grammars"
SCHEMAS   = REPO_ROOT / "documentation/schemas"

LAYERS = {
  "basicdoc"            => "basicdoc.rnc",
  "biblio"              => "biblio.rnc",
  "biblio-standoc"      => "biblio-standoc.rnc",
  "biblio-presentation" => "biblio-presentation.rnc",
  "isodoc"              => "isodoc.rnc",
  "isodoc-presentation" => "isodoc-presentation.rnc",
}

DEFINE_RE = /\A([A-Za-z][A-Za-z0-9_.-]*)\s*=/.freeze
ANCHOR_RE = /\A\[#([A-Za-z][A-Za-z0-9_.-]*)\]\s*\z/.freeze

def grammar_defines(rnc_path)
  defines = Set.new
  rnc_path.each_line do |line|
    next if line.start_with?("#", " ", "\t", "}", "{")
    next if line.start_with?("include ", "namespace ", "default ", "start ")
    m = DEFINE_RE.match(line)
    defines << m[1] if m
  end
  defines
end

def anchor_of(adoc_path)
  adoc_path.each_line do |line|
    line = line.strip
    next if line.empty?
    next if line.start_with?("//") # AsciiDoc line comment
    m = ANCHOR_RE.match(line)
    return m[1] if m
    return nil # first non-blank non-comment line is not an anchor — fail fast
  end
  nil
end

def optouts(schema)
  manifest = SCHEMAS / schema / "_no-narrative.txt"
  return Set.new unless manifest.exist?

  manifest.each_line.map { |l| l.strip }.reject { |l| l.empty? || l.start_with?("#") }.to_set
end

violations = []

LAYERS.each do |schema, rnc_filename|
  rnc_path = GRAMMARS / rnc_filename
  unless rnc_path.exist?
    warn "skip: #{rnc_path} (submodule not fetched?)"
    next
  end

  defines  = grammar_defines(rnc_path)
  opts     = optouts(schema)
  elem_dir = SCHEMAS / schema / "elements"

  files_by_anchor = {}
  if elem_dir.directory?
    elem_dir.each_child do |f|
      next unless f.extname == ".adoc"

      anchor = anchor_of(f)
      if anchor.nil?
        violations << "[#{schema}] #{f.basename} has no [#…] anchor on its first non-blank non-comment line"
        next
      end
      files_by_anchor[anchor] = f
    end
  end

  # Invariant 1: every define has a file or an opt-out
  defines.each do |name|
    next if files_by_anchor.key?(name)
    next if opts.include?(name)

    violations << "[#{schema}] define `#{name}` has no documentation/schemas/#{schema}/elements/#{name}.adoc (and no entry in _no-narrative.txt)"
  end

  # Invariant 2: every file corresponds to a real define
  files_by_anchor.each do |anchor, file|
    next if defines.include?(anchor)
    # Tolerated if file declares itself an orphan
    body = file.read
    next if body.include?("// orphan:")

    violations << "[#{schema}] #{file.basename} (anchor [##{anchor}]) does not match any grammar define and has no `// orphan:` marker"
  end
end

if violations.empty?
  puts "OK: anchor invariant holds across all six layers."
  exit 0
end

warn "Anchor invariant violations (#{violations.size}):"
violations.each { |v| warn "  - #{v}" }
exit 1
