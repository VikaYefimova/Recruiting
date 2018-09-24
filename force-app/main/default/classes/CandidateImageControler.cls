public class CandidateImageControler {
	String recId;
    
    
    public CandidateImageControler(ApexPages.StandardController controller) {
        recId = controller.getId();
    }
    
    public String getFileId() {
        String fileId ;
        String search = '%'+recId+'%';
        Document candidatesImage = [select id from Document where Name Like :search and FolderId = '00l3E000000NxlQ' ];
        if( candidatesImage != null ) {
            fileId = candidatesImage.id;
        }
        System.debug('fileID:' + fileId);
        return fileId;    
    }
}