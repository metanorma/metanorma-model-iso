echo "Copying..."

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-standoc/lib/metanorma/standoc
cat isodoc-compile.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/standoc" }) '> ../../metanorma-standoc/lib/metanorma/standoc/isodoc-compile.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-iso/lib/metanorma/iso
cp relaton-iso.rng ../../metanorma-iso/lib/metanorma/iso
cp isostandard.rng ../../metanorma-iso/lib/metanorma/iso
cat isostandard-compile.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iso" }) '>  ../../metanorma-iso/lib/metanorma/iso/isostandard-compile.rng
cat isostandard-amd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iso" }) '>  ../../metanorma-iso/lib/metanorma/iso/isostandard-amd.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-iec/lib/metanorma/iec
cp relaton-iec.rng ../../metanorma-iec/lib/metanorma/iec
cp isostandard.rng ../../metanorma-iec/lib/metanorma/iec/isostandard.rng
cat iec.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iec" }) '>  ../../metanorma-iec/lib/metanorma/iec/iec.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-bsi/lib/metanorma/bsi
cp relaton-bsi.rng ../../metanorma-bsi/lib/metanorma/bsi
cp isostandard.rng ../../metanorma-bsi/lib/metanorma/bsi/isostandard.rng
cat bsi.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/bsi" }) '>  ../../metanorma-bsi/lib/metanorma/bsi/bsi.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-csd/lib/metanorma/cc
cp relaton-cc.rng ../../metanorma-csd/lib/metanorma/cc
cat csd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/csd" }) '>  ../../metanorma-csd/lib/metanorma/cc/cc.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-csand/lib/metanorma/csa
cp relaton-csa.rng ../../metanorma-csand/lib/metanorma/csa
cat csa.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/csa" }) '>  ../../metanorma-csand/lib/metanorma/csa/csa.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-m3d/lib/metanorma/m3aawg
cp relaton-m3aawg.rng ../../metanorma-m3d/lib/metanorma/m3aawg
cat m3d.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/m3d" }) '>  ../../metanorma-m3d/lib/metanorma/m3aawg/m3d.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-rsd/lib/metanorma/ribose
cp relaton-ribose.rng ../../metanorma-rsd/lib/metanorma/ribose
cat rsd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/rsd" }) '>  ../../metanorma-rsd/lib/metanorma/ribose/rsd.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-acme/lib/metanorma/generic
cat isodoc-compile.rng | ruby -pe '$_.gsub!(/rsd-standard/, "generic-standard") ' | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/generic" }) ' > ../../metanorma-acme/lib/metanorma/generic/generic.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-ieee/lib/metanorma/ieee
cp relaton-ieee.rng ../../metanorma-ieee/lib/metanorma/ieee
cat ieee.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/ieee" }) '>  ../../metanorma-ieee/lib/metanorma/ieee/ieee.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-unece/lib/metanorma/un
cp relaton-un.rng ../../metanorma-unece/lib/metanorma/un
cat un.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/un" }) '>  ../../metanorma-unece/lib/metanorma/un/un.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-ogc/lib/metanorma/ogc
cp relaton-ogc.rng ../../metanorma-ogc/lib/metanorma/ogc
cat ogc.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/ogc" }) '>  ../../metanorma-ogc/lib/metanorma/ogc/ogc.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-nist/lib/metanorma/nist
cp relaton-nist.rng ../../metanorma-nist/lib/metanorma/nist
cat nist.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/nist" }) '>  ../../metanorma-nist/lib/metanorma/nist/nist.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-ietf/lib/metanorma/ietf
cp relaton-ietf.rng ../../metanorma-ietf/lib/metanorma/ietf
cat ietf.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/ietf" }) '>  ../../metanorma-ietf/lib/metanorma/ietf/ietf.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-itu/lib/metanorma/itu
cp relaton-itu.rng ../../metanorma-itu/lib/metanorma/itu
cat itu.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/itu" }) '>  ../../metanorma-itu/lib/metanorma/itu/itu.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-iho/lib/metanorma/iho
cp relaton-iho.rng ../../metanorma-iho/lib/metanorma/iho
cat iho.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/iho" }) '>  ../../metanorma-iho/lib/metanorma/iho/iho.rng

cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng isodoc.rng ../../metanorma-bipm/lib/metanorma/bipm
cp relaton-bipm.rng ../../metanorma-bipm/lib/metanorma/bipm
cat bipm.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/bipm" }) '>  ../../metanorma-bipm/lib/metanorma/bipm/bipm.rng
