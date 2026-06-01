#!/usr/bin/env ruby

require "fileutils"

rnc_files = Dir.glob("grammars/**/*.rnc")

rnc_files.each do |file|
  # copy the file to the same directory "grammars"
  dest = "grammars/#{File.basename(file)}"
  FileUtils.cp(file, dest) unless File.exist?(dest)
end
