wget http://hl7.org/fhir/igpack.zip
mv igpack.zip ../validator/igpack.301.zip
# TODO maybe change to build tool
cp /Users/oliveregger/fhir/trunk/build/publish/org.hl7.fhir.validator.jar ../validator/
cp /Users/oliveregger/fhir/trunk/build/publish/org.hl7.fhir.igpublisher.jar ../igpublisher/
