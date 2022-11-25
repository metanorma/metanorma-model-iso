require "jing"

ret = ""

%w(isodoc-compile relaton-cen).each do |g|
  errors = Jing.new("#{g}.rng", encoding: "UTF-8").validate("test.xml")
  errors.each do |e|
    ret += "#{g}: #{e.to_s}" if /multiple definitions/.match?(e[:message])
  end
rescue Jing::Error => e
  ret + "#{g}: Jing failed with error: #{e}"
end
ret.empty? or warn "\n\n***ERRORS***\n#{ret}\n"
