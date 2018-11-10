cp biblio.rng ../../metanorma-standoc/lib/asciidoctor/standoc
cat isodoc.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="http://riboseinc.com/isoxml" }) '> ../../metanorma-standoc/lib/asciidoctor/standoc/isodoc.rng
cp biblio.rng ../../metanorma-iso/lib/asciidoctor/iso
cp isodoc.rng ../../metanorma-iso/lib/asciidoctor/iso
cp isostandard.rng ../../metanorma-iso/lib/asciidoctor/iso
cp biblio.rng ../../metanorma-gb/lib/asciidoctor/gb
cp isodoc.rng ../../metanorma-gb/lib/asciidoctor/gb
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-gb/lib/asciidoctor/gb/isostandard.rng
cp gbstandard.rng ../../metanorma-gb/lib/asciidoctor/gb
cp biblio.rng ../../metanorma-csd/lib/asciidoctor/csd
cp isodoc.rng ../../metanorma-csd/lib/asciidoctor/csd
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-csd/lib/asciidoctor/csd/isostandard.rng
cp csd.rng ../../metanorma-csd/lib/asciidoctor/csd
cp biblio.rng ../../metanorma-csand/lib/asciidoctor/csand
cp isodoc.rng ../../metanorma-csand/lib/asciidoctor/csand
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-csand/lib/asciidoctor/csand/isostandard.rng
cp csand.rng ../../metanorma-m3d/lib/asciidoctor/csand
cp biblio.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cp isodoc.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-m3d/lib/asciidoctor/m3d/isostandard.rng
cp m3d.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cp biblio.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cp isodoc.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-rsd/lib/asciidoctor/rsd/isostandard.rng
cp rsd.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cp biblio.rng ../../metanorma-sample/lib/asciidoctor/sample
cp isodoc.rng ../../metanorma-sample/lib/asciidoctor/sample
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-sample/lib/asciidoctor/sample/isostandard.rng
cat rsd.rng | ruby -pe '$_.gsub!(/rsd-standard/, "sample-standard") ' > ../../metanorma-sample/lib/asciidoctor/sample/sample.rng
cp biblio.rng ../../metanorma-acme/lib/asciidoctor/acme
cp isodoc.rng ../../metanorma-acme/lib/asciidoctor/acme
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-acme/lib/asciidoctor/acme/isostandard.rng
cat rsd.rng | ruby -pe '$_.gsub!(/rsd-standard/, "acme-standard") ' > ../../metanorma-acme/lib/asciidoctor/acme/acme.rng
cp biblio.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cp isodoc.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-mpfd/lib/asciidoctor/mpfd/isostandard.rng
cp mpfd.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cp biblio.rng ../../metanorma-unece/lib/asciidoctor/unece
cp isodoc.rng ../../metanorma-unece/lib/asciidoctor/unece
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-unece/lib/asciidoctor/unece/isostandard.rng
cp unece.rng ../../metanorma-unece/lib/asciidoctor/unece
