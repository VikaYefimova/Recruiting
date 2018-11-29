global class BatchableCalloutsForCandidateCV implements Database.Batchable<Integer>,   Database.AllowsCallouts, Database.stateful {
    global List<Integer> listPage = new List<Integer>();
    global List<Integer> countOfRecords = new List<Integer>();
    List<Candidate__c> listForInsertRecords = new List<Candidate__c>();
    public Integer pageNumber;
    global Iterable<Integer> start(Database.BatchableContext BC) {
        InsertingRecordFromSecondOrg obj = new InsertingRecordFromSecondOrg();
        String accessToken = obj.ReturnAccessToken();
        String dataFromTargetOrg = InsertingRecordFromSecondOrg.getCountfromTargetOrg(accessToken);
        countOfRecords = parseRecordsCountList(dataFromTargetOrg);
        Integer countCV = countOfRecords[0];
        pageNumber = (integer)(((countCV*1.0) / (100 *1.0)).round(RoundingMode.UP) -1);
        for(Integer i = 0; i<=pageNumber; i++){
            listPage.add(i);
        }
        return listPage;
    }
	global void execute(Database.BatchableContext BC, list<Integer> count){
        String responseBody;
        for(Integer i: count){
            responseBody = InsertingRecordFromSecondOrg.getCVDataFromSecondOrg(100, i);
            List<Candidate__c> listForInsert = InsertingRecordFromSecondOrg.parsingCandidateRecords(responseBody);
            listForInsertRecords.addAll(listForInsert);
        }
        Schema.SObjectField fieldForUpsert = Candidate__c.fields.Legacy_Candidate_Number__c;
        Database.upsert(listForInsertRecords, fieldForUpsert);
    }
	global void finish(Database.BatchableContext BC){
        BatchableCalloutsForJobApplication batch = new BatchableCalloutsForJobApplication(countOfRecords);
		Database.executeBatch(batch, 95);
    }
    global List<Integer> parseRecordsCountList(String response){
        List<Integer> recordsCount = new List<Integer>();
        if(!String.isBlank(response)){
            recordsCount = (List<Integer>)JSON.deserialize(response, List<Integer>.class);
        }
        return recordsCount;
    }
}