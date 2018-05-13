cd ../resources
cd structuredefinition			
mv IHE.MHD.DocumentManifest.structuredefinition.xml	IHE.MHD.DocumentManifest.xml	
mv IHE.MHD.Query.Minimal.DocumentReference.structuredefinition.xml IHE.MHD.Query.Minimal.DocumentReference.xml
mv IHE.MHD.ITI-65.structuredefinition.xml IHE.MHD.ITI-65.xml						
mv IHE.MHD.List.structuredefinition.xml IHE.MHD.List.xml				
mv IHE.MHD.Provide.Comprehensive.DocumentReference.structuredefinition.xml IHE.MHD.Provide.Comprehensive.DocumentReference.xml		
mv IHE.MHD.Provide.Minimal.DocumentReference.structuredefinition.xml IHE.MHD.Provide.Minimal.DocumentReference.xml		
mv IHE.MHD.ProvideDocumentBundle.Comprehensive.structuredefinition.xml IHE.MHD.ProvideDocumentBundle.Comprehensive.xml		
mv IHE.MHD.ProvideDocumentBundle.Minimal.structuredefinition.xml IHE.MHD.ProvideDocumentBundle.Minimal.xml			
mv IHE.MHD.Query.Comprehensive.DocumentReference.structuredefinition.xml IHE.MHD.Query.Comprehensive.DocumentReference.xml
cd ..
cd capabilitystatement
mv IHE.MHD.DocumentConsumer.capabilitystatement.xml IHE.MHD.DocumentConsumer.xml
mv IHE.MHD.DocumentRecipient.capabilitystatement.xml IHE.MHD.DocumentRecipient.xml
mv IHE.MHD.DocumentResponder.capabilitystatement.xml IHE.MHD.DocumentResponder.xml
mv IHE.MHD.DocumentSource.capabilitystatement.xml IHE.MHD.DocumentSource.xml
cd ..
cd codesystem
rm IHE.NPFSm.*.xml
mv IHE.formatcode.codesystem.xml IHE.FormatCode.codesystem.xml
cd ..
cd valueset
mv IHE.formatcode.valueset.xml IHE.formatcode.vs.xml
rm IHE.NPFSm.*.xml
cd ..
cd implementationguide
mv IHE.MHD.implementationguide.xml IHE.MHD.xml			
cd ..
cd ..
cd scripts