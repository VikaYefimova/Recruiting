global class BatchableCalloutsForCandidateImages implements Database.Batchable<Integer>,   Database.AllowsCallouts {
	global List<Integer> listPage = new List<Integer>();
    List<ContentVersion> images = new List<ContentVersion>();
    public Integer pageNumber;
    global Iterable<Integer> start(Database.BatchableContext BC) {
        InsertingRecordFromSecondOrg obj = new InsertingRecordFromSecondOrg();
        String accessToken = obj.ReturnAccessToken(obj);
        String dataFromTargetOrg = InsertingRecordFromSecondOrg.getCountfromTargetOrg(accessToken);
        system.debug('response data' + dataFromTargetOrg);
        JSONParser parser = JSON.createParser(dataFromTargetOrg);
        parser.nextToken();
        parser.nextToken();
        parser.nextToken();
        parser.nextToken();
        Integer countSelectedJob = Integer.valueOf(parser.getText());
        pageNumber = (integer)(((countSelectedJob*1.0) / (40 *1.0)).round(RoundingMode.UP) -1);
        system.debug('page number: ' + pageNumber);
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
            System.debug('count' + i);
            try{
                responseBody = InsertingRecordFromSecondOrg.getCandidateImagesFromTargetOrg(40,i);
                Set<ContentVersion> listRecords = InsertingRecordFromSecondOrg.parsingCandidateImagesData(responseBody);
                for(ContentVersion con: listRecords){
                        string candidateId = con.Content_Version_Candidate_Number__c; 
                        if(!contentVersionsMap.containsKey(candidateId)){
                        	con.PathOnClient = '/image.jpg';
                            con.IsMajorVersion = false;
                        }
                    images.add(con);
                }
            }
            catch(CalloutException e ){
                responseBody = InsertingRecordFromSecondOrg.getCandidateImagesFromTargetOrg(40, i); 
                Set<ContentVersion> listRecords = InsertingRecordFromSecondOrg.parsingCandidateImagesData(responseBody);
                for(ContentVersion con: listRecords){
                    string candidateId = con.Content_Version_Candidate_Number__c; 
                    if(!contentVersionsMap.containsKey(candidateId)){
                      	con.PathOnClient = '/image.jpg';
                        con.IsMajorVersion = false;
                    }      
                    images.add(con);
                }
            } 
        }
        system.debug('can' + images);
        Map<String, Integer> countImages = new Map<String, Integer>();
        Integer counter = 0;
        upsert images Content_Version_Candidate_Number__c;
        List<ContentDocumentLink> assignedImages = new List<ContentDocumentLink>();
        string contentId = '';
        for(ContentVersion image: images){
            if(!documentLinkMap.containsKey(image.Content_Version_Candidate_Number__c)){
                contentId = contentVersionsMap.get(image.Content_Version_Candidate_Number__c);
                ContentDocumentLink relatedFile = new ContentDocumentLink();
                system.debug('doc: ' + contentid);
                relatedFile.ContentDocumentId = contentid;
                relatedFile.LinkedEntityId = image.Content_Version_Candidate_Number__c;
                relatedFile.ShareType = 'I';
                assignedImages.add(relatedFile);
            }
        }
        if(assignedImages.size() > 0){
            insert assignedImages;
        }
    }
	global void finish(Database.BatchableContext BC){
        System.debug('heap size' + Limits.getHeapSize());
        system.debug('list: ' + listPage);
    }
}