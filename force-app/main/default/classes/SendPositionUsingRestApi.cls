global class SendPositionUsingRestApi {
    String accesstoken_url='https://login.salesforce.com/services/oauth2/token';
    String authurl='https://login.salesforce.com/services/oauth2/authorize';
    
  public class deserializeResponse{
      public String id;
      public String access_token;   
   }
    public String ReturnAccessToken(SendPositionUsingRestApi pos){
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
    @future (callout=true)
    public static void createJobAdvertisement(id pos){
        SendPositionUsingRestApi pos1= new SendPositionUsingRestApi();
        String accessToken=pos1.ReturnAccessToken(pos1);
        HttpResponse response = createRecord(pos, accessToken);
        System.debug('create response: ' + response.getBody());
        //Map<String, String> legacyValue = parsingResponseBody(response.getBody());
        String legacyItem = parsingResponseBody(response.getBody());
        system.debug('id value: ' + legacyItem);
        changePositionLegacyNumber(legacyItem, pos);
        
    }
    @future (callout=true)
    public static void updateJobAdvertisement(id pos){
        SendPositionUsingRestApi sendPositionUsingRestApi = new SendPositionUsingRestApi();
            String accessToken = sendPositionUsingRestApi.ReturnAccessToken(sendPositionUsingRestApi);
            String dataFromTargetOrg = getDatafromTargetOrg(accessToken);
            HttpResponse response = updateRecord(pos, accessToken, dataFromTargetOrg);
            System.debug('update response: ' + response.getBody());
       		//Map<String, String> legacyValue = parsingResponseBody(response.getBody());
        	String legacyItem = parsingResponseBody(response.getBody());
        	system.debug('id value: ' + legacyItem);
            changePositionLegacyNumber(legacyItem, pos);
        	
    }
    @future (callout=true)
    public static void deleteJobAdvertisement(id pos){
        SendPositionUsingRestApi sendPositionUsingRestApi = new SendPositionUsingRestApi();
           String accessToken = sendPositionUsingRestApi.ReturnAccessToken(sendPositionUsingRestApi);
           String dataFromTargetOrg = getDatafromTargetOrg(accessToken);
           HttpResponse response = deleteRecord(pos, accessToken, dataFromTargetOrg); 
           System.debug('delete response: ' + response.getBody());
    }
    public static String getDatafromTargetOrg(String accessToken){
        String dataFromTargetOrg;
        if(accessToken != null){
            Http http= new Http();
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization','Bearer ' + accessToken);
            req.setHeader('Content-Type', 'application/json');
            req.setEndpoint('https://eu16.salesforce.com/services/apexrest/jobAdvertisements/');
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            dataFromTargetOrg = res.getBody();
            system.debug('get data response: ' + dataFromTargetOrg);
        }
        return dataFromTargetOrg;
    }
    public static HttpResponse createRecord(id pos, String accessToken){
        Position__c position = [select Name, Education__c, Location__c, Hiring_Manager__c, Legacy_Position_Number__c, Approval_Status__c, Status__c, Salary_Range__c, Skills_Required__c, Job_Description__c from Position__c where id =: pos];
        String jobAdvertisementsStatus = '';
        if(position.Status__c == 'Closed'){
            jobAdvertisementsStatus = 'Archived';
        }
        else if(position.Status__c == 'Open' && position.Approval_Status__c == 'Approved'){
            jobAdvertisementsStatus = 'Active';
        }
        User recruiterUser = [select Name, Email, Phone from User where id =: position.Hiring_Manager__c];
        List<Integer> salaries = getMinAndMaxSalary(position);
        if(accessToken!=null){
            String posId = position.Id;
            String endPoint='https://eu16.salesforce.com/services/apexrest/jobAdvertisements'; //Instance  Target Org 
			String jsonstr='{"name":"'+ position.Name + '", "location":"' + position.Location__c +'", "education":"' + position.Education__c +
    					'", "salary":"' + position.Salary_Range__c + '", "skills":"' + position.Skills_Required__c + '", "description":"' 
                        + position.Job_Description__c + '", "managerName":"' + recruiterUser.Name + '", "email":"' + recruiterUser.Email + 
                '", "phone":"' + recruiterUser.Phone +'", "legacyNumber":"' + position.id +
                '", "minSalary":"' + salaries[0] + '", "maxSalary":"' + salaries[1] + '", "status":"' + jobAdvertisementsStatus + '"}';
        
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setBody(jsonstr);
            req2.setMethod('POST');
            req2.setEndpoint(endPoint);
            HttpResponse res2;
            try{
                res2=h2.send(req2);
                deserializeResponse deresp2=(deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
                position.Posting_Status__c = 'Posted';
                position.Posting_Setting__c = 'Posted successfully';
            }
            catch(Exception e){
                position.Posting_Status__c = 'Not posted';
                position.Posting_Setting__c = 'Error posting';
            }
            update position;
            return res2;
        }
        return null;
    }
    public static HttpResponse updateRecord(id pos, String accessToken, String dataFromTargetOrg){
        List<Map<String, String>> data = parsingDataFromTargetOrg(dataFromTargetOrg);
        system.debug('hi');
        String jobAdvertisementsId;
        for(Map<String, String> item: data){
            if(item.get('Legacy_Job_Advertisement_Number__c') == pos){
                jobAdvertisementsId = item.get('Id');
                system.debug('id: ' + jobAdvertisementsId);
            }
        }
        Position__c position = [select Name, Education__c, Location__c, Hiring_Manager__c, Legacy_Position_Number__c, Approval_Status__c, Status__c, Salary_Range__c, Skills_Required__c, Job_Description__c from Position__c where id =: pos];
        String jobAdvertisementsStatus = '';
        if(position.Status__c == 'Closed'){
            jobAdvertisementsStatus = 'Archived';
        }
        else if(position.Status__c == 'Open' && position.Approval_Status__c == 'Approved'){
            jobAdvertisementsStatus = 'Active';
        }
        User recruiterUser = [select Name, Email, Phone from User where id =: position.Hiring_Manager__c];
        List<Integer> salaries = getMinAndMaxSalary(position);
        if(accessToken!=null){
            String posId = position.Id;
            String endPoint='https://eu16.salesforce.com/services/apexrest/jobAdvertisements/' + jobAdvertisementsId; //Instance  Target Org 
			String jsonstr='{"name":"'+ position.Name + '", "location":"' + position.Location__c +'", "education":"' + position.Education__c +
    					'", "salary":"' + position.Salary_Range__c + '", "skills":"' + position.Skills_Required__c + '", "description":"' 
                        + position.Job_Description__c + '", "managerName":"' + recruiterUser.Name + '", "email":"' + recruiterUser.Email + 
                '", "phone":"' + recruiterUser.Phone +'", "legacyNumber":"' + position.id +
                '", "minSalary":"' + salaries[0] + '", "maxSalary":"' + salaries[1] + '", "status":"' + jobAdvertisementsStatus + '"}';
            
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setBody(jsonstr);
            req2.setMethod('PUT');
            req2.setEndpoint(endPoint);
            HttpResponse res2;
            try{
                res2=h2.send(req2);
                deserializeResponse deresp2=(deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
                position.Posting_Setting__c = 'Update successfully';
            }
            catch(Exception e){
                position.Posting_Setting__c = 'Error updating';
                system.debug('except' + e);
            }
            update position;
            return res2;
        }
        return null;
    }
    public static HttpResponse deleteRecord(id pos, String accessToken, String dataFromTargetOrg){
        Position__c position = [select Name, Education__c, Location__c, Hiring_Manager__c, Legacy_Position_Number__c, Salary_Range__c, Skills_Required__c, Job_Description__c from Position__c where id =: pos];
        List<Map<String, String>> data = parsingDataFromTargetOrg(dataFromTargetOrg);
        String jobAdvertisementsId;
        for(Map<String, String> item: data){
            if(item.get('Legacy_Job_Advertisement_Number__c') == pos){
                jobAdvertisementsId = item.get('Id');
            }
        }
        if(accessToken != null){
            String endPoint='https://eu16.salesforce.com/services/apexrest/jobAdvertisements/' + jobAdvertisementsId;
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setMethod('DELETE');
            req2.setEndpoint(endPoint);
            HttpResponse res2;
            try{
                res2=h2.send(req2);
                position.Posting_Setting__c = 'Delete successfully';
                position.Posting_Status__c = '';
            }
            catch(Exception e){
                position.Posting_Setting__c = 'Error deleting';
            }
            update position;
            return res2;
        }
        return null;
    }
    public static List<Map<String, String>> parsingDataFromTargetOrg(String dataFromTargetOrg){
        system.debug('hello');
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
            }
            if(parser.getCurrentToken() == JSONToken.END_OBJECT) {
                if(flag ==true){
                   data.add(dataElement);
                   flag = false; 
                }
            }
        }
        system.debug('data: ' + data);
        return data;
        
    }
    public static String parsingResponseBody(String responseBody){
        String legacyNumber = '';
        JSONParser parser = JSON.createParser(responseBody);
        while(parser.nextToken() != null){
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME && (parser.getText() == 'Id')){
                String key = parser.getText();
                parser.nextToken();
                legacyNumber = parser.getIdValue();
                //legacyNumber.put(key, idValue);
            }
        }
        system.debug('id value: ' + legacyNumber);
        return legacyNumber;
    }
    public static void changePositionLegacyNumber(String legacyValue, id pos){
        Position__c currentPosition = [select id from Position__c where id =: pos];
        currentPosition.Legacy_Position_Number__c = legacyValue;
        
        try{
            update currentPosition; 
            system.debug('current position : ' + currentPosition);
        }
        catch(DMLException e){
            system.debug('error: ' + e);
        }
    }
    public static List<Integer> getMinAndMaxSalary(Position__c currentPosition){
        List<Integer> integerSalaries = new List<Integer>();
        List<String> salaries = new List<String>();
        String salaryRange = currentPosition.Salary_Range__c;
        String maxSalary = '';
        String minSalary = '';
        if(salaryRange == null){
            integerSalaries.add(0);
            integerSalaries.add(0);
        }
        else if(salaryRange.contains('-')){
            salaries = salaryRange.split('-');
            string oneSalary ='';
            for(String salary: salaries){
                oneSalary = salary.remove('K');
                Integer integerSalary = integer.valueOf(oneSalary);
                integerSalaries.add(integerSalary);
            }
        }
        else if(salaryRange.contains('+')){
            salaries.add(salaryRange);
            salaries.add('');
            string oneSalary ='';
            for(integer i =0; i< salaries.size(); i++){
                oneSalary = salaries[0].removeEnd('K+');
                integer salary = integer.valueOf(oneSalary);
                integerSalaries.add(salary);
            }
        }
        return integerSalaries;
    }
}