cp basicdoc.rng ../../metanorma-standoc/lib/metanorma/standoc
cp reqt.rng ../../metanorma-standoc/lib/metanorma/standoc
cp biblio.rng ../../metanorma-standoc/lib/metanorma/standoc
cat isodoc.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/standoc" }) '> ../../metanorma-standoc/lib/metanorma/standoc/isodoc.rng
cp basicdoc.rng ../../metanorma-iso/lib/metanorma/iso
cp reqt.rng ../../metanorma-iso/lib/metanorma/iso
cp biblio.rng ../../metanorma-iso/lib/metanorma/iso
cp isodoc.rng ../../metanorma-iso/lib/metanorma/iso
cat isostandard.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iso" }) '>  ../../metanorma-iso/lib/metanorma/iso/isostandard.rng
cat isostandard-amd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iso" }) '>  ../../metanorma-iso/lib/metanorma/iso/isostandard-amd.rng
cp basicdoc.rng ../../metanorma-iec/lib/metanorma/iec
cp reqt.rng ../../metanorma-iec/lib/metanorma/iec
cp biblio.rng ../../metanorma-iec/lib/metanorma/iec
cp isodoc.rng ../../metanorma-iec/lib/metanorma/iec
cp isostandard.rng ../../metanorma-iec/lib/metanorma/iec/isostandard.rng
cat iec.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iec" }) '>  ../../metanorma-iec/lib/metanorma/iec/iec.rng
cp basicdoc.rng ../../metanorma-bsi/lib/metanorma/bsi
cp reqt.rng ../../metanorma-bsi/lib/metanorma/bsi
cp biblio.rng ../../metanorma-bsi/lib/metanorma/bsi
cp isodoc.rng ../../metanorma-bsi/lib/metanorma/bsi
cp isostandard.rng ../../metanorma-bsi/lib/metanorma/bsi/isostandard.rng
cat bsi.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/bsi" }) '>  ../../metanorma-bsi/lib/metanorma/bsi/bsi.rng
cp basicdoc.rng ../../metanorma-csd/lib/metanorma/cc
cp reqt.rng ../../metanorma-csd/lib/metanorma/cc
cp biblio.rng ../../metanorma-csd/lib/metanorma/cc
cp isodoc.rng ../../metanorma-csd/lib/metanorma/cc
cat csd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/csd" }) '>  ../../metanorma-csd/lib/metanorma/cc/cc.rng
cp basicdoc.rng ../../metanorma-csand/lib/metanorma/csa
cp reqt.rng ../../metanorma-csand/lib/metanorma/csa
cp biblio.rng ../../metanorma-csand/lib/metanorma/csa
cp isodoc.rng ../../metanorma-csand/lib/metanorma/csa
cat csa.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/csa" }) '>  ../../metanorma-csand/lib/metanorma/csa/csa.rng
cp basicdoc.rng ../../metanorma-m3d/lib/metanorma/m3aawg
cp reqt.rng ../../metanorma-m3d/lib/metanorma/m3aawg
cp biblio.rng ../../metanorma-m3d/lib/metanorma/m3aawg
cp isodoc.rng ../../metanorma-m3d/lib/metanorma/m3aawg
cat m3d.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/m3d" }) '>  ../../metanorma-m3d/lib/metanorma/m3aawg/m3d.rng
cp basicdoc.rng ../../metanorma-rsd/lib/metanorma/ribose
cp reqt.rng ../../metanorma-rsd/lib/metanorma/ribose
cp biblio.rng ../../metanorma-rsd/lib/metanorma/ribose
cp isodoc.rng ../../metanorma-rsd/lib/metanorma/ribose
cat rsd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/rsd" }) '>  ../../metanorma-rsd/lib/metanorma/ribose/rsd.rng
cp basicdoc.rng ../../metanorma-acme/lib/metanorma/generic
cp reqt.rng ../../metanorma-acme/lib/metanorma/generic
cp biblio.rng ../../metanorma-acme/lib/metanorma/generic
cp isodoc.rng ../../metanorma-acme/lib/metanorma/generic
cat rsd.rng | ruby -pe '$_.gsub!(/rsd-standard/, "generic-standard") ' | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/generic" }) ' > ../../metanorma-acme/lib/metanorma/generic/generic.rng
cp basicdoc.rng ../../metanorma-ieee/lib/metanorma/ieee
cp reqt.rng ../../metanorma-ieee/lib/metanorma/ieee
cp biblio.rng ../../metanorma-ieee/lib/metanorma/ieee
cp isodoc.rng ../../metanorma-ieee/lib/metanorma/ieee
cat ieee.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/ieee" }) '>  ../../metanorma-ieee/lib/metanorma/ieee/ieee.rng
cp basicdoc.rng ../../metanorma-unece/lib/metanorma/un
cp reqt.rng ../../metanorma-unece/lib/metanorma/un
cp biblio.rng ../../metanorma-unece/lib/metanorma/un
cp isodoc.rng ../../metanorma-unece/lib/metanorma/un
cat un.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/un" }) '>  ../../metanorma-unece/lib/metanorma/un/un.rng
cp basicdoc.rng ../../metanorma-ogc/lib/metanorma/ogc
cp reqt.rng ../../metanorma-ogc/lib/metanorma/ogc
cp biblio.rng ../../metanorma-ogc/lib/metanorma/ogc
cp isodoc.rng ../../metanorma-ogc/lib/metanorma/ogc
cat ogc.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/ogc" }) '>  ../../metanorma-ogc/lib/metanorma/ogc/ogc.rng
cp basicdoc.rng ../../metanorma-nist/lib/metanorma/nist
cp reqt.rng ../../metanorma-nist/lib/metanorma/nist
cp biblio.rng ../../metanorma-nist/lib/metanorma/nist
cp isodoc.rng ../../metanorma-nist/lib/metanorma/nist
cat nist.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/nist" }) '>  ../../metanorma-nist/lib/metanorma/nist/nist.rng
cp basicdoc.rng ../../metanorma-ietf/lib/metanorma/ietf
cp reqt.rng ../../metanorma-ietf/lib/metanorma/ietf
cp biblio.rng ../../metanorma-ietf/lib/metanorma/ietf
cp isodoc.rng ../../metanorma-ietf/lib/metanorma/ietf
cat ietf.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/ietf" }) '>  ../../metanorma-ietf/lib/metanorma/ietf/ietf.rng
cp basicdoc.rng ../../metanorma-itu/lib/metanorma/itu
cp reqt.rng ../../metanorma-itu/lib/metanorma/itu
cp biblio.rng ../../metanorma-itu/lib/metanorma/itu
cp isodoc.rng ../../metanorma-itu/lib/metanorma/itu
cat itu.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/itu" }) '>  ../../metanorma-itu/lib/metanorma/itu/itu.rng
cp basicdoc.rng ../../metanorma-iho/lib/metanorma/iho
cp reqt.rng ../../metanorma-iho/lib/metanorma/iho
cp biblio.rng ../../metanorma-iho/lib/metanorma/iho
cp isodoc.rng ../../metanorma-iho/lib/metanorma/iho
cat iho.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iho" }) '>  ../../metanorma-iho/lib/metanorma/iho/iho.rng
cp basicdoc.rng ../../metanorma-bipm/lib/metanorma/bipm
cp reqt.rng ../../metanorma-bipm/lib/metanorma/bipm
cp biblio.rng ../../metanorma-bipm/lib/metanorma/bipm
cp isodoc.rng ../../metanorma-bipm/lib/metanorma/bipm
cat bipm.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/bipm" }) '>  ../../metanorma-bipm/lib/metanorma/bipm/bipm.rng
