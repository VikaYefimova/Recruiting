public class DisplayImageController {
    String recId;
    
    public DisplayImageController(ApexPages.StandardController controller) {
        recId = controller.getId();
    }
    
    public String getFileId() {
        String fileId ;
        id documentid = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId =: recId].ContentDocumentId;
        ContentVersion candidatesImage = [select id from ContentVersion where ContentDocumentId =: documentid And isLatest = True];
        if( candidatesImage != null ) {
            fileId = candidatesImage.id;
        }
        return fileId;    
    }

}