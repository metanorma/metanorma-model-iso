cd bib-models/grammars
rm biblio.rng
git pull
sh make.sh
cd ../..
cp bib-models/grammars/biblio.rnc .
cp bib-models/grammars/biblio.rng .

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

java -jar jing-trang/build/trang.jar -I rnc -O rng isodoc.rnc isodoc.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng isostandard.rnc isostandard.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng csd.rnc csd.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng csand.rnc csand.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng gbstandard.rnc gbstandard.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng m3d.rnc m3d.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng rsd.rnc rsd.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng mpfd.rnc mpfd.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng unece.rnc unece.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng ogc.rnc ogc.rng
java -jar jing-trang/build/trang.jar -I rnc -O rng nist.rnc nist.rng
sh copy.sh
