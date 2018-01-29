# ihe fhir technical framework implementation guide

IHE publishes FHIR conformance resouces for the the technical framworks on their [ftp server](ftp://ftp.ihe.net/TF_Implementation_Material/fhir/).

This projects uses the [IG Publisher](http://wiki.hl7.org/index.php?title=IG_Publisher_Documentation)to process the resources in an implementation guide which can then be used by the validators.

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

## oliver 
CapabilityStatements cannot be feed seperatly in validator?
Exception in thread "main" java.lang.Exception: Error parsing IHE.MHD.DocumentConsumer.capabilitystatement.xml: Unknown Content profile

Llyod in Zulip in another discussion: Your profile is referencing a whole lot of other profiles - none of which are defined in your implementation guide or inherited from a parent implementation guide

## john

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