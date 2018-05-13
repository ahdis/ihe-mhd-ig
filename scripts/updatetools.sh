wget http://hl7.org/fhir/igpack.zip
mv igpack.zip ../validator/igpack.301.zip
wget http://build.fhir.org/org.hl7.fhir.igpublisher.jar
mv org.hl7.fhir.igpublisher.jar ../igpublisher/
wget http://build.fhir.org/validator.zip
unzip ./validator.zip
rm validator.zip
rm readme.txt
# cp /Users/oliveregger/fhir/trunk/build/publish/org.hl7.fhir.validator.jar ../validator
# cp /Users/oliveregger/fhir/trunk/build/publish/org.hl7.fhir.igpublisher.jar ../igpublisher/
