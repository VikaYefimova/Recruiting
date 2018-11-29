global class BatchableCalloutsForCandidateImages implements Database.Batchable<Integer>,   Database.AllowsCallouts {
	global List<Integer> listPage = new List<Integer>();
    List<ContentVersion> images = new List<ContentVersion>();
    global List<Integer> countOfRecords = new List<Integer>();
    Set<ContentVersion> listRecords = new Set<ContentVersion>();
    public Integer pageNumber;
    public BatchableCalloutsForCandidateImages(List<Integer> recordsCount){
        this.countOfRecords = recordsCount;
    }
    global Iterable<Integer> start(Database.BatchableContext BC) {
        Integer countSelectedJob = countOfRecords[2];
        pageNumber = (integer)(((countSelectedJob*1.0) / (65 *1.0)).round(RoundingMode.UP) -1);
        for(Integer i = 0; i<=pageNumber; i++){
            listPage.add(i);
        }
        return listPage;
    }
	global void execute(Database.BatchableContext BC, list<Integer> count){
        String responseBody;
        List<ContentVersion> contentVersions = [select id, Content_Version_Candidate_Number__c, ContentDocumentId from ContentVersion];
        Map<String, String> contentVersionsMap = new Map<String, String>();
        for(ContentVersion conVer: contentVersions){
            contentVersionsMap.put(conVer.Content_Version_Candidate_Number__c, conVer.ContentDocumentId);
        }
        List<ContentDocumentLink> documentLinks = [select id, LinkedEntityId from ContentDocumentLink where LinkedEntityId in (select id from Candidate__c)];
        Map<String, String> documentLinkMap = new Map<String, String>();
        for(ContentDocumentLink docLink: documentLinks){
            documentLinkMap.put(docLink.LinkedEntityId, docLink.id);
        }
        for(Integer i: count){
            responseBody = InsertingRecordFromSecondOrg.getCandidateImagesFromTargetOrg(65,i);
            listRecords = InsertingRecordFromSecondOrg.parsingCandidateImagesData(responseBody);
            for(ContentVersion con: listRecords){
                string candidateId = con.Content_Version_Candidate_Number__c; 
                if(!contentVersionsMap.containsKey(candidateId)){
                  	con.PathOnClient = '/image.jpg';
                    con.IsMajorVersion = false;
                }      
                images.add(con);
            }
        }
        Map<String, Integer> countImages = new Map<String, Integer>();
        Integer counter = 0;
        Schema.SObjectField fieldForUpsert = ContentVersion.fields.Content_Version_Candidate_Number__c;
        Database.upsert(images, fieldForUpsert);
        List<ContentDocumentLink> assignedImages = new List<ContentDocumentLink>();
        string contentId = '';
        if(Test.isRunningTest()){
            images = [select id, ContentDocumentId, Content_Version_Candidate_Number__c from ContentVersion];
        }
        for(ContentVersion image: images){
            if(!documentLinkMap.containsKey(image.Content_Version_Candidate_Number__c)){
                contentId = contentVersionsMap.get(image.Content_Version_Candidate_Number__c);
                if(Test.isRunningTest()){
                    contentId = image.ContentDocumentId;
                }
                ContentDocumentLink relatedFile = new ContentDocumentLink();
                relatedFile.ContentDocumentId = contentid;
                relatedFile.LinkedEntityId = image.Content_Version_Candidate_Number__c;
                relatedFile.ShareType = 'I';
                assignedImages.add(relatedFile);
            }
        }
        if(assignedImages.size() > 0){
                Database.insert(assignedImages);
        }
    }
	global void finish(Database.BatchableContext BC){
        System.debug('heap size' + Limits.getHeapSize());
        system.debug('list: ' + listPage);
    }
}