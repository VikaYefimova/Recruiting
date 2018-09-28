public class SendPositionUsingRestApi {
String clientId='3MVG9fTLmJ60pJ5I9d8FcNmhnOyWg4QBXzptmhuhTNPXtWTsLGzeihB6UX.YrwAW6wOsB2SpHWM8AeoR8FUyz';
    String clientsecret='6062214781788623861';
    string username='vikaephimova1996@mycomp.com';
    String password='hibd2014';
    String accesstoken_url='https://login.salesforce.com/services/oauth2/token';
    String authurl='https://login.salesforce.com/services/oauth2/authorize';
  public class deserializeResponse{
      public String id;
      public String access_token;   
   }
    public String ReturnAccessToken(SendPositionUsingRestApi pos){
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
       
        req.setEndpoint('https://eu16.salesforce.com/services/oauth2/token'); //instance Target Org  
        HttpResponse res=h.send(req);
        System.debug(res.getBody()+'###1203res');
        deserializeResponse resp1=(deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);
        System.debug(resp1+'###1203deserializeresponse');
        return resp1.access_token;
    }

   @future(callout=true)
    public static void createJobAdvertisement(id pos){
        Position__c position = [select Name, Education__c, Location__c, Hiring_Manager__c, Legacy_Position_Number__c, Salary_Range__c, Skills_Required__c, Job_Description__c from Position__c where id =: pos];
        User recruiterUser = [select Name, Email, Phone from User where id =: position.Hiring_Manager__c];
        SendPositionUsingRestApi pos1= new SendPositionUsingRestApi();
        String accessToken=pos1.ReturnAccessToken(pos1);
        System.debug(accessToken+'###0012');
        if(accessToken!=null){
            String posId = position.Id;
            String endPoint='https://eu16.salesforce.com/services/data/v32.0/sobjects/Job_Advertisement__c'; //Instance  Target Org 
			String jsonstr='{"Name":"'+ position.Name + '", "Location__c":"' + position.Location__c +'", "Education__c":"' + position.Education__c +
    					'", "Salary__c":"' + position.Salary_Range__c + '", "Skills_Required__c":"' + position.Skills_Required__c + '", "Description__c":"' 
                        + position.Job_Description__c + '", "Manager_name__c":"' + recruiterUser.Name + '", "Email__c":"' + recruiterUser.Email + 
                        '", "Phone__c":"' + recruiterUser.Phone +'", "Legacy_Job_Advertisement_Number__c":"' + position.id + '", "Status__c":"Active"}';
            
            system.debug('Show me String jsonstr='+jsonstr);
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setBody(jsonstr);
            req2.setMethod('POST');
            req2.setEndpoint(endPoint);
            HttpResponse res2=h2.send(req2);
            System.debug(res2+'###1203createresp');
            deserializeResponse deresp2=(deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
            System.debug('Show me request body' + req2.getBody());
            System.debug('Show me response body' + res2.getBody());
        }
    }
    
    @future(callout=true)
    public static void updateJobAdvertisement(id pos){
        String dataFromTargetOrg = getDatafromTargetOrg();
        List<Map<String, String>> data = parsingDataFromTargetOrg(dataFromTargetOrg);
        String jobAdvertisementsId;
        for(Map<String, String> item: data){
            if(item.get('Legacy_Job_Advertisement_Number__c') == pos){
                jobAdvertisementsId = item.get('Id');
            }
        }
        system.debug('show me id of Job Advertisements: ' + jobAdvertisementsId);
        Position__c position = [select Name, Education__c, Location__c, Hiring_Manager__c, Legacy_Position_Number__c, Salary_Range__c, Skills_Required__c, Job_Description__c from Position__c where id =: pos];
        User recruiterUser = [select Name, Email, Phone from User where id =: position.Hiring_Manager__c];
        SendPositionUsingRestApi sendPositionUsingRestApi = new SendPositionUsingRestApi();
        String accessToken = sendPositionUsingRestApi.ReturnAccessToken(sendPositionUsingRestApi);
        if(accessToken!=null){
            String posId = position.Id;
            String endPoint='https://eu16.salesforce.com/services/data/v32.0/sobjects/Job_Advertisement__c/' + jobAdvertisementsId + '?_HttpMethod=PATCH'; //Instance  Target Org 
			String jsonstr='{"Name":"'+ position.Name + '", "Location__c":"' + position.Location__c +'", "Education__c":"' + position.Education__c +
    					'", "Salary__c":"' + position.Salary_Range__c + '", "Skills_Required__c":"' + position.Skills_Required__c + '", "Description__c":"' 
                        + position.Job_Description__c + '", "Manager_name__c":"' + recruiterUser.Name + '", "Email__c":"' + recruiterUser.Email + 
                        '", "Phone__c":"' + recruiterUser.Phone +'", "Legacy_Job_Advertisement_Number__c":"' + position.id + '", "Status__c":"Active"}';
            
            system.debug('Show me String jsonstr='+jsonstr);
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setBody(jsonstr);
            req2.setMethod('POST');
            req2.setEndpoint(endPoint);
            HttpResponse res2=h2.send(req2);
            System.debug(res2+'###1203createresp');
            //deserializeResponse deresp2=(deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
            System.debug('Show me request body' + req2.getBody());
            System.debug('Show me response body' + res2.getBody());
        }
    }
    @future(callout=true)
    public static void deleteJobAdvertisement(id pos){
        String dataFromTargetOrg = getDatafromTargetOrg();
        List<Map<String, String>> data = parsingDataFromTargetOrg(dataFromTargetOrg);
        String jobAdvertisementsId;
        for(Map<String, String> item: data){
            if(item.get('Legacy_Job_Advertisement_Number__c') == pos){
                jobAdvertisementsId = item.get('Id');
            }
        }
        system.debug('show me id of Job Advertisements: ' + jobAdvertisementsId);
        SendPositionUsingRestApi sendPositionUsingRestApi = new SendPositionUsingRestApi();
        String accessToken = sendPositionUsingRestApi.ReturnAccessToken(sendPositionUsingRestApi);
        if(accessToken != null){
            String endPoint='https://eu16.salesforce.com/services/data/v32.0/sobjects/Job_Advertisement__c/' + jobAdvertisementsId;
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            //req2.setBody(jsonstr);
            req2.setMethod('DELETE');
            req2.setEndpoint(endPoint);
            HttpResponse res2=h2.send(req2);
            //System.debug(res2+'###1203createresp');
            //deserializeResponse deresp2=(deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
            System.debug('Show me request body' + req2.getBody());
            System.debug('Show me response body' + res2.getBody());
        }
    }
    public static String getDatafromTargetOrg(){
        SendPositionUsingRestApi sendPositionUsingRestApi = new SendPositionUsingRestApi();
        String accessToken = sendPositionUsingRestApi.ReturnAccessToken(sendPositionUsingRestApi);
        String dataFromTargetOrg;
        if(accessToken != null){
            Http http= new Http();
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization','Bearer ' + accessToken);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint('https://eu16.salesforce.com/services/data/v20.0/query/?q=select+id+,+Legacy_Job_Advertisement_Number__c+from+Job_Advertisement__c');
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            dataFromTargetOrg = res.getBody();
            System.debug('show me response body: ' + dataFromTargetOrg);
        }
        return dataFromTargetOrg;
    }
    public static List<Map<String, String>> parsingDataFromTargetOrg(String dataFromTargetOrg){
        List<Map<String, String>> data = new List<Map<String, String>>();
        Map<String, String> dataElement;
        Boolean flag = true;
        JSONParser parser = JSON.createParser(dataFromTargetOrg);
        while(parser.nextToken() != null){
            if(parser.getCurrentToken() == JSONToken.START_OBJECT) { dataElement = new Map<String, String>();
                                                                   flag = true;}                                   
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Id')){
                String key = parser.getText();
                parser.nextToken();
                String idValue = parser.getIdValue();
                dataElement.put(key, idValue);
            }
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Legacy_Job_Advertisement_Number__c')){
                String key = parser.getText();
                parser.nextToken();
                String legacyNumberValue = parser.getIdValue();
                dataElement.put(key, legacyNumberValue);
                System.debug('show me  map token: ' + dataElement);
            }
            if(parser.getCurrentToken() == JSONToken.END_OBJECT) {
                if(flag ==true){
                   data.add(dataElement);
                   flag = false; 
                }
            }
        }
        System.debug('show me list of maps: ' + data);
        return data;
    }
}