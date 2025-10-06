require "jing"

def check_interleaving_in_include(filename)
  errors = []
  return errors unless File.exist?(filename)
  
  lines = File.readlines(filename)
  in_include_block = false
  brace_depth = 0
  include_start_depth = 0
  
  lines.each_with_index do |line, idx|
    line_num = idx + 1
    
    # Check if we're starting an include block
    if line =~ /include\s+"[^"]+"\s*\{/
      in_include_block = true
      include_start_depth = brace_depth
      # Count braces on this line
      brace_depth += line.count('{') - line.count('}')
    elsif in_include_block
      # Update brace depth
      brace_depth += line.count('{') - line.count('}')
      
      # Check if we've exited the include block
      if brace_depth <= include_start_depth
        in_include_block = false
      end
    else
      # Not in include block, just track braces
      brace_depth += line.count('{') - line.count('}')
    end
    
    # Check for interleaving operators inside include block
    if in_include_block && line =~ /[&|]=/ && brace_depth > include_start_depth
      errors << "#{filename}:#{line_num}: Interleaving operator found inside include block: #{line.strip}"
    end
  end
  
  errors
end

ret = ""
GRAMMARS =
  %w(biblio-compile isodoc-compile isodoc-presentation-compile
     isostandard-compile isostandard-amd
     iec generic csd csa gbstandard m3d rsd ieee un ogc nist itu ietf
     iho bipm bsi jis plateau
     relaton-ieee-compile relaton-iso-compile relaton-iec-compile
     relaton-bsi-compile relaton-gb-compile relaton-mpfa-compile
     relaton-bipm-compile relaton-w3c-compile relaton-3gpp-compile
     relaton-csa-compile relaton-cc-compile relaton-ietf-compile
     relaton-iho-compile relaton-itu-compile relaton-m3aawg-compile
     relaton-nist-compile relaton-ribose-compile relaton-ogc-compile
     relaton-un-compile relaton-cen-compile relaton-ecma-compile
     relaton-cie-compile relaton-iana-compile relaton-omg-compile
     relaton-oasis-compile relaton-jis-compile relaton-etsi-compile
     relaton-plateau-compile relaton-ccdsd-compile)
    .freeze

GRAMMARS.each do |g|
  warn "validating #{g}"
  
  # Check for interleaving in include blocks
  interleave_errors = check_interleaving_in_include("#{g}.rnc")
  interleave_errors.each do |err|
    ret += "#{err}\n"
  end
  
  errors = Jing.new("#{g}.rng", encoding: "UTF-8").validate("test.xml")
  errors.each do |e|
    ret += "#{g}: #{e}" if /multiple definitions/.match?(e[:message])
  end
rescue Jing::Error => e
  ret + "#{g}: Jing failed with error: #{e}"
end
ret.empty? or warn "\n\n***ERRORS***\n#{ret}\n"
