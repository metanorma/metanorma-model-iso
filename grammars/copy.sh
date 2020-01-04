cp basicdoc.rng ../../metanorma-standoc/lib/asciidoctor/standoc
cp reqt.rng ../../metanorma-standoc/lib/asciidoctor/standoc
cp biblio.rng ../../metanorma-standoc/lib/asciidoctor/standoc
cat isodoc.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="http://riboseinc.com/isoxml" }) '> ../../metanorma-standoc/lib/asciidoctor/standoc/isodoc.rng
cp basicdoc.rng ../../metanorma-iso/lib/asciidoctor/iso
cp reqt.rng ../../metanorma-iso/lib/asciidoctor/iso
cp biblio.rng ../../metanorma-iso/lib/asciidoctor/iso
cp isodoc.rng ../../metanorma-iso/lib/asciidoctor/iso
cp isostandard.rng ../../metanorma-iso/lib/asciidoctor/iso
cp basicdoc.rng ../../metanorma-iec/lib/asciidoctor/iec
cp reqt.rng ../../metanorma-iec/lib/asciidoctor/iec
cp biblio.rng ../../metanorma-iec/lib/asciidoctor/iec
cp isodoc.rng ../../metanorma-iec/lib/asciidoctor/iec
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-iec/lib/asciidoctor/iec/isostandard.rng
cp iec.rng ../../metanorma-iec/lib/asciidoctor/iec
cp basicdoc.rng ../../metanorma-gb/lib/asciidoctor/gb
cp reqt.rng ../../metanorma-gb/lib/asciidoctor/gb
cp biblio.rng ../../metanorma-gb/lib/asciidoctor/gb
cp isodoc.rng ../../metanorma-gb/lib/asciidoctor/gb
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-gb/lib/asciidoctor/gb/isostandard.rng
cp gbstandard.rng ../../metanorma-gb/lib/asciidoctor/gb
cp basicdoc.rng ../../metanorma-csd/lib/asciidoctor/csd
cp reqt.rng ../../metanorma-csd/lib/asciidoctor/csd
cp biblio.rng ../../metanorma-csd/lib/asciidoctor/csd
cp isodoc.rng ../../metanorma-csd/lib/asciidoctor/csd
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-csd/lib/asciidoctor/csd/isostandard.rng
cp csd.rng ../../metanorma-csd/lib/asciidoctor/csd
cp basicdoc.rng ../../metanorma-csand/lib/asciidoctor/csand
cp reqt.rng ../../metanorma-csand/lib/asciidoctor/csand
cp biblio.rng ../../metanorma-csand/lib/asciidoctor/csand
cp isodoc.rng ../../metanorma-csand/lib/asciidoctor/csand
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-csand/lib/asciidoctor/csand/isostandard.rng
cp csand.rng ../../metanorma-csand/lib/asciidoctor/csand
cp basicdoc.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cp reqt.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cp biblio.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cp isodoc.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-m3d/lib/asciidoctor/m3d/isostandard.rng
cp m3d.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cp basicdoc.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cp reqt.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cp biblio.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cp isodoc.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-rsd/lib/asciidoctor/rsd/isostandard.rng
cp rsd.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cp basicdoc.rng ../../metanorma-sample/lib/asciidoctor/sample
cp reqt.rng ../../metanorma-sample/lib/asciidoctor/sample
cp biblio.rng ../../metanorma-sample/lib/asciidoctor/sample
cp isodoc.rng ../../metanorma-sample/lib/asciidoctor/sample
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-sample/lib/asciidoctor/sample/isostandard.rng
cat rsd.rng | ruby -pe '$_.gsub!(/rsd-standard/, "sample-standard") ' > ../../metanorma-sample/lib/asciidoctor/sample/sample.rng
cp basicdoc.rng ../../metanorma-acme/lib/asciidoctor/acme
cp reqt.rng ../../metanorma-acme/lib/asciidoctor/acme
cp biblio.rng ../../metanorma-acme/lib/asciidoctor/acme
cp isodoc.rng ../../metanorma-acme/lib/asciidoctor/acme
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-acme/lib/asciidoctor/acme/isostandard.rng
cat rsd.rng | ruby -pe '$_.gsub!(/rsd-standard/, "acme-standard") ' > ../../metanorma-acme/lib/asciidoctor/acme/acme.rng
cp basicdoc.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cp reqt.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cp biblio.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cp isodoc.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-mpfd/lib/asciidoctor/mpfd/isostandard.rng
cp mpfd.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cp basicdoc.rng ../../metanorma-unece/lib/asciidoctor/unece
cp reqt.rng ../../metanorma-unece/lib/asciidoctor/unece
cp biblio.rng ../../metanorma-unece/lib/asciidoctor/unece
cp isodoc.rng ../../metanorma-unece/lib/asciidoctor/unece
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-unece/lib/asciidoctor/unece/isostandard.rng
cp unece.rng ../../metanorma-unece/lib/asciidoctor/unece
cp basicdoc.rng ../../metanorma-ogc/lib/asciidoctor/ogc
cp reqt.rng ../../metanorma-ogc/lib/asciidoctor/ogc
cp biblio.rng ../../metanorma-ogc/lib/asciidoctor/ogc
cp isodoc.rng ../../metanorma-ogc/lib/asciidoctor/ogc
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-ogc/lib/asciidoctor/ogc/isostandard.rng
cp ogc.rng ../../metanorma-ogc/lib/asciidoctor/ogc
cp basicdoc.rng ../../metanorma-nist/lib/asciidoctor/nist
cp reqt.rng ../../metanorma-nist/lib/asciidoctor/nist
cp biblio.rng ../../metanorma-nist/lib/asciidoctor/nist
cp isodoc.rng ../../metanorma-nist/lib/asciidoctor/nist
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-nist/lib/asciidoctor/nist/isostandard.rng
cp nist.rng ../../metanorma-nist/lib/asciidoctor/nist
cp basicdoc.rng ../../metanorma-ietf/lib/asciidoctor/ietf
cp reqt.rng ../../metanorma-ietf/lib/asciidoctor/ietf
cp biblio.rng ../../metanorma-ietf/lib/asciidoctor/ietf
cp isodoc.rng ../../metanorma-ietf/lib/asciidoctor/ietf
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-ietf/lib/asciidoctor/ietf/isostandard.rng
cp ietf.rng ../../metanorma-ietf/lib/asciidoctor/ietf
cp basicdoc.rng ../../metanorma-itu/lib/asciidoctor/itu
cp reqt.rng ../../metanorma-itu/lib/asciidoctor/itu
cp biblio.rng ../../metanorma-itu/lib/asciidoctor/itu
cp isodoc.rng ../../metanorma-itu/lib/asciidoctor/itu
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-itu/lib/asciidoctor/itu/isostandard.rng
cp itu.rng ../../metanorma-itu/lib/asciidoctor/itu
cp basicdoc.rng ../../metanorma-vsd/lib/asciidoctor/vsd
cp reqt.rng ../../metanorma-vsd/lib/asciidoctor/vsd
cp biblio.rng ../../metanorma-vsd/lib/asciidoctor/vsd
cp isodoc.rng ../../metanorma-vsd/lib/asciidoctor/vsd
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar ns=\S+/, "<grammar") ' >  ../../metanorma-vsd/lib/asciidoctor/vsd/isostandard.rng
cp rsd.rng ../../metanorma-vsd/lib/asciidoctor/vsd/vsd.rng
