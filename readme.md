# validation for the IHE MHD profile

IHE publishes FHIR conformance resouces for the the technical framworks on their [ftp server](ftp://ftp.ihe.net/TF_Implementation_Material/fhir/).
This project wants to build a validator for the IHE Profile [Mobile Access to Health Documents (MHD)](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_MHD.pdf)

The [IG Publisher](http://wiki.hl7.org/index.php?title=IG_Publisher_Documentation) is used to process the resources in an implementation guide which can then be used by the validators. As a base for the implementation guide [IG-Template](https://github.com/Healthedata1) from Eric Haas has been used. The Implementation Guide is built with the [FHIR Implementation Guide Auto-Builder(https://github.com/hl7-fhir/auto-ig-builder). [Validation Results for IHE.MHD](http://build.fhir.org/ig/ahdis/ihe-mhd-ig/qa.htm)

you can now validate example files against the built ig:
```
java -jar ./validator/org.hl7.fhir.validator.jar ./examples/bundle/iti-65-request-xdstools-adapted.xml -defn ./validator/igpack.301.zip -ig http://build.fhir.org/ig/ahdis/ihe-mhd-ig
  .. load FHIR from ./validator/igpack.301.zip
  .. connect to tx server @ http://tx.fhir.org/r4
-tx: Connect to http://tx.fhir.org/r4
    (v3.0.1-11917)
+  .. load IG from http://build.fhir.org/ig/ahdis/ihe-mhd-ig
  .. validate
-tx: Terminology server: Check for supported code systems for http://loinc.org
-tx: Terminology Server: $expand on Include 6401 codes from http://loinc.org
-tx: Terminology Server: $validate-code system=urn:oid:1.3.6.1.4.1.21367.2017.3, code=34133-9, display=Summary of Episode Note, valueset=Include 6401 codes from http://loinc.org
-tx: Terminology Server: $expand on Include 55 codes from urn:ietf:bcp:47
-tx: Terminology Server: $validate-code system=urn:oid:1.3.6.1.4.1.21367.2017.3, code=urn:ihe:iti:appc:2016:consent, display=null, valueset=Include All codes from urn:oid:1.3.6.1.4.1.19376.1.2.3
-tx: Terminology Server: $validate-code system=urn:oid:1.3.6.1.4.1.21367.2017.3, code=34746-8, display=Nursing Evaluation and Management Note, valueset=Include 6401 codes from http://loinc.org
Success...validating ./examples/bundle/iti-65-request-xdstools-adapted.xml:  error:0 warn:2 info:27
  Information @ Bundle.entry[1].resource[1].text[1] (line 13, col15) : Instance includes element that is not marked as 'mustSupport' and was validated against profiles declaring mustSupport=true
  Information @ Bundle.entry[1].resource[1].contained[1] (line 21, col20) : Instance includes element that is not marked as 'mustSupport' and was validated against profiles declaring mustSupport=true
  Information @ Bundle.entry[1].resource[1].contained[2] (line 36, col20) : Instance includes element that is not marked as 'mustSupport' and was validated against profiles declaring mustSupport=true

```

Please note, above includes the patch for the validator which is not yet in the offical build [gforge](https://gforge.hl7.org/gf/project/fhir/tracker/?action=TrackerItemEdit&tracker_item_id=15757&start=0)

should give the same results as on the [Validation Results for IHE.MHD](http://build.fhir.org/ig/ahdis/ihe-mhd-ig/qa.htm) if you use one of the examples in the implementation guide.

# using the validator locally

using the validator directly without the ig itself (please by aware that the validator can fail silenty when the StructureDefinitions are in itself not valid):

```
java -jar ./validator/org.hl7.fhir.validator.jar ./examples/bundle/singledocsubmit.xml -defn ./validator/igpack.301.zip -ig ./resources/valueset/ -ig ./resources/codesystem/ -ig ./resources/structuredefinition/
```

instead of referencing the ig from the build you can also build the ig by yourself:

```
java -jar ./igpublisher/org.hl7.fhir.igpublisher.jar -web -ig ./ig.json
```
and then use the validator the following way:

```
java -jar ./validator/org.hl7.fhir.validator.jar ./examples/bundle/singledocsubmit.xml -defn ./validator/igpack.301.zip -ig ./output/definitions.xml.zip 
```

## current changes to IHE Implementation material 

In order to work with the IGPublisher setup a few 

pubished on ftp://ftp.ihe.net/TF_Implementation_Material/fhir/ to be discussed with ihe


1. IHE.MHD.xml

In the Implementation Guide Resource IHE uses sourceUri:

```xml
		<resource>
			<example value="false" />
			<name value="DocumentReference profile Provide Minimal Metadata" />
			<description value="Constraints on DocumentReference resource in a Provide with Minimal Metadata" />
			<sourceUri value="http://ihe.net/fhir/StructureDefinition/IHE.MHD.Provide.Minimal.DocumentReference" />
		</resource>
````

IGPublisher needs:

```xml
   <resource>
      <example value="false" />
      <name value="DocumentReference profile Provide Comprehensive Metadata (XDS on FHIR)" />
      <description value="Constraints on DocumentReference resource in a Provide with Comprehensive Metadata" />
      <sourceReference>
        <reference value="StructureDefinition/IHE.MHD.Provide.Comprehensive.DocumentReference" />
      </sourceReference>
    </resource>
```

2. IHE.MHD.DocumentManifest.xml

IGPublisher needs as a first differential Element the resource name by itself, otherwise the display is broken:

```xml
		<element id="DocumentManifest">
			<path value="DocumentManifest"/>
			<min value="0"/>
			<max value="*"/>
		</element>
```

element id for pRefernce needs to be changed to

```xml
		<element id="DocumentManifest.content.p[x]:pReference">
```

from 
```xml
		<element id="DocumentManifest.content.pReference:pReference">
```
pAttachment needs to be corrected (TODO):

```xml
		<!-- FIXME		
		<element id="DocumentManifest.content.pAttachment"><path value="DocumentManifest.content.pAttachment" /><comment value="These HL7 FHIR STU3 elements are not used in XDS, therefore would not be present. Document Consumers should be robust to these elements holding values." /><max value="0" /></element>
-->
```

3. First differential Resource Element also fo IHE.Mhd.List, IHE.MHD.Provide.Comprehensive.DocumentReference, IHE.MHD.Provide.Minimal.DocumentReference, IHE.MHD.ProvideDocumentBundle.Comprehensive, IHE.MHD.ProvideDocumentBundle.Minimal, IHE.MHD.Query.Comprehensive.DocumentReference, IHE.MHD.Query.Minimal.DocumentReference

4. IHE.MHD.ProvideDocumentBundle.Comprehensive, IHE.MHD.ProvideDocumentBundle.Minimal

Use code DocumentReference instead of Resource (also for List, Binary)
```xml
		<element id="Bundle.entry:DocumentReference.resource">
			<path value="Bundle.entry.resource" />
			<min value="1" />
			<type>
<!-- HEAD -->
				<code value="DocumentReference" />
=======
				<code value="Resource" />
<!-- IHE_TF_Impl_Material_MHD -->
				<profile value="http://ihe.net/fhir/StructureDefinition/IHE.MHD.Provide.Comprehensive.DocumentReference" />
			</type>
```xml

5. CapabilityStatement/IHE.MHD.DocumentConsumer: CapabilityStatement.profile[2]	error	Unable to resolve resource 'http://ihe.net/fhir/StructureDefinition/IHE.MHD.Query.Comprensive.DocumentReference'

needs to be fixed to
```xml
		<reference value="http://ihe.net/fhir/StructureDefinition/IHE.MHD.Query.Comprehensive.DocumentReference" />
```

6. Adjust IHE.MHD.xml to IHE.FormatCode.codesystem, rename file to IHE.FormatCode.codesystem.xml

    <resource>
      <example value="false" />
      <name value="IHE FormatCode CodeSystem" />
      <description value="IHE FormatCode CodeSystem" />
      <sourceReference>
        <reference value="CodeSystem/IHE.FormatCode.codesystem" />
      </sourceReference>
    </resource>