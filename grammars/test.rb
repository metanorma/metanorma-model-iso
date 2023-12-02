require "jing"

ret = ""
GRAMMARS = %w(biblio-compile isodoc-compile isostandard-compile isostandard-amd
              iec generic csd csa gbstandard m3d rsd ieee un ogc nist itu ietf
              iho bipm jis
              bsi relaton-ieee-compile relaton-iso-compile relaton-iec-compile
              relaton-bsi-compile relaton-gb-compile relaton-mpfa-compile
              relaton-bipm-compile relaton-w3c-compile relaton-3gpp-compile
              relaton-csa-compile relaton-cc-compile relaton-ietf-compile
              relaton-iho-compile relaton-itu-compile relaton-m3aawg-compile
              relaton-nist-compile relaton-ribose-compile relaton-ogc-compile
              relaton-un-compile relaton-cen-compile relaton-ecma-compile
              relaton-cie-compile relaton-iana-compile relaton-omg-compile
              relaton-oasis-compile relaton-jis-compile relaton-etsi-compile).freeze

GRAMMARS.each do |g|
  warn "validating #{g}"
  errors = Jing.new("#{g}.rng", encoding: "UTF-8").validate("test.xml")
  errors.each do |e|
    ret += "#{g}: #{e}" if /multiple definitions/.match?(e[:message])
  end
rescue Jing::Error => e
  ret + "#{g}: Jing failed with error: #{e}"
end
ret.empty? or warn "\n\n***ERRORS***\n#{ret}\n"
