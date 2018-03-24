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
