public class InsertingRecordFromSecondOrg {
	String accesstoken_url='https://login.salesforce.com/services/oauth2/token';
    String authurl='https://login.salesforce.com/services/oauth2/authorize';
    
  public class deserializeResponse{
      public String id;
      public String access_token;   
   }
    public String ReturnAccessToken(InsertingRecordFromSecondOrg pos){
        List_Setting__c customSetting = [select id, Name, Login_c__c, Password__c, Client_secret__c, 
                                                  Consumer_Secret__c, Link_to_connected_org__c from List_Setting__c];
        String clientId = customSetting.Consumer_Secret__c;
        String clientsecret = customSetting.Client_secret__c;
        
        String reqbody = 'grant_type=password&client_id='+customSetting.Consumer_Secret__c+'&client_secret='+customSetting.Client_secret__c+'&username='+customSetting.Login_c__c+'&password='+customSetting.Password__c;
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
       
        req.setEndpoint('https://eu16.salesforce.com/services/oauth2/token');  
        HttpResponse res=h.send(req);
        System.debug('authorization response: ' + res.getBody());
        deserializeResponse resp1=(deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);
        System.debug('accessToken: ' + resp1.access_token);
        return resp1.access_token;
    }
    public static void getCountOfRecords(){
        InsertingRecordFromSecondOrg obj = new InsertingRecordFromSecondOrg();
        String accessToken = obj.ReturnAccessToken(obj);
        String dataFromTargetOrg = getCountfromTargetOrg(accessToken);
        system.debug('response data' + dataFromTargetOrg);
        /*JSONParser parser = JSON.createParser(dataFromTargetOrg);
        parser.nextToken();
        parser.nextToken();
        Integer countCV = Integer.valueOf(parser.getText());
        parser.nextToken();
        Integer countSelectedJob = Integer.valueOf(parser.getText());
        parser.nextToken();
        Integer countPhoto = Integer.valueOf(parser.getText());
        List<Integer> selJOb = new List<Integer>();
        for(Integer i = 0; i<=countSelectedJob; i++){
            selJOb.add(i);
        }
        */
    }
    public static String getCountfromTargetOrg(String accessToken){
        String dataFromTargetOrg;
        if(accessToken != null){
            Http http= new Http();
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization','Bearer ' + accessToken);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint('https://eu16.salesforce.com/services/apexrest/recordsCount');
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            dataFromTargetOrg = res.getBody();
            system.debug('get data response: ' + dataFromTargetOrg);
        }
        return dataFromTargetOrg;
    }
    public static String getCVDataFromSecondOrg(Integer limitForSearch, Integer offset){
        
        String dataFromTargetOrg;
        InsertingRecordFromSecondOrg obj = new InsertingRecordFromSecondOrg();
        String accessToken = obj.ReturnAccessToken(obj);
        if(accessToken != null){
            Http http= new Http();
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization','Bearer ' + accessToken);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint('https://eu16.salesforce.com/services/data/v24.0/query/?q=SELECT+name+,+Phone__c+,+Email__c+,+Status__c+,+Candidate_Age__c+from+CandidateCV__c+Limit+'+ limitForSearch + '+OFFSET+' + offset);
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            dataFromTargetOrg = res.getBody();
            system.debug('get data response: ' + dataFromTargetOrg);
        }
        return dataFromTargetOrg;
    }
}