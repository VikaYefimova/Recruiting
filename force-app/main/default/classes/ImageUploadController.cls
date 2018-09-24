public class ImageUploadController {
    public Id recordId;
    public Blob file{get;set;}
    public boolean hasImage{get; set;}
    public boolean isDelete{get; set;}
    
    public Document document {
      get {
          if(document == null)
          document = new Document();
          return document;
        }
      set;
    }

    public ImageUploadController(ApexPages.StandardController controller) {
        recordId = controller.getId();
        if(!hasImage(recordId)){
            hasImage  = false;
        }
        else{
            hasImage = true;
        }
    }
    public PageReference upload() {
        String recId = recordId;
        uploadCandidateImage(recId, file);
        return null;
    }
    public PageReference deleteImage(){
        String search = '%'+recordId;
        List<Document> candidatesImage = [select id from Document where Name Like :search];
        deleteCandidateImage(candidatesImage);
        return null;
    }
    public PageReference updateImage(){
        String search = '%'+recordId+'%';
        String candidateId = recordId;
        Document candidatesImage = [select id from Document where Name Like :search Limit 1];
        updateImage(candidatesImage, candidateId, file);
        return null;
    }
    
    public boolean hasImage(id recordId){
        String search = '%'+recordId+'%';
        List<Document> candidatesImage = [select id from Document where Name =: recordId];
        if(candidatesImage.size()>0){
           hasImage = true; 
        }
        else{
            hasImage = false;
        }
        return hasImage;
    }
    public Document uploadCandidateImage(String recordId, Blob file){
        Document document = new Document();
            document.Name = recordId;
            document.ContentType = 'image/jpeg';
            document.Body = file;
            document.FolderId = '00l3E000000NxlQ';
            try {
                hasImage = true;
                insert document;
                isDelete = false;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Image uploaded successfully'));
                return null;
            } catch (DMLException e) {
                hasImage = false;
                isDelete = false;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'Error uploading image'));
            }
        return document;
    }
    public String deleteCandidateImage(List<Document> images){
        String message;
        try{
            delete images;
            isDelete = true;
            message = 'Image deleted successfully';
        	ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, message));
        }
        catch(DMLException e){
           hasImage = false;
           isDelete = false;
           message = e.getDmlMessage(0);
           ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, message));
        }
        return message;
    }
    public Document updateImage(Document doc, String recordId, Blob file){
            doc.Name = recordId;
            doc.ContentType = 'image/jpg';
            doc.Body = file;
            doc.FolderId = '00l3E000000NxlQ';
            try {
                hasImage = true;
                isDelete = false;
                update doc;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Image updating successfully'));
            } catch (DMLException e) {
                hasImage = false;
                isDelete = false;
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error updating image'));
            }
        return doc;
    }
}