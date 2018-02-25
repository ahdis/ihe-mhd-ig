# ihe on fhir

IHE publishes FHIR conformance resouces for the the technical framworks on their [ftp server](ftp://ftp.ihe.net/TF_Implementation_Material/fhir/).

The following profiles of [IHE Technical Framework](https://www.ihe.net/Technical_Frameworks/) are included here, each gets its own implementation guide:
* [Mobile Access to Health Documents (MHD)](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_MHD.pdf)

This projects uses the [IG Publisher](http://wiki.hl7.org/index.php?title=IG_Publisher_Documentation) to process the resources in an implementation guide which can then be used by the validators.

As base for the implementation guide [IG-Template](https://github.com/Healthedata1) from Eric Haas has been used.

The process to create the IG is currently manual (work in progress):
* you need Java 
* get the ig publisher and validator from the current build of fhir with the defintions for version 3.0.1, use ./updatetools.sh
* create the ig with the following command from the command line

```
java -jar ./igpublisher/org.hl7.fhir.igpublisher.jar -ig ./ig/IHE.MHD/IHE.MHD.json 
```
The result will be available in ig/IHE.MHD/output/qa.html and errors, warnings during the process are in ig/IHE.MHD/output/qa.html.


## current changes to IHE Implementation material pubished on ftp://ftp.ihe.net/TF_Implementation_Material/fhir/ to be discussed with ihe

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
