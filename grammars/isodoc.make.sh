if [[ ! -d jing-trang ]]; then
  git clone https://github.com/relaxng/jing-trang.git
fi
cd jing-trang
./ant
cd ..
java -jar jing-trang/build/trang.jar -I rnc -O rng isodoc.rnc isodoc.rng


java -jar jing-trang/build/jing.jar -c isodoc-compile.rng a.xml
