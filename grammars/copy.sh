cp biblio.rng ../../asciidoctor-iso/lib/asciidoctor/iso
cp isodoc.rng ../../asciidoctor-iso/lib/asciidoctor/iso
cp isostandard.rng ../../asciidoctor-iso/lib/asciidoctor/iso
cp biblio.rng ../../asciidoctor-gb/lib/asciidoctor/gb
cp isodoc.rng ../../asciidoctor-gb/lib/asciidoctor/gb
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../asciidoctor-gb/lib/asciidoctor/gb/isostandard.rng
cp gbstandard.rng ../../asciidoctor-gb/lib/asciidoctor/gb
cp biblio.rng ../../asciidoctor-csd/lib/asciidoctor/csd
cp isodoc.rng ../../asciidoctor-csd/lib/asciidoctor/csd
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../asciidoctor-csd/lib/asciidoctor/csd/isostandard.rng
cp csd.rng ../../asciidoctor-csd/lib/asciidoctor/csd
cp biblio.rng ../../asciidoctor-csand/lib/asciidoctor/csand
cp isodoc.rng ../../asciidoctor-csand/lib/asciidoctor/csand
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../asciidoctor-csand/lib/asciidoctor/csand/isostandard.rng
cp csand.rng ../../asciidoctor-m3d/lib/asciidoctor/csand
cp biblio.rng ../../asciidoctor-m3d/lib/asciidoctor/m3d
cp isodoc.rng ../../asciidoctor-m3d/lib/asciidoctor/m3d
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../asciidoctor-m3d/lib/asciidoctor/m3d/isostandard.rng
cp m3d.rng ../../asciidoctor-m3d/lib/asciidoctor/m3d
cp biblio.rng ../../asciidoctor-rsd/lib/asciidoctor/rsd
cp isodoc.rng ../../asciidoctor-rsd/lib/asciidoctor/rsd
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../asciidoctor-rsd/lib/asciidoctor/rsd/isostandard.rng
cp m3d.rng ../../asciidoctor-rsd/lib/asciidoctor/rsd
