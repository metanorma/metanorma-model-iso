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
ruby rnc.ebnf.rb isodoc.rnc isostandard_diff.rnc > isostandard.rnc
java -jar jing-trang/build/trang.jar -I rnc -O rng isostandard.rnc isostandard.rng
ruby rnc.ebnf.rb isostandard.rnc csd_diff.rnc > csd.rnc
java -jar jing-trang/build/trang.jar -I rnc -O rng csd.rnc csd.rng

