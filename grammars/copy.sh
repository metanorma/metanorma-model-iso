echo "Copying..."

metanorma_version=`git tag --sort=committerdate | tail -1`

for i in standoc iso iec bsi jis plateau cc csa ribose generic ieee ogc nist ietf itu iho bipm
do
  cat isodoc.rng | ruby -pe "\$_.gsub!(/(<grammar[^>]+>)/, %{\\\\1\n<!-- VERSION ${metanorma_version} -->\n}) " > ../../metanorma-$i/lib/metanorma/$i/isodoc.rng
  cp basicdoc.rng reqt.rng biblio.rng biblio-standoc.rng ../../metanorma-$i/lib/metanorma/$i
done

for i in iso iec bsi jis cc csa ribose ieee ogc nist ietf itu iho bipm
do
  cp relaton-$i.rng ../../metanorma-$i/lib/metanorma/$i
done

cp relaton-jis.rng ../../metanorma-plateau/lib/metanorma/plateau
cp jis.rng ../../metanorma-plateau/lib/metanorma/plateau

for i in iso iec bsi jis plateau
do
cp isostandard.rng ../../metanorma-$i/lib/metanorma/$i
done

for i in iec bsi jis cc csa ribose ieee ogc nist ietf itu iho bipm generic plateau
do
cat $i.rng | ruby -pe "\$_.gsub!(/<grammar /, %{<grammar ns='https://www.metanorma.org/ns/standoc' }) ">  ../../metanorma-$i/lib/metanorma/$i/$i.rng
done

cat isodoc-compile.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/standoc" }) '> ../../metanorma-standoc/lib/metanorma/standoc/isodoc-compile.rng

cat isostandard-compile.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/standoc" }) '>  ../../metanorma-iso/lib/metanorma/iso/isostandard-compile.rng
cat isostandard-amd.rng | ruby -pe '$_.gsub!(/<grammar /, %{<grammar ns="https://www.metanorma.org/ns/standoc" }) '>  ../../metanorma-iso/lib/metanorma/iso/isostandard-amd.rng


