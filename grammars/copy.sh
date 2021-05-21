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
cp basicdoc.rng ../../metanorma-bsi/lib/asciidoctor/bsi
cp reqt.rng ../../metanorma-bsi/lib/asciidoctor/bsi
cp biblio.rng ../../metanorma-bsi/lib/asciidoctor/bsi
cp isodoc.rng ../../metanorma-bsi/lib/asciidoctor/bsi
cp isostandard.rng ../../metanorma-bsi/lib/asciidoctor/bsi/isostandard.rng
cat bsi.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/bsi" }) '>  ../../metanorma-bsi/lib/asciidoctor/bsi/bsi.rng
cp basicdoc.rng ../../metanorma-csd/lib/asciidoctor/cc
cp reqt.rng ../../metanorma-csd/lib/asciidoctor/cc
cp biblio.rng ../../metanorma-csd/lib/asciidoctor/cc
cp isodoc.rng ../../metanorma-csd/lib/asciidoctor/cc
cat csd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/csd" }) '>  ../../metanorma-csd/lib/asciidoctor/cc/cc.rng
cp basicdoc.rng ../../metanorma-csand/lib/asciidoctor/csa
cp reqt.rng ../../metanorma-csand/lib/asciidoctor/csa
cp biblio.rng ../../metanorma-csand/lib/asciidoctor/csa
cp isodoc.rng ../../metanorma-csand/lib/asciidoctor/csa
cat csa.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/csa" }) '>  ../../metanorma-csand/lib/asciidoctor/csa/csa.rng
cp basicdoc.rng ../../metanorma-m3d/lib/asciidoctor/m3aawg
cp reqt.rng ../../metanorma-m3d/lib/asciidoctor/m3aawg
cp biblio.rng ../../metanorma-m3d/lib/asciidoctor/m3aawg
cp isodoc.rng ../../metanorma-m3d/lib/asciidoctor/m3aawg
cat m3d.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/m3d" }) '>  ../../metanorma-m3d/lib/asciidoctor/m3aawg/m3d.rng
cp basicdoc.rng ../../metanorma-rsd/lib/asciidoctor/ribose
cp reqt.rng ../../metanorma-rsd/lib/asciidoctor/ribose
cp biblio.rng ../../metanorma-rsd/lib/asciidoctor/ribose
cp isodoc.rng ../../metanorma-rsd/lib/asciidoctor/ribose
cat rsd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/rsd" }) '>  ../../metanorma-rsd/lib/asciidoctor/ribose/rsd.rng
cp basicdoc.rng ../../metanorma-acme/lib/asciidoctor/generic
cp reqt.rng ../../metanorma-acme/lib/asciidoctor/generic
cp biblio.rng ../../metanorma-acme/lib/asciidoctor/generic
cp isodoc.rng ../../metanorma-acme/lib/asciidoctor/generic
cat rsd.rng | ruby -pe '$_.gsub!(/rsd-standard/, "generic-standard") ' | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/generic" }) ' > ../../metanorma-acme/lib/asciidoctor/generic/generic.rng
cp basicdoc.rng ../../metanorma-mpfd/lib/asciidoctor/mpfa
cp reqt.rng ../../metanorma-mpfd/lib/asciidoctor/mpfa
cp biblio.rng ../../metanorma-mpfd/lib/asciidoctor/mpfa
cp isodoc.rng ../../metanorma-mpfd/lib/asciidoctor/mpfa
cat mpfd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/mpfd" }) '>  ../../metanorma-mpfd/lib/asciidoctor/mpfa/mpfd.rng
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
cp basicdoc.rng ../../metanorma-iho/lib/asciidoctor/iho
cp reqt.rng ../../metanorma-iho/lib/asciidoctor/iho
cp biblio.rng ../../metanorma-iho/lib/asciidoctor/iho
cp isodoc.rng ../../metanorma-iho/lib/asciidoctor/iho
cat iho.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iho" }) '>  ../../metanorma-iho/lib/asciidoctor/iho/iho.rng
cp basicdoc.rng ../../metanorma-bipm/lib/asciidoctor/bipm
cp reqt.rng ../../metanorma-bipm/lib/asciidoctor/bipm
cp biblio.rng ../../metanorma-bipm/lib/asciidoctor/bipm
cp isodoc.rng ../../metanorma-bipm/lib/asciidoctor/bipm
cat bipm.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/bipm" }) '>  ../../metanorma-bipm/lib/asciidoctor/bipm/bipm.rng
