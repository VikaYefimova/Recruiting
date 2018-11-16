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
            responseBody = InsertingRecordFromSecondOrg.getCVDataFromSecondOrg(3, i);
            system.debug('response: ' + responseBody);
            List<Candidate__c> listForInsert = InsertingRecordFromSecondOrg.parsingCandidateRecords(responseBody);
            listForInsertRecords.addAll(listForInsert);
        }
        upsert listForInsertRecords Legacy_Candidate_Number__c;
    }
	global void finish(Database.BatchableContext BC){
        System.debug('heap size' + Limits.getHeapSize());
        system.debug('list ' + listForInsertRecords.size());
        BatchableCalloutsForJobApplication batch = new BatchableCalloutsForJobApplication();
		Database.executeBatch(batch, 100);
    }
}