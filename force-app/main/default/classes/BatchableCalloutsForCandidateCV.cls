global class BatchableCalloutsForCandidateCV implements Database.Batchable<Integer>,   Database.AllowsCallouts, Database.stateful {
    global List<Integer> listPage = new List<Integer>();
    List<Candidate__c> listForInsertRecords = new List<Candidate__c>();
    public Integer pageNumber;
    global Iterable<Integer> start(Database.BatchableContext BC) {
        InsertingRecordFromSecondOrg obj = new InsertingRecordFromSecondOrg();
        String accessToken = obj.ReturnAccessToken(obj);
        String dataFromTargetOrg = InsertingRecordFromSecondOrg.getCountfromTargetOrg(accessToken);
        system.debug('response data' + dataFromTargetOrg);
        JSONParser parser = JSON.createParser(dataFromTargetOrg);
        parser.nextToken();
        parser.nextToken();
        Integer countCV = Integer.valueOf(parser.getText());
        pageNumber = (integer)(((countCV*1.0) / (100 *1.0)).round(RoundingMode.UP) -1);
        system.debug('page number: ' + pageNumber);
        for(Integer i = 0; i<=pageNumber; i++){
            listPage.add(i);
        }
        system.debug('selJOb: ' + listPage);
        return listPage;
    }
	global void execute(Database.BatchableContext BC, list<Integer> count){
        String responseBody;
        for(Integer i: count){
            System.debug('count' + i);
            responseBody = InsertingRecordFromSecondOrg.getCVDataFromSecondOrg(100, i);
            system.debug('response: ' + responseBody);
            List<Candidate__c> listForInsert = InsertingRecordFromSecondOrg.parsingCandidateRecords(responseBody);
            listForInsertRecords.addAll(listForInsert);
        }
        upsert listForInsertRecords Legacy_Candidate_Number__c;
        
        /*List<ContentVersion> candidateImagesForInsert = new List<ContentVersion>();
        List<ContentVersion> candidateImagesForUpdate = new List<ContentVersion>();
        system.debug('list ' + listForInsertRecords);
            for(Candidate__c can: listForInsertRecords){
                system.debug('name: ' + can.id + can.First_Name__c);
                Blob photo = EncodingUtil.base64Decode(can.Candidate_Photo__c);
                List<ContentVersion> currentImage = [select id from ContentVersion where Content_Version_Candidate_Number__c =: can.id];
                system.debug('size current image: ' + currentImage.size());
                if(currentImage.size() > 0){
                    system.debug('or may be here');
                    currentImage[0].Title = can.First_Name__c + can.Last_Name__c;
                    currentImage[0].VersionData = photo;
                    candidateImagesForUpdate.add(currentImage[0]);
                }
                else if (currentImage.size() == 0){
                    system.debug('i\'m here');
                    ContentVersion image = new ContentVersion();
                    image.VersionData = photo;
                    image.title = can.First_Name__c + can.Last_Name__c;
                    image.PathOnClient = '/image.jpg';
                    image.IsMajorVersion = false;
                    image.Content_Version_Candidate_Number__c = can.id;
                    candidateImagesForInsert.add(image);
                }
            }
        if(candidateImagesForInsert.size() > 0){
            system.debug('insert images: ');
            upsert candidateImagesForInsert;
        }
        if(candidateImagesForUpdate.size() > 0){
            system.debug('update images: ');
            update candidateImagesForUpdate;
        }
            system.debug('new candidates Images : ' + candidateImagesForInsert);*/
    }
	global void finish(Database.BatchableContext BC){
        System.debug('heap size' + Limits.getHeapSize());
        system.debug('list ' + listForInsertRecords.size());
        BatchableCalloutsForJobApplication batch = new BatchableCalloutsForJobApplication();
		Database.executeBatch(batch, 25);
        /*//upsert listForInsertRecords Legacy_Candidate_Number__c;
            List<ContentVersion> candidateImages = new List<ContentVersion>();
            for(Candidate__c can: listForInsertRecords){
                system.debug('name: ' + can.Name);
                Blob photo = EncodingUtil.base64Decode(can.Candidate_Photo__c);
                List<ContentVersion> currentImage = [select id from ContentVersion where Candidate__c =: can.id];
                if(currentImage.size() > 0){
                    system.debug('or may be here');
                    currentImage[0].Title = can.Name;
                    currentImage[0].VersionData = photo;
                    candidateImages.add(currentImage[0]);
                }
                else if (currentImage.size() == 0){
                    system.debug('i\'m here');
                    ContentVersion image = new ContentVersion();
                    image.VersionData = photo;
                    image.title = can.Name;
                    image.PathOnClient = '/image.jpg';
                    image.IsMajorVersion = false;
                    image.Candidate__c = can.id;
                    candidateImages.add(image);
                }
            }
            system.debug('new candidates Images : ' + candidateImages);*/
    }

}