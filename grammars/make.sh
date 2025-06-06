# update tags...
git pull

echo "Updating submodules..."

rm -f relaton-models/grammars/biblio.rng
rm -f basicdoc-models/grammars/basicdoc.rng
git submodule update --remote

echo "{" > versions.json

cd relaton-models/grammars
git checkout main && git pull
var=`git tag --sort=committerdate | tail -1`
echo "\"relaton-models\": \"$var\"," >> ../../versions.json
cd ../..
cp relaton-models/grammars/biblio.rnc .
cp relaton-models/grammars/biblio-standoc.rnc .
cp relaton-models/grammars/biblio-compile.rnc .

cd basicdoc-models/grammars
git checkout main && git pull
var=`git tag --sort=committerdate | tail -1`
echo "\"basicdoc-models\": \"$var\"," >> ../../versions.json
cd ../..
cp basicdoc-models/grammars/basicdoc.rnc .

cd metanorma-requirements-models/grammars
git checkout main && git pull
var=`git tag --sort=committerdate | tail -1`
echo "\"metanorma-requirements-models\": \"$var\"," >> ../../versions.json
cd ../..
cp metanorma-requirements-models/grammars/reqt.rnc .

for i in ieee iso iec bsi gb mpfa bipm w3c 3gpp csa cc ietf iho itu m3aawg nist ribose ogc un cen ecma cie iana omg oasis jis etsi plateau ccsds
do
  cd relaton-model-$i/grammars
  git checkout main && git pull
  var=`git tag --sort=committerdate | tail -1`
  echo "\"relaton-model-$i\": \"$var\"," >> ../../versions.json
  cd ../..
  cp relaton-model-$i/grammars/relaton-$i.rnc .
done

var=`git tag --sort=committerdate | tail -1`
echo "\"metanorma-model\": \"$var\"," >> versions.json

date=`TZ=GMT date +"%Y-%m-%dT%H:%M:%SZ"`
echo "\"date\": \"$date\"" >> versions.json
echo "}" >> versions.json

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

for i in biblio biblio-compile biblio-standoc basicdoc reqt relaton-ieee relaton-iso relaton-iec relaton-bsi relaton-gb relaton-mpfa relaton-bipm relaton-w3c relaton-3gpp relaton-csa relaton-cc relaton-ietf relaton-iho relaton-itu relaton-m3aawg relaton-nist relaton-ribose relaton-ogc relaton-un relaton-cen relaton-ecma relaton-etsi relaton-plateau relaton-cie relaton-iana relaton-omg relaton-oasis relaton-jis relaton-ccsds isodoc isodoc-presentation biblio-presentation isodoc-collection isodoc-compile isodoc-presentation-compile isostandard isostandard-compile isostandard-amd iec cc csa gbstandard ribose ieee ogc nist itu ietf generic iho bipm bsi jis plateau relaton-ieee-compile relaton-iso-compile relaton-iec-compile relaton-bsi-compile relaton-gb-compile relaton-mpfa-compile relaton-bipm-compile relaton-w3c-compile relaton-3gpp-compile relaton-csa-compile relaton-cc-compile relaton-ietf-compile relaton-iho-compile relaton-itu-compile relaton-m3aawg-compile relaton-nist-compile relaton-ribose-compile relaton-ogc-compile relaton-un-compile relaton-cen-compile relaton-ecma-compile relaton-etsi-compile relaton-cie-compile relaton-iana-compile relaton-omg-compile relaton-oasis-compile relaton-jis-compile relaton-plateau-compile relaton-ccsds-compile
do
  echo $i
  java -jar jing-trang/build/trang.jar -I rnc -O rng $i.rnc $i.rng
done

bundle install
bundle exec ruby test.rb

if [ -e ../../metanorma-standoc/lib/metanorma/standoc ]
then
  sh copy.sh
fi
