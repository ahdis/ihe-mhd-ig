# validation for the IHE MHD profile

IHE publishes FHIR conformance resouces for the the technical framworks on their [ftp server](ftp://ftp.ihe.net/TF_Implementation_Material/fhir/).
This project wants to build a validator for the IHE Profile [Mobile Access to Health Documents (MHD)](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_MHD.pdf)

The [IG Publisher](http://wiki.hl7.org/index.php?title=IG_Publisher_Documentation) is used to process the resources in an implementation guide which can then be used by the validators. As a base for the implementation guide [IG-Template](https://github.com/Healthedata1) from Eric Haas has been used. The Implementation Guide is built with the [FHIR Implementation Guide Auto-Builder(https://github.com/hl7-fhir/auto-ig-builder). [Validation Results for IHE.MHD](http://build.fhir.org/ig/ahdis/ihe-mhd-ig/qa.htm)

you can now validate example files against the built ig:
```
java -jar ./validator/org.hl7.fhir.validator.jar ./examples/bundle/singledocsubmit.xml -defn ./validator/igpack.301.zip -ig http://build.fhir.org/ig/ahdis/ihe-mhd-ig
 .. load FHIR from ./validator/igpack.301.zip
  .. connect to tx server @ http://tx.fhir.org/r4
    (v3.0.1-11917)
+  .. load IG from http://build.fhir.org/ig/ahdis/ihe-mhd-ig
  .. validate
*FAILURE* validating ./examples/bundle/singledocsubmit.xml:  error:4 warn:4 info:28
  Error @ Bundle.entry[2].resource.author[1] (line 128, col25) : SHALL have a contained resource if a local reference is provided ( (url: a3; ids: )) [reference.startsWith('#').not() or (reference.substring(1).trace('url') in %resource.contained.id.trace('ids'))]
  ...
```
still working on the errors :-) should give the same results as on the [Validation Results for IHE.MHD](http://build.fhir.org/ig/ahdis/ihe-mhd-ig/qa.htm) if you use one of the examples in the implementation guide.

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

