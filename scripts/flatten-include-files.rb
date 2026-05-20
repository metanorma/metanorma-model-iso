#!/usr/bin/env ruby

require "fileutils"

rnc_files = Dir.glob("grammars/**/*.rnc")

rnc_files.each do |file|
  # copy the file to the same directory "grammars"
  dest = "grammars/#{File.basename(file)}"
  FileUtils.cp(file, dest) unless File.exist?(dest)
end

# ---------------------------------------------------------------------------
# TODO: REMOVE WHEN lutaml/rng#19 IS FIXED
# https://github.com/lutaml/rng/issues/19
#
# lutaml/rng's RNC parser does not recurse into the standard RelaxNG
# `grammar { ... }` enclosing block. All real-world metanorma `.rnc` files
# open with this block, so the SPA documentation pipeline yields schemas
# with zero types / elements / groups / attributes inside.
#
# Workaround: strip the outer `grammar {` ... matching `}` from every
# top-level `grammars/*.rnc` after flattening. The wrapper is purely
# syntactic; the content inside is identical to top-level RNC, so this
# preserves semantics for the documentation pipeline.
#
# Once lutaml/rng#19 is fixed and the new gem is in the build's Gemfile
# resolution, DELETE THIS BLOCK in full.
# ---------------------------------------------------------------------------
Dir.glob("grammars/*.rnc").each do |path|
  src = File.read(path, encoding: "UTF-8")
  # Match a leading `grammar {` (possibly with whitespace/blank lines before
  # or after the brace) and its matching closing `}` at the end of file
  # (possibly followed by trailing whitespace). Only strip when both are
  # present — leaves include-only roots like relaton-iso-compile.rnc alone.
  m = src.match(/\Agrammar\s*\{\s*\n?(.*)\n?\}\s*\z/m)
  next unless m

  File.write(path, m[1])
end
