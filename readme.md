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
still working on the errors :-) should give the same results as on the Validation Results for IHE.MHD](http://build.fhir.org/ig/ahdis/ihe-mhd-ig/qa.htm) if you use one of the examples in the implementation guide.

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

pubished on ftp://ftp.ihe.net/TF_Implementation_Material/fhir/ to be discussed with ihe

1. Typos search/replace Comprensive, Comprenensive -> Comprehensive

2. Canonical Url of CodeSystem ist not correct
	<url value="http://ihe.net/fhir/ValueSet/IHE.FormatCode.codesystem"/>
    --> 
	<url value="http://ihe.net/fhir/CodeSystem/IHE.formatcode.cs"/>

3. Replace in CapabilityStatements <url value="http://www.ihe.net.. />with <url value="http://ihe.net    

4. remove type of filenames to harmonize with id internally (IG Publisher needs that)
   can use script ./rm

5. in ImplementationGuide\IHE.MHD.xml (others need to be done to):

    switch from sourceUri to sourceReference

6.  IHE.MHD.DocumentSource, 
    IHE.MHD.DocumentConsumer,
    IHE.MHD.DocumentRecipient,
    IHE.MHD.DocumentResponder
     -> CapabiltyStatement instead of StructureDefinition

7. StructureDefinition/IHE.MHD.ProvideDocumentBundle.Minimal and StructureDefinition/IHE.MHD.ProvideDocumentBundle.Comprehensive: StructureDefinition.differential.element[2].fixedCode: StructureDefinition.differential.element[2].fixedCode	error	The code 'transaction ' is not valid (whitespace rules)

8. 
CapabilityStatement/IHE.MHD.DocumentRecipient: CapabilityStatement	error	There can only be one REST declaration per mode. [rest.select(mode).isDistinct()]
CapabilityStatement/IHE.MHD.DocumentRecipient: CapabilityStatement	error	Profile http://hl7.org/fhir/StructureDefinition/CapabilityStatement, Element 'CapabilityStatement.status': minimum required = 1, but only found 0
CapabilityStatement/IHE.MHD.DocumentRecipient: CapabilityStatement	error	Profile http://hl7.org/fhir/StructureDefinition/CapabilityStatement, Element 'CapabilityStatement.acceptUnknown': minimum required = 1, but only found 0
CapabilityStatement/IHE.MHD.DocumentRecipient: CapabilityStatement.jurisdiction	warning	None of the codes provided are in the value set http://hl7.org/fhir/ValueSet/jurisdiction (http://hl7.org/fhir/ValueSet/jurisdiction, and a code should come from this value set unless it has no suitable code) (codes = http://unstats.un.org/unsd/methods/m49/m49.htm#001)
CapabilityStatement/IHE.MHD.DocumentRecipient: CapabilityStatement.implementationGuide	error	URI values cannot have whitespace

9. replace value="STU3" in IHE.MHD.DocumentConsumer, Responder with "3.0.1"

10. CapabilityStatement/IHE.MHD.DocumentSource: CapabilityStatement	error	There can only be one REST declaration per mode. [rest.select(mode).isDistinct()]
CapabilityStatement/IHE.MHD.DocumentSource: CapabilityStatement	error	Profile http://hl7.org/fhir/StructureDefinition/CapabilityStatement, Element 'CapabilityStatement.status': minimum required = 1, but only found 0
CapabilityStatement/IHE.MHD.DocumentSource: CapabilityStatement	error	Profile http://hl7.org/fhir/StructureDefinition/CapabilityStatement, Element 'CapabilityStatement.acceptUnknown': minimum required = 1, but only found 0
CapabilityStatement/IHE.MHD.DocumentSource: CapabilityStatement.jurisdiction	warning	None of the codes provided are in the value set http://hl7.org/fhir/ValueSet/jurisdiction (http://hl7.org/fhir/ValueSet/jurisdiction, and a code should come from this value set unless it has no suitable code) (codes = http://unstats.un.org/unsd/methods/m49/m49.htm#001)
CapabilityStatement/IHE.MHD.DocumentSource: CapabilityStatement.implementationGuide	error	URI values cannot have whitespace

11. For all StructureDefintion in the differential you need a first Element wich describes the derived type

   e.g 
   <differential>
    <element id="DocumentManifest">
      <path value="DocumentManifest"/>
      <min value="0"/>
      <max value="*"/>
    </element>

12.  Error generatingsnapshot: Error sorting Differential: StructureDefinition http://ihe.net/fhir/StructureDefinition/IHE.MHD.ProvideDocumentBundle.Minimal: Differential contains path Bundle.meta.profile which is not found in the base, add in IHE.MHD.ProvideDocumentBundle.Minimal and IHE.MHD.ProvideDocumentBundle.Comprehensive

    <element id="Bundle.meta">
      <path value="Bundle.meta"/> 
      <short value="Metadata about the resource"/> 
      <definition value="The metadata about the resource. This is content that is maintained by the infrastructure.
       Changes to the content may not always be associated with version changes to the resource."/> 
      <min value="1"/> 
      <max value="1"/> 
      <base> 
        <path value="Resource.meta"/> 
        <min value="0"/> 
        <max value="1"/> 
      </base> 
      <type> 
        <code value="Meta"/> 
      </type> 
      <isSummary value="true"/> 
    </element> 
    <element id="Bundle.meta.profile">
      <path value="Bundle.meta.profile" />
      <short value="ITI-65" />
      <definition value="IHE MHD Provide Document Bundle transaction" />
      <min value="1" />
      <max value="1" />
      <fixedUri value="http://ihe.net/fhir/tag/iti-65" />
    </element>

    13. Slicing on discriminator type/resource instead of full resource

          <slicing>
        <discriminator>
          <type value="type" />
          <path value="resource" />
        </discriminator>
        <rules value="open" />
      </slicing>

      and      <code value="Resource" /> needs to be set to resource accordingly      <code value="DocumentManifest" />

## setup

1. Copy the authorative conformance resources to the resources directoy with ftp (or any other way) into
the resources directory.

```
cd scripts
./ftpihenet.sh
```
This script uses ftp client. OSX: If you have no ftp client availabe in the commandline du to High Sierra install it via [homebrew](https://apple.stackexchange.com/questions/299758/how-to-get-bsd-ftp-and-telnet-back-in-10-13-high-sierra)

```
brew install tnftp
```
