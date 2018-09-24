@isTest
public class CandidateImageControllerTest {
    @isTest
    public static void getFileIdTest(){
        Candidate__c can = new Candidate__c(First_Name__c = 'Test');
        insert can;
		ApexPages.StandardController sc = new ApexPages.StandardController(can);
        CandidateImageControler candidateImageControler = new CandidateImageControler(sc);
        ImageUploadController controller = new ImageUploadController(sc);
        PageReference pageRef = Page.UploadCandidatesImage;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id', can.id);
        PageReference objectPageRef =  controller.upload();
        String documentId = [select id from Document where Name =: can.id limit 1].id;
        String result = candidateImageControler.getFileId();
    	System.assertEquals(documentId, result);
    }
}