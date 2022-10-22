echo "Updating submodules..."

rm -f relaton-models/grammars/biblio.rng
rm -f basicdoc-models/grammars/basicdoc.rng
git submodule update

cd relaton-models/grammars
git checkout main && git pull
cd ../..
cp relaton-models/grammars/biblio.rnc .
cp relaton-models/grammars/biblio-standoc.rnc .

cd basicdoc-models/grammars
git checkout main && git pull
cd ../..
cp basicdoc-models/grammars/basicdoc.rnc .

cd metanorma-requirements-models/grammars
git checkout main && git pull
cd ../..
cp metanorma-requirements-models/grammars/reqt.rnc .

for i in ieee iso iec bsi gb mpfa bipm w3c 3gpp csa cc ietf iho itu m3aawg
do
  cd relaton-model-$i/grammars
  git checkout main && git pull
  cd ../..
  cp relaton-model-$i/grammars/relaton-$i.rnc .
done

gem list | grep rsec
if [[ $? -ne 0 ]]; then
  gem install rsec
fi
if [[ ! -d jing-trang ]]; then
  git clone https://github.com/relaxng/jing-trang.git
  cd jing-trang
  ./ant
  cd ..
fi

echo "Compiling..."

for i in biblio biblio-standoc basicdoc reqt relaton-ieee relaton-iso relaton-iec relaton-bsi relaton-gb relaton-mpfa relaton-bipm relaton-w3c relaton-3gpp relaton-csa relaton-cc relaton-ietf relaton-iho relaton-itu relaton-m3aawg isodoc isodoc-compile isostandard isostandard-compile isostandard-amd iec csd csa gbstandard m3d rsd ieee un ogc nist itu ietf iho bipm bsi
do
  echo $i
  java -jar jing-trang/build/trang.jar -I rnc -O rng $i.rnc $i.rng
done

sh copy.sh
