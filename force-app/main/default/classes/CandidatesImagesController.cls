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
        ContentVersion image = new ContentVersion();
        String candidateName = getCandidateName(recordId);
        uploadCandidatesImage(file, candidateName, recordId);
        return null;
    }
    public PageReference deleteImage(){
        String candidateName = getCandidateName(recordId);
        id documentid = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId =: recordId].ContentDocumentId;
        List<ContentDocument> candidatesImage = [select id from ContentDocument where Id =: documentid];
        deleteCandidatePhoto(candidatesImage);
        return null;
    }
    public PageReference updateImage(){
        String candidateName = getCandidateName(recordId);
        id documentid = [select ContentDocumentId from ContentDocumentLink where LinkedEntityId =: recordId].ContentDocumentId;
        ContentVersion candidatesImage = [select id from ContentVersion where ContentDocumentId =: documentid And isLatest = True];
        updateCandidateImage(candidatesImage, file);
        return null;
    }
    public ContentVersion uploadCandidatesImage(Blob file, String candidateName, id recId){
        ContentVersion image = new ContentVersion();
        image.VersionData = file;
        image.title = candidateName;
        image.PathOnClient = '/image.jpg';
        image.IsMajorVersion = false;
        try{
            insert image;
            hasImage = true;
            isDelete = false;
            ContentDocumentLink relatedFile = new ContentDocumentLink();
            Id contentid = [select ContentDocumentId from ContentVersion where Title =: candidateName].ContentDocumentId;
            relatedFile.ContentDocumentId = contentid;
            relatedFile.LinkedEntityId = recId;
            relatedFile.ShareType = 'I';
            insert relatedFile;
            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Image uploaded successfully'));
        }
        catch(DMLException e){
            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error uploading image'));
        }
        return image;
    }
    public String deleteCandidatePhoto(List<ContentDocument> candidateImages){
        String message;
        try{
            delete candidateImages;
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
        ///////.jkljljll
    }
    public ContentVersion updateCandidateImage(ContentVersion candidateImage, Blob file){
        candidateImage.VersionData = file;
        try{
            update candidateImage;
            hasImage = true;
            isDelete = false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Image updating successfully'));
        }
        catch(DMLException e){
            hasImage = false;
            isDelete = false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error updating image'));
        }
        return candidateImage;
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
    public String getCandidateName(id recordId){
        String candidateName = [select Name from Candidate__c Where Id =: recordId].Name;
        return candidateName;
    }
}