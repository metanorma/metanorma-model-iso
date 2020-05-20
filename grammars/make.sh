rm -f relaton-models/grammars/biblio.rng
rm -f basicdoc-models/grammars/basicdoc.rng
git submodule update

cd relaton-models/grammars
git checkout master && git pull
cd ../..
cp relaton-models/grammars/biblio.rnc .

cd basicdoc-models/grammars
git checkout master && git pull
cd ../..
cp basicdoc-models/grammars/basicdoc.rnc .

cd metanorma-requirements-models/grammars
git checkout master && git pull
cd ../..
cp metanorma-requirements-models/grammars/reqt.rnc .

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

java -jar jing-trang/build/trang.jar -I rnc -O rng biblio.rnc biblio.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng basicdoc.rnc basicdoc.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng reqt.rnc reqt.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng isodoc.rnc isodoc.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng isostandard.rnc isostandard.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng isostandard-amd.rnc isostandard-amd.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng iec.rnc iec.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng csd.rnc csd.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng csa.rnc csa.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng gbstandard.rnc gbstandard.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng m3d.rnc m3d.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng rsd.rnc rsd.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng mpfd.rnc mpfd.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng un.rnc un.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng ogc.rnc ogc.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng nist.rnc nist.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng itu.rnc itu.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng ietf.rnc ietf.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng iho.rnc iho.rng
sh copy.sh
