global class BatchableCalloutsForJobApplication implements Database.Batchable<Integer>,   Database.AllowsCallouts, Database.stateful {
	global List<Integer> listPage = new List<Integer>();
    public Integer pageNumber;
    List<Job_Application__c> listForInsertRecords = new List<Job_Application__c>();
    global Iterable<Integer> start(Database.BatchableContext BC) {
        InsertingRecordFromSecondOrg obj = new InsertingRecordFromSecondOrg();
        String accessToken = obj.ReturnAccessToken(obj);
        String dataFromTargetOrg = InsertingRecordFromSecondOrg.getCountfromTargetOrg(accessToken);
        JSONParser parser = JSON.createParser(dataFromTargetOrg);
        parser.nextToken();
        parser.nextToken();
        parser.nextToken();
        Integer countSelectedJob = Integer.valueOf(parser.getText());
        pageNumber = (integer)(((countSelectedJob*1.0) / (100 *1.0)).round(RoundingMode.UP) -1);
        for(Integer i = 0; i<=pageNumber; i++){
            listPage.add(i);
        }
        return listPage;
    }
	global void execute(Database.BatchableContext BC, list<Integer> count){
        String responseBody;
		Integer level = 0;
        for(Integer i: count){
            responseBody = InsertingRecordFromSecondOrg.getJobApplicationDataFromSecondOrg(10, i);
            system.debug('responseBody + ' + responseBody);
            listForInsertRecords.addAll(InsertingRecordFromSecondOrg.parsingJobAppliationsRecords(responseBody));
            system.debug('size ' + listForInsertRecords.size());
        }
        System.debug('before listForInsertRecords ' + listForInsertRecords);
        upsert listForInsertRecords Legacy_Job_Application_Number__c;
    }
	global void finish(Database.BatchableContext BC){
        System.debug('heap size' + Limits.getHeapSize());
        BatchableCalloutsForCandidateImages batch = new BatchableCalloutsForCandidateImages();
		Database.executeBatch(batch, 70);
    }
}