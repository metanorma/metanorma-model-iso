cp basicdoc.rng ../../metanorma-standoc/lib/asciidoctor/standoc
cp reqt.rng ../../metanorma-standoc/lib/asciidoctor/standoc
cp biblio.rng ../../metanorma-standoc/lib/asciidoctor/standoc
cat isodoc.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/standoc" }) '> ../../metanorma-standoc/lib/asciidoctor/standoc/isodoc.rng
cp basicdoc.rng ../../metanorma-iso/lib/asciidoctor/iso
cp reqt.rng ../../metanorma-iso/lib/asciidoctor/iso
cp biblio.rng ../../metanorma-iso/lib/asciidoctor/iso
cp isodoc.rng ../../metanorma-iso/lib/asciidoctor/iso
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iso" }) '>  ../../metanorma-iso/lib/asciidoctor/iso/isostandard.rng
cat isostandard-amd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iso" }) '>  ../../metanorma-iso/lib/asciidoctor/iso/isostandard-amd.rng
cp basicdoc.rng ../../metanorma-iec/lib/asciidoctor/iec
cp reqt.rng ../../metanorma-iec/lib/asciidoctor/iec
cp biblio.rng ../../metanorma-iec/lib/asciidoctor/iec
cp isodoc.rng ../../metanorma-iec/lib/asciidoctor/iec
cp isostandard.rng ../../metanorma-iec/lib/asciidoctor/iec/isostandard.rng
cat iec.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iec" }) '>  ../../metanorma-iec/lib/asciidoctor/iec/iec.rng
cp basicdoc.rng ../../metanorma-gb/lib/asciidoctor/gb
cp reqt.rng ../../metanorma-gb/lib/asciidoctor/gb
cp biblio.rng ../../metanorma-gb/lib/asciidoctor/gb
cp isodoc.rng ../../metanorma-gb/lib/asciidoctor/gb
cp isostandard.rng ../../metanorma-gb/lib/asciidoctor/gb/isostandard.rng
cat gbstandard.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/gb" }) '>  ../../metanorma-gb/lib/asciidoctor/gb/gbstandard.rng
cp basicdoc.rng ../../metanorma-csd/lib/asciidoctor/csd
cp reqt.rng ../../metanorma-csd/lib/asciidoctor/csd
cp biblio.rng ../../metanorma-csd/lib/asciidoctor/csd
cp isodoc.rng ../../metanorma-csd/lib/asciidoctor/csd
cat csd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/csd" }) '>  ../../metanorma-csd/lib/asciidoctor/csd/csd.rng
cp basicdoc.rng ../../metanorma-csand/lib/asciidoctor/csa
cp reqt.rng ../../metanorma-csand/lib/asciidoctor/csa
cp biblio.rng ../../metanorma-csand/lib/asciidoctor/csa
cp isodoc.rng ../../metanorma-csand/lib/asciidoctor/csa
cat csa.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/csa" }) '>  ../../metanorma-csand/lib/asciidoctor/csa/csa.rng
cp basicdoc.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cp reqt.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cp biblio.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cp isodoc.rng ../../metanorma-m3d/lib/asciidoctor/m3d
cat m3d.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/m3d" }) '>  ../../metanorma-m3d/lib/asciidoctor/m3d/m3d.rng
cp basicdoc.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cp reqt.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cp biblio.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cp isodoc.rng ../../metanorma-rsd/lib/asciidoctor/rsd
cat rsd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/rsd" }) '>  ../../metanorma-rsd/lib/asciidoctor/rsd/rsd.rng
cp basicdoc.rng ../../metanorma-sample/lib/asciidoctor/sample
cp reqt.rng ../../metanorma-sample/lib/asciidoctor/sample
cp biblio.rng ../../metanorma-sample/lib/asciidoctor/sample
cp isodoc.rng ../../metanorma-sample/lib/asciidoctor/sample
cat rsd.rng | ruby -pe '$_.gsub!(/rsd-standard/, "sample-standard") ' | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/sample" }) '  > ../../metanorma-sample/lib/asciidoctor/sample/sample.rng
cp basicdoc.rng ../../metanorma-acme/lib/asciidoctor/generic
cp reqt.rng ../../metanorma-acme/lib/asciidoctor/generic
cp biblio.rng ../../metanorma-acme/lib/asciidoctor/generic
cp isodoc.rng ../../metanorma-acme/lib/asciidoctor/generic
cat rsd.rng | ruby -pe '$_.gsub!(/rsd-standard/, "generic-standard") ' | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/generic" }) ' > ../../metanorma-acme/lib/asciidoctor/generic/generic.rng
cp basicdoc.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cp reqt.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cp biblio.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cp isodoc.rng ../../metanorma-mpfd/lib/asciidoctor/mpfd
cat mpfd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/mpfd" }) '>  ../../metanorma-mpfd/lib/asciidoctor/mpfd/mpfd.rng
cp basicdoc.rng ../../metanorma-unece/lib/asciidoctor/un
cp reqt.rng ../../metanorma-unece/lib/asciidoctor/un
cp biblio.rng ../../metanorma-unece/lib/asciidoctor/un
cp isodoc.rng ../../metanorma-unece/lib/asciidoctor/un
cat un.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/un" }) '>  ../../metanorma-unece/lib/asciidoctor/un/un.rng
cp basicdoc.rng ../../metanorma-ogc/lib/asciidoctor/ogc
cp reqt.rng ../../metanorma-ogc/lib/asciidoctor/ogc
cp biblio.rng ../../metanorma-ogc/lib/asciidoctor/ogc
cp isodoc.rng ../../metanorma-ogc/lib/asciidoctor/ogc
cat ogc.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/ogc" }) '>  ../../metanorma-ogc/lib/asciidoctor/ogc/ogc.rng
cp basicdoc.rng ../../metanorma-nist/lib/asciidoctor/nist
cp reqt.rng ../../metanorma-nist/lib/asciidoctor/nist
cp biblio.rng ../../metanorma-nist/lib/asciidoctor/nist
cp isodoc.rng ../../metanorma-nist/lib/asciidoctor/nist
cat nist.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/nist" }) '>  ../../metanorma-nist/lib/asciidoctor/nist/nist.rng
cp basicdoc.rng ../../metanorma-ietf/lib/asciidoctor/ietf
cp reqt.rng ../../metanorma-ietf/lib/asciidoctor/ietf
cp biblio.rng ../../metanorma-ietf/lib/asciidoctor/ietf
cp isodoc.rng ../../metanorma-ietf/lib/asciidoctor/ietf
cat ietf.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/ietf" }) '>  ../../metanorma-ietf/lib/asciidoctor/ietf/ietf.rng
cp basicdoc.rng ../../metanorma-itu/lib/asciidoctor/itu
cp reqt.rng ../../metanorma-itu/lib/asciidoctor/itu
cp biblio.rng ../../metanorma-itu/lib/asciidoctor/itu
cp isodoc.rng ../../metanorma-itu/lib/asciidoctor/itu
cat itu.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/itu" }) '>  ../../metanorma-itu/lib/asciidoctor/itu/itu.rng
cp basicdoc.rng ../../metanorma-vsd/lib/asciidoctor/vsd
cp reqt.rng ../../metanorma-vsd/lib/asciidoctor/vsd
cp biblio.rng ../../metanorma-vsd/lib/asciidoctor/vsd
cp isodoc.rng ../../metanorma-vsd/lib/asciidoctor/vsd
cat rsd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/vsd" }) '>  ../../metanorma-vsd/lib/asciidoctor/vsd/vsd.rng
cp basicdoc.rng ../../metanorma-iho/lib/asciidoctor/iho
cp reqt.rng ../../metanorma-iho/lib/asciidoctor/iho
cp biblio.rng ../../metanorma-iho/lib/asciidoctor/iho
cp isodoc.rng ../../metanorma-iho/lib/asciidoctor/iho
cat iho.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iho" }) '>  ../../metanorma-iho/lib/asciidoctor/iho/iho.rng
