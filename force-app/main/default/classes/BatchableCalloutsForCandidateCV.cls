global class BatchableCalloutsForCandidateCV implements Database.Batchable<Integer>,   Database.AllowsCallouts, Database.stateful {
    global List<Integer> listPage = new List<Integer>();
    public Integer pageNumber;
    public List<String> responseBodies = new List<String>();
    global BatchableCalloutsForCandidateCV(){
       
    }
    global Iterable<Integer> start(Database.BatchableContext BC) {
        InsertingRecordFromSecondOrg obj = new InsertingRecordFromSecondOrg();
        String accessToken = obj.ReturnAccessToken(obj);
        String dataFromTargetOrg = InsertingRecordFromSecondOrg.getCountfromTargetOrg(accessToken);
        system.debug('response data' + dataFromTargetOrg);
        JSONParser parser = JSON.createParser(dataFromTargetOrg);
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
        integer listSize = count.size();
        system.debug('listSize' + listSize);
        integer lastPage = count.get(listSize-1);
        system.debug('lastPage' + lastPage);
        system.debug('list: ' + listPage);
        String responseBode;
        //System.debug('last page number: ' + pageNumber);
        for(Integer i: count){
            if((100*i) < lastPage){
                System.debug('count' + i);
                responseBode = InsertingRecordFromSecondOrg.getCVDataFromSecondOrg(100, i);
                System.debug('body: ' + responseBode); 
            	responseBodies.add(responseBode);
            }            
        }
    }
	global void finish(Database.BatchableContext BC){
        system.debug('responses of callouts: ' + responseBodies);
    }

}