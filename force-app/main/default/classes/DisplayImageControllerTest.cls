@isTest
public class DisplayImageControllerTest {
    @isTest
    public static void getFileIdTest(){
        Candidate__c can = new Candidate__c(First_Name__c = 'Test');
        insert can;
		ApexPages.StandardController sc = new ApexPages.StandardController(can);
        DisplayImageController displayImageControler = new DisplayImageController(sc);
        CandidatesImagesController controller = new CandidatesImagesController(sc);
        PageReference pageRef = Page.UploadCandidatesImage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id', can.id);
        controller.file = Blob.valueOf('Test image uploaded');
        PageReference objectPageRef =  controller.upload();
        id documentid = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId =: can.id].ContentDocumentId;
        String candidatesImageId = [select id from ContentVersion where ContentDocumentId =: documentid And isLatest = True].id;
        String result = displayImageControler.getFileId();
        System.assertEquals(candidatesImageId, result);
    }
}