@isTest
global class SendCaloutsMock implements HttpCalloutMock{
    String currentPositionId;
    global SendCaloutsMock(id positionId){
        this.currentPositionId = positionId;
    }
    
    global HTTPResponse respond(HTTPRequest request){
        
        
        System.assertEquals('https://eu16.salesforce.com/services/oauth2/token', request.getEndpoint());
        System.assertEquals('POST', request.getMethod());
        System.assertEquals('https://eu16.salesforce.com/services/apexrest/jobAdvertisements/', request.getEndpoint());
        System.assertEquals('GET', request.getMethod());
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"attributes":{"type":"Job_Advertisement__c","url":"/services/data/v43.0/sobjects/Job_Advertisement__c/a001t000001sKeXAAU"},"Name":"hibd","Description__c":"null","Education__c":"null","Email__c":"vikaephimova1996@gmail.com","Legacy_Job_Advertisement_Number__c":"' + currentPositionId + '","Location__c":"null","Manager_name__c":"Kathy Cooper","Phone__c":"380958645755","Salary__c":"75K-90K","Skills_Required__c":"null","Status__c":"Active","Id":"a001t000001sKeXAAU"}');
        response.setStatusCode(200);
        return response;
    }
}