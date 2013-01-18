flucard
=======
How to deploy a new flucard:

mount it
cd /Volumes/NO\ NAME/
unzip ~/Downloads/deploy_20120420.zip
mkdir deploy
cd deploy
mv ../deploy_20120420/DCIM/122_TREK/* .
mv ../deploy_20120420/README.txt .
mv ../deploy_20120420/autorun.sh .
rmdir -p ../deploy_20120420
cp ~/git/flucard/upload.rb .
cp ~/git/flucard/w2 .
unzip ~/Downloads/remvee_exifr_01022013.zip
mv exifr-master/lib/* usr/lib/ruby/1.9.1/
mv exifr-master/exifr.gemspec usr/lib/ruby/gems/1.9.1/specifications/
cd ..
cp ~/git/flucard/autorun.sh .
cd
<<UNmount it>>



