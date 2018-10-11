@isTest
global class SendCaloutsMock implements HttpCalloutMock{
    String currentPositionId;
    global SendCaloutsMock(id positionId){
        this.currentPositionId = positionId;
    }
    global HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        String endpoint = 'apexrest/jobAdvertisements/' + currentPositionId;
        if(request.getEndpoint().endsWith('oauth2/token')){
            response.setStatusCode(200);
            response.setBody('{"access_token":"SESSION_ID_REMOVED","instance_url":"https://eu16.salesforce.com",' +
                             '"id":"https://login.salesforce.com/id/00D1t000000olmDEAQ/0051t000000KDQRAA4", ' + 
                             '"token_type":"Bearer","issued_at":"1539264655448","signature":"E1EOjxHhI84LDwMwi9okJlBKWNIAdZcoOdpd80NkgiU="}');
            return response;
        }
        else if(request.getEndpoint().endsWith(endpoint)){
            response.setHeader('Content-Type', 'application/json');
            
            response.setBody('{"attributes":{"type":"Job_Advertisement__c", ' + 
                             '"url":"/services/data/v43.0/sobjects/Job_Advertisement__c/a001t000001sbT5AAI"},"Name":"hibd","Description__c":"null", ' + 
                             '"Education__c":"null","Email__c":"vikaephimova1996@gmail.com","Legacy_Job_Advertisement_Number__c":"' + currentPositionId +'", ' + 
                             '"Location__c":"APAC","Manager_name__c":"Kathy Cooper","Maximum_Salary__c":120,"Minimum_Salary__c":90,"Phone__c":"380958645755", ' + 
                             '"Salary__c":"90K-120K","Skills_Required__c":"skills","Status__c":"Active","Id":"a001t000001sbT5AAI"}');
            response.setStatusCode(200);
            return response;
        }
        else if(request.getEndpoint().endsWith('apexrest/jobAdvertisements/')  && request.getMethod() == 'GET'){
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"attributes":{"type":"Job_Advertisement__c", ' + 
                             '"url":"/services/data/v43.0/sobjects/Job_Advertisement__c/a001t000001sbT5AAI"},"Name":"hibd","Description__c":"null", ' + 
                             '"Education__c":"null","Email__c":"vikaephimova1996@gmail.com","Legacy_Job_Advertisement_Number__c":"' + currentPositionId +'", ' + 
                             '"Location__c":"APAC","Manager_name__c":"Kathy Cooper","Maximum_Salary__c":120,"Minimum_Salary__c":90,"Phone__c":"380958645755", ' + 
                             '"Salary__c":"90K-120K","Skills_Required__c":"skills","Status__c":"Active","Id":"a001t000001sbT5AAI"}');
            return response;   
        }
        else{
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"attributes":{"type":"Job_Advertisement__c", ' + 
                             '"url":"/services/data/v43.0/sobjects/Job_Advertisement__c/a001t000001sbT5AAI"},"Name":"hibd","Description__c":"null", ' + 
                             '"Education__c":"null","Email__c":"vikaephimova1996@gmail.com","Legacy_Job_Advertisement_Number__c":"' + currentPositionId +'", ' + 
                             '"Location__c":"APAC","Manager_name__c":"Kathy Cooper","Maximum_Salary__c":120,"Minimum_Salary__c":90,"Phone__c":"380958645755", ' + 
                             '"Salary__c":"90K-120K","Skills_Required__c":"skills","Status__c":"Active","Id":"a001t000001sbT5AAI"}');
            response.setStatusCode(200);
            return response;
        }
        //return null;
    }
}