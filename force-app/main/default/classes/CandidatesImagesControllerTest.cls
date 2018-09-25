@isTest
public class CandidatesImagesControllerTest {
    @isTest
    public static void uploadImageTest(){
        Candidate__c candidate = new Candidate__c(First_Name__c = 'Test');
        insert candidate;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', candidate.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(candidate);
    	CandidatesImagesController controller = new CandidatesImagesController(sc);
        controller.file = Blob.valueOf('Test image yuploiaded');
        pageRef = controller.upload();
        List<ContentVersion> testImage = [select id, Title, ContentDocumentId from ContentVersion];
        List<ContentDocumentLink> contentDocument = [select ContentDocumentId, LinkedEntityId from ContentDocumentLink where ContentDocumentId =: testImage[0].ContentDocumentId];
        System.assertEquals(1, testImage.size());
        boolean result = false;
        if (contentDocument.size() > 0) result = true;
        system.assert(result);
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        for(Apexpages.Message msg:msgs){
    	if (msg.getDetail().contains('Image uploaded successfully')) result = true;
		}
		system.assert(result);
    }
    @isTest
    public static void imageNotUploaded(){
        Candidate__c candidate2 = new Candidate__c(First_Name__c = 'Test');
        insert candidate2;
        PageReference pageReference = Page.UploadCandidatesImage;
        pageReference.getParameters().put('id', String.valueOf(candidate2.id));
        Test.setCurrentPage(pageReference);
        ApexPages.StandardController stcon = new ApexPages.StandardController(candidate2);
    	CandidatesImagesController controller = new CandidatesImagesController(stcon);
        pageReference = controller.upload();
        List<ContentVersion> testImage = [select id, Title, ContentDocumentId from ContentVersion];
        System.assertEquals(0, testImage.size());
        List<Apexpages.Message> msgs = ApexPages.getMessages();
		boolean result = false;
        for(Apexpages.Message msg:msgs){
    	if (msg.getDetail().contains('Error uploading image')) result = true;
		}
		system.assert(result);
    }
    @isTest
    public static void deleteImageTest(){
        Candidate__c candidate = new Candidate__c(First_Name__c = 'Test');
        insert candidate;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', candidate.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(candidate);
    	CandidatesImagesController controller = new CandidatesImagesController(sc);
        controller.file = Blob.valueOf('Test image yuploiaded');
        pageRef = controller.upload();
        pageRef = controller.deleteImage();
        List<ContentVersion> testImage = [select id from ContentVersion];
        System.assertEquals(0, testImage.size());
        List<Apexpages.Message> msgs = ApexPages.getMessages();
		boolean result = false;
        for(Apexpages.Message msg:msgs){
    	if (msg.getDetail().contains('Image deleted successfully')) result = true;
		}
		system.assert(result);
    }
   /* @isTest
    public static void notDeleteImageTest(){
        Candidate__c candidate = new Candidate__c(First_Name__c = 'Test');
        insert candidate;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', candidate.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(candidate);
    	CandidatesImagesController controller = new CandidatesImagesController(sc);
        controller.file = Blob.valueOf('Test image yuploiaded');
        pageRef = controller.upload();
        id testImageId = [select ContentDocumentId from ContentVersion].id;
        List<ContentDocument> testImage = [select id from ContentDocument where id =: testImageId];
        pageRef = controller.deleteImage();
        String result = 'entity is deleted';
        String resultMessage;
        resultMessage = controller.deleteCandidatePhoto(testImage);
        try{
            //resultMessage = controller.deleteCandidatePhoto(testImage);
        }
        catch(DMLException e){
            result = e.getDmlMessage(0);
        }
        //System.assertEquals(result, resultMessage);
    }*/
    @isTest
    public static void updateImageTest(){
        Candidate__c candidate = new Candidate__c(First_Name__c = 'Test');
        insert candidate;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', candidate.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(candidate);
    	CandidatesImagesController controller = new CandidatesImagesController(sc);
        controller.file = Blob.valueOf('Test image yuploiaded');
        pageRef = controller.upload();
        controller.file = Blob.valueOf('New value for test updating');
        pageRef = controller.updateImage();
        List<Apexpages.Message> msgs = ApexPages.getMessages();
		boolean b = false;
        for(Apexpages.Message msg:msgs){
    	if (msg.getDetail().contains('Image updating successfully')) b = true;
		}
		system.assert(b);
    }
     @isTest
    public static void notUpdateImageTest(){
        Candidate__c candidate = new Candidate__c(First_Name__c = 'Test');
        insert candidate;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', candidate.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(candidate);
    	CandidatesImagesController controller = new CandidatesImagesController(sc);
        controller.file = Blob.valueOf('Test image yuploiaded');
        pageRef = controller.upload();
        ContentVersion testImage = [select ContentDocumentId from ContentVersion];
        List<ContentDocument> imageDocument = [select id from ContentDocument where id =: testImage.Id];
        delete imageDocument;
        controller.file = Blob.valueOf('New value for test updating');
        Test.startTest();
        controller.updateCandidateImage(testImage, controller.file);
        Test.stopTest();
    }
    
}