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
        pageNumber = (integer)(((countSelectedJob*1.0) / (2 *1.0)).round(RoundingMode.UP) -1);
        system.debug('page number: ' + pageNumber);
        for(Integer i = 0; i<=pageNumber; i++){
            listPage.add(i);
        }
        
        return listPage;
    }
	global void execute(Database.BatchableContext BC, list<Integer> count){
        String responseBody;
        system.debug('selJOb: ' + count);
        for(Integer i: count){
            System.debug('count' + i);
            responseBody = InsertingRecordFromSecondOrg.getCandidateImagesFromTargetOrg(2, i);
            
            System.debug('body: ' + responseBody); 
            Set<ContentVersion> listRecords = InsertingRecordFromSecondOrg.parsingCandidateImagesData(responseBody);
            system.debug('list: ' + listRecords);
            for(ContentVersion con: listRecords){
                List<ContentVersion> currentImage = [select id from ContentVersion where Content_Version_Candidate_Number__c =: con.Content_Version_Candidate_Number__c];
                if(currentImage.size() == 0){
                    con.PathOnClient = '/image.jpg';
                    con.IsMajorVersion = false;
                }
                images.add(con);
            }
        }
        system.debug('can' + images);
        upsert images Content_Version_Candidate_Number__c;
        List<ContentDocumentLink> assignedImages = new List<ContentDocumentLink>();
        for(ContentVersion image: images){
            List<ContentDocumentLink> currentImage = [select id from ContentDocumentLink where LinkedEntityId =: image.Content_Version_Candidate_Number__c];
           	if(currentImage.size() == 0){
                ContentVersion versioncon = [select ContentDocumentId from ContentVersion where id =: image.id];
            	system.debug('con ver' + versioncon);
                ContentDocumentLink relatedFile = new ContentDocumentLink();
                Id contentid = versioncon.ContentDocumentId;
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