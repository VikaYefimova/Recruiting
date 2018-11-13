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
        //System.debug('authorization response: ' + res.getBody());
        deserializeResponse resp1=(deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);
        //System.debug('accessToken: ' + resp1.access_token);
        return resp1.access_token;
    }
    public static void getCountOfRecords(){
        InsertingRecordFromSecondOrg obj = new InsertingRecordFromSecondOrg();
        String accessToken = obj.ReturnAccessToken(obj);
        String dataFromTargetOrg = getCountfromTargetOrg(accessToken);
        system.debug('response data' + dataFromTargetOrg);
        
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
            req.setEndpoint('https://eu16.salesforce.com/services/data/v24.0/query/?q=SELECT+id+,+name+,+Phone__c+,+Email__c+,+Status__c+,+Candidate_Age__c+from+CandidateCV__c+Limit+'+ limitForSearch + '+OFFSET+' + (offset*limitForSearch));
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            dataFromTargetOrg = res.getBody();
            system.debug('get data response: ' + dataFromTargetOrg);
        }
        return dataFromTargetOrg;
    }
    public static String getJobApplicationDataFromSecondOrg(Integer limitForSearch, Integer offset){
        String dataFromTargetOrg;
        InsertingRecordFromSecondOrg obj = new InsertingRecordFromSecondOrg();
        String accessToken = obj.ReturnAccessToken(obj);
        if(accessToken != null){
            Http http= new Http();
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization','Bearer ' + accessToken);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint('https://eu16.salesforce.com/services/data/v24.0/query/?q=SELECT+id+,+CandidateCV__c+,+Candidate_Phone__c+,+Candidate_Salary__c+,+Candidate_Status__c+,+Candidate_Age__c,+Additional_Info__c,+Job_Advertisement__c+from+Selected_Job__c+Limit+'+ limitForSearch + '+OFFSET+' + (offset*limitForSearch));
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            dataFromTargetOrg = res.getBody();
        }
        return dataFromTargetOrg;
    }
    public static string getCandidateImagesFromTargetOrg(Integer limitForSearch, Integer offset){
        String dataFromTargetOrg;
        InsertingRecordFromSecondOrg obj = new InsertingRecordFromSecondOrg();
        String accessToken = obj.ReturnAccessToken(obj);
        if(accessToken != null){
            Http http= new Http();
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization','Bearer ' + accessToken);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint('https://eu16.salesforce.com/services/apexrest/getImages/' + (limitForSearch*offset));
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            dataFromTargetOrg = res.getBody();
            system.debug('get data response: ' + dataFromTargetOrg);
            system.debug('response size: ' + res.getBodyAsBlob().size());
        }
        return dataFromTargetOrg;
    }
    public static List<Candidate__c> parsingCandidateRecords(String responseBody){
        system.debug('parser start working');
        List<Candidate__c> listOfNewCandidates = new List<Candidate__c>();
        Boolean flag = true;
        Candidate__c newCandidate;
            JSONParser parser = JSON.createParser(responseBody);
            while(parser.nextToken() != null){
                
                if(parser.getCurrentToken() == JSONToken.START_OBJECT){
                    newCandidate = new Candidate__c();
                    flag = true;
					                  
                }
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Id')){
                    
                    parser.nextToken();
                    newCandidate.Legacy_Candidate_Number__c = parser.getIdValue();
                }
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Name')){
                    parser.nextToken();
                    String nameToSplit = parser.getText();
                    List<String> names = nameToSplit.split(' ');
                    if(names.size() > 1){
                        newCandidate.First_Name__c = names[0];
                        newCandidate.Last_Name__c = names[1];
                    }
                    else if(names.size() == 1){
                        newCandidate.First_Name__c = names[0];
                    }
                }
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Candidate_Age__c')){
                    parser.nextToken();
                    newCandidate.Age__c = Decimal.valueOf(parser.getText());
                    //system.debug(parser.getText());
                }
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Email__c')){
                    parser.nextToken();
                    newCandidate.Email__c = parser.getText();
                    //system.debug(parser.getText());
                }
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Phone__c')){
                    parser.nextToken();
                    newCandidate.Phone__c = parser.getText();
                    //system.debug(parser.getText());
                }
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Candidate_Photo__c')){
                    parser.nextToken();
                    //newCandidate.Candidate_Photo__c = parser.getText();
                }
                if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Status__c')){
                    parser.nextToken();
                    if(parser.getText() == 'Employed'){
                        newCandidate.Currently_Employed__c = true;
                    }
                    else if(parser.getText() == 'Unemployed'){
                        newCandidate.Currently_Employed__c = false;
                    }
                    system.debug(parser.getText());
                }
                if(parser.getCurrentToken() == JSONToken.END_OBJECT){
                    if(flag){
                        listOfNewCandidates.add(newCandidate);
                        flag = false;
                    }  
                }
        }
        system.debug('listOfNewCandidates:    ' + listOfNewCandidates);
        return listOfNewCandidates;
    }
    
    public static List<Job_Application__c> parsingJobAppliationsRecords(String responseBody){
        List<Job_Application__c> newJobApplicationRecords = new List<Job_Application__c>();
        List<Position__c> positions = [select id, Legacy_Position_Number__c from Position__c];
        List<Candidate__c> candidates = [select id, Legacy_Candidate_Number__c from Candidate__c];
        List<Map<String, String>> canidatesMap = new List<Map<String, String>>();
        List<Map<String, String>> positionsMap = new List<Map<String, String>>();
        Map<String, String> candidate;
        for(Candidate__c can: candidates){
            candidate = new Map<String, String>();
            candidate.put('id', can.Id);
            candidate.put('legacyId', can.Legacy_Candidate_Number__c);
            canidatesMap.add(candidate);
        }
        Map<String, String> positionMap;
        for(Position__c pos: positions){
            positionMap = new Map<String, String>();
            positionMap.put('id', pos.Id);
            positionMap.put('legacyId', pos.Legacy_Position_Number__c);
            positionsMap.add(positionMap);
        }
        Boolean flag = true;
        Job_Application__c newJobApplication;
        //system.debug('response' + responseBody);
        JSONParser parser = JSON.createParser(responseBody);
        integer c = 0;
        while(parser.nextToken() != null){
                System.JSONToken token = parser.getCurrentToken();
                String text = parser.getText();
                if(token == JSONToken.START_OBJECT){
                    newJobApplication = new Job_Application__c();
                    flag = true;
                }
                if(token == JSONToken.FIELD_NAME && (text == 'Id')){
                    parser.nextToken();
                    newJobApplication.Legacy_Job_Application_Number__c = parser.getIdValue();
                }
                /*if(token == JSONToken.FIELD_NAME && (text == 'Candidate_Phone__c')){
                    parser.nextToken();
                    newJobApplication.Candidate_Phone__c = parser.getText();
                }*/
                /*if(token == JSONToken.FIELD_NAME && (text == 'Candidate_Age__c')){
                    parser.nextToken();
                    newJobApplication.Candidate_Age__c = Decimal.valueOf(parser.getText());
                }
                if(token == JSONToken.FIELD_NAME && (text == 'Candidate_Salary__c')){
                    parser.nextToken();
                    newJobApplication.Candidate_Salary__c = parser.getText();
                }*/
                /*if(token == JSONToken.FIELD_NAME && (text == 'Additional_Info__c')){
                    parser.nextToken();
                    newJobApplication.Additional_Info__c = parser.getText();
                }*/
                /*if(token == JSONToken.FIELD_NAME && (text == 'Candidate_Status__c')){
                    parser.nextToken();
                    if(parser.getText() == 'Employed'){
                        newJobApplication.Currently_Employed__c = true;
                    }
                    else if(parser.getText() == 'Unemployed'){
                        newJobApplication.Currently_Employed__c = false;
                    }
                }*/
                if(token == JSONToken.FIELD_NAME && (text == 'CandidateCV__c')){
                    parser.nextToken();
                    for(Map<String, String> canMap: canidatesMap){
                        if(canMap.get('legacyId') == parser.getIdValue()){
                           newJobApplication.Candidate__c =  canMap.get('id');
                        }
                    }
                }
                if(token == JSONToken.FIELD_NAME && (text == 'Job_Advertisement__c')){
                    parser.nextToken();
                    for(Map<String, String> posMap : positionsMap){
                        if(posMap.get('legacyId') == parser.getIdValue()){
                            newJobApplication.Position__c = posMap.get('id');
                        }
                    }
                }
                if(token == JSONToken.END_OBJECT){
                    if(flag){
                        newJobApplicationRecords.add(newJobApplication);
                        flag = false;
                    }
                }
        }
        system.debug('listOfNewCaniddates ccccc:    ' + c);
        //system.debug('listOfNewCaniddates:    ' + newJobApplicationRecords);
        return newJobApplicationRecords;
    }
    public static Set<ContentVersion> parsingCandidateImagesData(String responseBody){
        Set<ContentVersion> newImages = new Set<ContentVersion>();
        Boolean flag = true;
        ContentVersion newImage;
        JSONParser parser = JSON.createParser(responseBody);
        Integer level = 0;
        while(parser.nextToken() != null){
            if(parser.getCurrentToken() == JSONToken.START_OBJECT){
                newImage = new ContentVersion();
                flag = true;
            }
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Candidate_Number__c')){
                parser.nextToken();
                Candidate__c can = [select id from Candidate__c where Legacy_Candidate_Number__c = : parser.getIdValue()];
                newImage.Content_Version_Candidate_Number__c = can.id;
            }
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'contentBody')){
                parser.nextToken();
                system.debug('hi. I\'m here');
                Blob photo = EncodingUtil.base64Decode(parser.getText());
                newImage.VersionData = photo;
                System.debug('photo:   ' + photo);
            }
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Title')){
                parser.nextToken();
                newImage.Title = parser.getText();
            }
            if(parser.getCurrentToken() == JSONToken.END_OBJECT){
                if(flag){
                    newImages.add(newImage);
                	flag = false;
                }
                
            }
        }
        system.debug('images:  ' + newImages);
        return newImages;
    }
}