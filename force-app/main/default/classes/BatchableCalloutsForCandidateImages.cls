global class BatchableCalloutsForCandidateImages implements Database.Batchable<Integer>,   Database.AllowsCallouts, Database.stateful {
	global List<Integer> listPage = new List<Integer>();
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
        pageNumber = (integer)(((countSelectedJob*1.0) / (10 *1.0)).round(RoundingMode.UP) -1);
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
            responseBody = InsertingRecordFromSecondOrg.getCandidateImagesFromTargetOrg(100, i);
            System.debug('body: ' + responseBody); 
            InsertingRecordFromSecondOrg.parsingCandidateImagesData(responseBody);
            //List<Job_Application__c> listForInsertRecords = InsertingRecordFromSecondOrg.parsingJobAppliationsRecords(responseBody);
            //upsert listForInsertRecords Legacy_Job_Application_Number__c;         
        }
    }
	global void finish(Database.BatchableContext BC){
        System.debug('heap size' + Limits.getHeapSize());
    }
}