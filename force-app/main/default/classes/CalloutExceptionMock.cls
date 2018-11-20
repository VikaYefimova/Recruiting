@isTest
global class CalloutExceptionMock implements HttpCalloutMock{
    Integer flag = 0;
    global HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        if(request.getEndpoint().endsWith('oauth2/token')){
            system.debug('hello in get authorization');
            response.setStatusCode(200);
            response.setBody('{"access_token":"SESSION_ID_REMOVED","instance_url":"https://eu16.salesforce.com",' +
                             '"id":"https://login.salesforce.com/id/00D1t000000olmDEAQ/0051t000000KDQRAA4", ' + 
                             '"token_type":"Bearer","issued_at":"1539264655448","signature":"E1EOjxHhI84LDwMwi9okJlBKWNIAdZcoOdpd80NkgiU="}');
            return response;
        }
        if(request.getEndpoint().endsWith('apexrest/recordsCount')){
           	system.debug('hello in get count');
            response.setBody('[3,9,3]');
            return response;
        }
        if(request.getEndpoint().contains('from+CandidateCV__c+where+LastModifiedDate+=+YESTERDAY')){
            system.debug('helo in get candidates');
            response.setBody('{"totalSize":3,"done":true,"records":[{"attributes":{"type":"CandidateCV__c","url":"/services/data/v24.0/sobjects/CandidateCV__c/a011t000006pRBZAA2"},"Id":"a011t000006pRBZAA2","Name":"TestCv","Phone__c":"0668567810","Email__c":"testcv651996@gmail.com","Status__c":"Employed","Candidate_Age__c":45.0},{"attributes":{"type":"CandidateCV__c","url":"/services/data/v24.0/sobjects/CandidateCV__c/a011t000006pTq2AAE"},"Id":"a011t000006pTq2AAE","Name":"TestCV 66","Phone__c"'+
                             +':"0668567810","Email__c":"testcv661996@gmail.com","Status__c":"Unemployed","Candidate_Age__c":45.0},{"attributes":{"type":"CandidateCV__c","url":"/services/data/v24.0/sobjects/CandidateCV__c/a011t000006pTq7AAE"},"Id":"a011t000006pTq7AAE","Name":"testcv 67","Phone__c":"0668567810","Email__c":"testcv671996@gmail.com","Status__c":"Unemployed","Candidate_Age__c":12.0}]}');
            return response;
        }
        if(request.getEndpoint().contains('from+Selected_Job__c+where+LastModifiedDate+=+YESTERDAY')){
            system.debug('helo in job application');
            response.setBody('{"totalSize":9,"done":true,"records":[{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005LzjVAAS"},'+
                             +'"Id":"a021t000005LzjVAAS","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tCyFAAU"},'+
                             +'{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005M01bAAC"},"Id":"a021t000005M01bAAC","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Employed",'+
                             +'"Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPqzAAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005M0YkAAK"},"Id":"a021t000005M0YkAAK",'+
                             +'"CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"+380937205866","Candidate_Salary__c":"12","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":"test","Job_Advertisement__c":"a001t000001tCyFAAU"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005Nk2fAAC"},'+
                             +'"Id":"a021t000005Nk2fAAC","CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tCyFAAU"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005Nk2gAAC"},'+
                             +'"Id":"a021t000005Nk2gAAC","CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPqzAAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxmAAE"},'+
                             +'"Id":"a021t0000068LxmAAE","CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPqzAAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxnAAE"},'+
                             +'"Id":"a021t0000068LxnAAE","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPr9AAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxoAAE"},'+
                             +'"Id":"a021t0000068LxoAAE","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tCyFAAU"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxrAAE"},'+
                             +'"Id":"a021t0000068LxrAAE","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":"testtesttesttesttesttest","Job_Advertisement__c":"a001t000001tCyFAAU"}]}');
        	return response;
        }
        if(request.getEndpoint().endsWith('apexrest/getImages/0')){
            if(flag == 0){
                system.debug('helo in get images');
                flag++;
                CalloutException e = (CalloutException)CalloutException.class.newInstance();
                e.setMessage('System.CalloutException: Read timed out');
                throw e;
            }
            else{
                system.debug('helo in get images');
				response.setBody('[{"contentData":{"attributes":{"type":"ContentVersion","url":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4"},"Id":"0681t000000YYZGAA4","Title":"TestCv","VersionData":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4/VersionData","Candidate_Number__c":"a011t000006pRBZAA2","ContentBodyId":"05T1t000000VLgpEAG","FileType":"JPG"},"contentBody":"'+
                            +'dGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3'+
                             +'QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2U="},{"contentData":{"attributes":{"type":"ContentVersion","url":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4"},"Id":"0681t000000YYZGAA4","TestCV 66":"Dmitriy","VersionData":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4/VersionData","Candidate_Number__c":"a011t000006pTq2AAE","ContentBodyId":"05T1t000000VLgpEAG","FileType":"JPG"},"contentBody":"'+
                            +'dGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3'+
                             +'QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2U="},{"contentData":{"attributes":{"type":"ContentVersion","url":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4"},"Id":"0681t000000YYZGAA4","Title":"testcv 67","VersionData":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4/VersionData","Candidate_Number__c":"a011t000006pTq7AAE","ContentBodyId":"05T1t000000VLgpEAG","FileType":"JPG"},"contentBody":"'+
                            +'dGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3'+
                             +'QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2U="}]');
            }
        }
        return response;
    }
}