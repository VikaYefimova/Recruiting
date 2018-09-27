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
        Position__c position = [select Name, Education__c, Location__c, Hiring_Manager__c, Legacy_Position_Number__c from Position__c where id =: pos];
        User recruiterUser = [select Name, Email, Phone from User where id =: position.Hiring_Manager__c];
        SendPositionUsingRestApi pos1= new SendPositionUsingRestApi();
        String accessToken=pos1.ReturnAccessToken(pos1);
        System.debug(accessToken+'###0012');
        if(accessToken!=null){
            String posId = position.Id;
            String endPoint='https://eu16.salesforce.com/services/data/v32.0/sobjects/Job_Advertisement__c'; //Instance  Target Org
           // String endPoint='https://eu16.salesforce.com/services/data/v32.0/sobjects/Job_Advertisement__c/Legacy_Job_Advertisement_Number__c/' + posId + '?_HttpMethod=PATCH'; 
String jsonstr='{"Name":"'+ position.Name + '", "Location__c":"' + position.Location__c +'", "Education__c":"' + position.Education__c +
    '", "Manager_name__c":"' + recruiterUser.Name + '", "Legacy_Job_Advertisement_Number__c":"' + position.id + '", "Status__c":"Active"}';
            
           /* JSONGenerator gen = JSON.createGenerator(true);    
	        gen.writeStartObject();      
	        gen.writeStringField('Name ', position.Name);
	        gen.writeStringField('Location__c', position.Location__c);
	        gen.writeStringField('Education__c', position.Education__c);
            gen.writeStringField('Manager_name__c', recruiterUser.Name);
            gen.writeStringField('Legacy_Job_Advertisement_Number__c', position.id);
            gen.writeStringField('Status__c', 'Active');
	        gen.writeEndObject();    
	        String jsonstr = gen.getAsString();*/
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
            System.debug('###1203createdeser'+deresp2);
        }
    }
    @future(callout=true)
    public static void updateJobAdvertisement(id pos){
        Position__c position = [select Name, Education__c, Location__c, Hiring_Manager__c, Legacy_Position_Number__c from Position__c where id =: pos];
        User recruiterUser = [select Name, Email, Phone from User where id =: position.Hiring_Manager__c];
        SendPositionUsingRestApi pos1= new SendPositionUsingRestApi();
        String accessToken=pos1.ReturnAccessToken(pos1);
        System.debug('show me access token: ' + accessToken+'###0012');
        if(accessToken!=null){
            Http ht = new Http();
            HttpRequest req = new HttpRequest();
            /*JSONGenerator gen = JSON.createGenerator(true);    
	        gen.writeStartObject();      
	        gen.writeStringField('Name ', position.Name);
	        gen.writeStringField('Location__c', position.Location__c);
	        gen.writeStringField('Education__c', position.Education__c);
            gen.writeStringField('Manager_name__c', recruiterUser.Name);
            gen.writeStringField('Legacy_Job_Advertisement_Number__c', position.id);
            gen.writeStringField('Status__c', 'Active');
	        gen.writeEndObject();    
	        String jsonstr = gen.getAsString();*/
            //String jsonstr='{"Name":"'+ position.Name + '", "Location__c":"' + position.Location__c + '", "Education__c":"' + position.Education__c + '", "Manager_name__c":"' + recruiterUser.Name+ '", "Legacy_Job_Advertisement_Number__c":"' + position.id + '", "Status__c":"Active"}';
            //req.setEndpoint('https://eu16.salesforce.com/services/data/v20.0/query/?q=SELECT+name+,+Legacy_Job_Advertisement_Number__c+from+Job_Advertisement__c');
            String endPoint='https://eu16.salesforce.com/services/data/v20.0/sobjects/Job_Advertisement__c/Legacy_Job_Advertisement_Number__c/'+position.id+'?_HttpMethod=PATCH'; //Instance  Target Org 
            String jsonstr='{"Name":"'+ position.Name + '", "Location__c":"' + position.Location__c + '", "Education__c":"' + position.Education__c +
                '", "Manager_name__c":"' + recruiterUser.Name+ '", "Legacy_Job_Advertisement_Number__c":"' + position.id + '", "Status__c":"Active"}';
            req.setHeader('Authorization','Bearer ' + accessToken);
            req.setHeader('Content-Type','application/json');
            req.setHeader('accept','application/json');
            req.setEndpoint(endPoint);
            req.setBody(jsonstr);
            req.setMethod('POST');
            HttpResponse res = ht.send(req);
            System.debug('show me response body: ' + res.getBody());
            System.debug('show me request body: ' + req.getBody());
            deserializeResponse deresp2=(deserializeResponse)System.JSON.deserialize(res.getBody(),deserializeResponse.class);
        }
    }
    
}