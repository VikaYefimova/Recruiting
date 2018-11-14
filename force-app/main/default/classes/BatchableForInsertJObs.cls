global class BatchableForInsertJObs implements Database.Batchable<Job_Application__c>{
	global List<Job_Application__c> listOfJobs = new List<Job_Application__c>();
    public Integer pageNumber;
    
    public BatchableForInsertJObs(List<Job_Application__c> newJobs){
        this.listOfJobs = newJobs;
        system.debug('listOfJobs ' + listOfJobs);
    }
    global Iterable<Job_Application__c> start(Database.BatchableContext BC) {
        /*InsertingRecordFromSecondOrg obj = new InsertingRecordFromSecondOrg();
        String accessToken = obj.ReturnAccessToken(obj);
        String dataFromTargetOrg = InsertingRecordFromSecondOrg.getCountfromTargetOrg(accessToken);
        system.debug('response data' + dataFromTargetOrg);
        JSONParser parser = JSON.createParser(dataFromTargetOrg);
        parser.nextToken();
        parser.nextToken();
        parser.nextToken();
        Integer countSelectedJob = Integer.valueOf(parser.getText());
        pageNumber = (integer)(((countSelectedJob*1.0) / (100 *1.0)).round(RoundingMode.UP) -1);
        system.debug('page number: ' + pageNumber);
        for(Integer i = 0; i<=pageNumber; i++){
            listPage.add(i);
        }
        system.debug('selJOb: ' + listPage);*/
        return this.listOfJobs;
    }
	global void execute(Database.BatchableContext BC, list<Job_Application__c> jobs){
        /*String responseBody;
        for(Integer i: count){
            System.debug('count' + i);
            responseBody = InsertingRecordFromSecondOrg.getJobApplicationDataFromSecondOrg(100, i);
            System.debug('body: ' + responseBody); 
            listForInsertRecords = InsertingRecordFromSecondOrg.parsingJobAppliationsRecords(responseBody);          
        }
        //upsert listForInsertRecords Legacy_Job_Application_Number__c;
        system.debug('list: ' + listForInsertRecords);*/
    }
	global void finish(Database.BatchableContext BC){
        System.debug('heap size' + Limits.getHeapSize());
        //BatchableCalloutsForCandidateImages batch = new BatchableCalloutsForCandidateImages();
		//Database.executeBatch(batch, 100);
    }

}