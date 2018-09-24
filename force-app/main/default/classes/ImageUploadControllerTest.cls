@isTest
public class ImageUploadControllerTest {
    @isTest
    public static void ImageUploadControllerConstructorTest(){
        Candidate__c can = new Candidate__c(First_Name__c = 'Test');
        insert can;
		ApexPages.StandardController sc = new ApexPages.StandardController(can);
        Blob imageBody = Blob.valueOf('Test image body');
        ImageUploadController controller = new ImageUploadController(sc);
    }
    @isTest
    public static void notUploadImageTest(){
        Candidate__c can = new Candidate__c(First_Name__c = 'Test');
        ApexPages.StandardController sc = new ApexPages.StandardController(can);
        Blob imageBody = Blob.valueOf('Test image body');
        ImageUploadController controller = new ImageUploadController(sc);
		Test.startTest();
        controller.uploadCandidateImage(can.Id, imageBody);
        Test.stopTest();
        List<Document> testImages = [select Name, Body from Document];
        System.assertEquals(0, testImages.size());
    }
    @isTest
    public static void uploadTest(){
        Candidate__c can = new Candidate__c(First_Name__c = 'Test');
        insert can;
        PageReference pageRef = Page.UploadCandidatesImage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id', can.id);
        ApexPages.StandardController sc = new ApexPages.StandardController(can);
    	ImageUploadController controller = new ImageUploadController(sc);
        PageReference objectPageRef =  controller.upload();
        Document testImage = [select Name, Body from Document];
        System.assertEquals(String.valueOf(can.Id), testImage.Name);
        List<Apexpages.Message> msgs = ApexPages.getMessages();
		boolean b = false;
        for(Apexpages.Message msg:msgs){
    	if (msg.getDetail().contains('Image uploaded successfully')) b = true;
		}
		system.assert(b);
    }
    @isTest
    public static void updateImageTest(){
        Candidate__c can = new Candidate__c(First_Name__c = 'Test');
        insert can;
        PageReference pageRef = Page.UploadCandidatesImage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id', can.id);
        ApexPages.StandardController sc = new ApexPages.StandardController(can);
    	ImageUploadController controller = new ImageUploadController(sc);
        PageReference objectPageRef =  controller.upload();
        PageReference newObjectPageRef =  controller.updateImage();
        Document testImage = [select Name, Body from Document];
        System.assertEquals(String.valueOf(can.Id), testImage.Name);
        List<Apexpages.Message> msgs = ApexPages.getMessages();
		boolean b = false;
        for(Apexpages.Message msg:msgs){
    	if (msg.getDetail().contains('Image updating successfully')) b = true;
		}
		system.assert(b);
    }
    @isTest
    public static void deleteImageTest(){
        Candidate__c can = new Candidate__c(First_Name__c = 'Test');
        insert can;
        PageReference pageRef = Page.UploadCandidatesImage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id', can.id);
        ApexPages.StandardController sc = new ApexPages.StandardController(can);
    	ImageUploadController controller = new ImageUploadController(sc);
        PageReference objectPageRef =  controller.upload();
        objectPageRef = controller.deleteImage();
        List<Document> candidateImages = [select id from Document where Name = : can.id];
        System.assertEquals(0, candidateImages.size());
    } 
    @isTest
    public static void notDeleteImageTest(){
        Candidate__c can = new Candidate__c(First_Name__c = 'Test');
        insert can;
        String recId = can.id;
        ApexPages.StandardController sc = new ApexPages.StandardController(can);
        Blob imageBody = Blob.valueOf('Test image body');        
        ImageUploadController controller = new ImageUploadController(sc);
        controller.uploadCandidateImage(recId, imageBody);
		List<Document> testImages = [select Name, Body from Document LIMIT 1];
        controller.deleteCandidateImage(testImages);
        String result = 'entity is deleted';
        String message;
        try{
            message = controller.deleteCandidateImage(testImages);
        }
        catch(DMLException e){
            result = e.getDmlMessage(0);
        }
        System.assertEquals(result, message);
    }
    @isTest
    public static void testThatCandidateRecordHasImage(){
        Candidate__c can = new Candidate__c(First_Name__c = 'Test');
        insert can;
        String recId = can.id;
        ApexPages.StandardController sc = new ApexPages.StandardController(can);
        Blob imageBody = Blob.valueOf('Test image body');        
        ImageUploadController controller = new ImageUploadController(sc);
        controller.uploadCandidateImage(recId, imageBody);
        boolean result = controller.hasImage(can.id);
        System.assertEquals(true, result);
    }
    @isTest
    public static void notUpdateImageTest(){
        Candidate__c can = new Candidate__c(First_Name__c = 'Test');
        insert can;
		String recId = can.id;
        ApexPages.StandardController sc = new ApexPages.StandardController(can);
        Blob imageBody = Blob.valueOf('New test image body');
        ImageUploadController controller = new ImageUploadController(sc);
        controller.uploadCandidateImage(recId, imageBody);
        Blob newimageBody;
        Document doc = [Select Name from Document where Name =: can.id];
        delete doc;
		Test.startTest();
        controller.updateImage(doc, recId, newimageBody);
        Test.stopTest();
        System.assertNotEquals(imageBody, doc.Body);
    }
}