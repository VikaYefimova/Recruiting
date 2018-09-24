public class CandidatesImagesController {
    public Id recordId;
    public Blob file{get;set;}
    public boolean hasImage{get; set;}
    public boolean isDelete{get; set;}
    
    public CandidatesImagesController(ApexPages.StandardController controller) {
        recordId = controller.getId();
        if(!hasImage(recordId)){
            hasImage  = false;
        }
        else{
            hasImage = true;
        }
    }
    
    public PageReference upload() {
        uploadCandidatesImage(file, recordId);
        return null;
    }
    public PageReference deleteImage(){
        deleteCandidatePhoto(recordId);
        return null;
    }
    public PageReference updateImage(){
        updateCandidateImage(recordId, file);
        return null;
    }
    public ContentVersion uploadCandidatesImage(Blob file, id candidateId){
        ContentVersion image = new ContentVersion();
        image.VersionData = file;
        String recId = candidateId;
        image.title = recId;
        image.PathOnClient = '/image.jpg';
        image.IsMajorVersion = false;
        try{
            insert image;
            hasImage = true;
            isDelete = false;
            ContentDocumentLink relatedFile = new ContentDocumentLink();
            Id contentid = [select ContentDocumentId from ContentVersion where Title =: recId].ContentDocumentId;
            relatedFile.ContentDocumentId = contentid;
            System.debug('contentID: ' + contentid);
            relatedFile.LinkedEntityId = recordId;
            relatedFile.ShareType = 'I';
            insert relatedFile;
        }
        catch(DMLException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error uploading image'));
        }
        return image;
    }
    public String deleteCandidatePhoto(id recId){
        String message;
        id documentid = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId =: recId].ContentDocumentId;
        ContentDocument candidatesImage = [select id from ContentDocument where Id =: documentid];
        try{
            delete candidatesImage;
            isDelete = true;
            hasImage = false;
            message = 'Image deleted successfully';
        	ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, message));
        }
        catch(DMLException e){
           hasImage = true;
           isDelete = false;
           message = e.getDmlMessage(0);
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, message));
        }
        return message;
    }
    public ContentVersion updateCandidateImage(id recId, Blob file){
        id documentid = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId =: recId].ContentDocumentId;
        ContentVersion candidatesImage = [select id from ContentVersion where ContentDocumentId =: documentid And isLatest = True];
        candidatesImage.VersionData = file;
        try{
            update candidatesImage;
            hasImage = true;
            isDelete = false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Image updating successfully'));
        }
        catch(DMLException e){
            hasImage = false;
            isDelete = false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error updating image'));
        }
        return candidatesImage;
    }
    public boolean hasImage(id recordId){
        List<ContentDocumentLink> candidatesImage = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId =: recordId];
        if(candidatesImage.size()>0){
           hasImage = true; 
        }
        else{
            hasImage = false;
        }
        return hasImage;
    }
}