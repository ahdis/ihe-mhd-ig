# validation for the IHE MHD profile

IHE publishes FHIR conformance resouces for the the technical framworks on their [ftp server](ftp://ftp.ihe.net/TF_Implementation_Material/fhir/).
This project wants to build a validator for the IHE Profile [Mobile Access to Health Documents (MHD)](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Suppl_MHD.pdf)

This branch is just a copy of the ftp site to enable to propagate the changes to the masters, because the
StructureDefinitions have to be adapted for the publishing tool.

Copy the authorative conformance resources to the resources directoy with ftp (or any other way) into
the resources directory.

Last update: May 13th, 2018 (HL7 WGM Cologne)

```
cd scripts
./ftpihenet.sh
```
This script uses ftp client. OSX: If you have no ftp client availabe in the commandline du to High Sierra install it via [homebrew](https://apple.stackexchange.com/questions/299758/how-to-get-bsd-ftp-and-telnet-back-in-10-13-high-sierra)

```
brew install tnftp
```
