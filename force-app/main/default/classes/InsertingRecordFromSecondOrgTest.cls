@isTest
public class InsertingRecordFromSecondOrgTest {
	@isTest
    public static void returnAccessTokenTest(){
        List_Setting__c testCustomSetting = new List_Setting__c();
        testCustomSetting.Client_Secret__c = '6062214781788623861';
        testCustomSetting.Consumer_Secret__c = '3MVG9fTLmJ60pJ5I9d8FcNmhnOyWg4QBXzptmhuhTNPXtWTsLGzeihB6UX.YrwAW6wOsB2SpHWM8AeoR8FUyz	';
        testCustomSetting.Login_c__c = 'vikaephimova1996@mycomp.com';
        testCustomSetting.Password__c = 'Hibd2014';
        testCustomSetting.Link_to_connected_org__c = 'https://eu16.salesforce.com/';
        insert testCustomSetting;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InsertingRecordFromSecondOrgMock());
        InsertingRecordFromSecondOrg insertingRecordFromSecondOrg = new InsertingRecordFromSecondOrg();
        String accessToken = insertingRecordFromSecondOrg.ReturnAccessToken(insertingRecordFromSecondOrg);
        String expectedValue = 'SESSION_ID_REMOVED';
        System.assertEquals(1, Limits.getCallouts());
        system.assertEquals(expectedValue, accessToken);
        Test.stopTest();
    }
    @isTest
    public static void getCountfromTargetOrgTest(){
        List_Setting__c testCustomSetting = new List_Setting__c();
        testCustomSetting.Client_Secret__c = '6062214781788623861';
        testCustomSetting.Consumer_Secret__c = '3MVG9fTLmJ60pJ5I9d8FcNmhnOyWg4QBXzptmhuhTNPXtWTsLGzeihB6UX.YrwAW6wOsB2SpHWM8AeoR8FUyz	';
        testCustomSetting.Login_c__c = 'vikaephimova1996@mycomp.com';
        testCustomSetting.Password__c = 'Hibd2014';
        testCustomSetting.Link_to_connected_org__c = 'https://eu16.salesforce.com/';
        insert testCustomSetting;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InsertingRecordFromSecondOrgMock());
        InsertingRecordFromSecondOrg insertingRecord = new InsertingRecordFromSecondOrg();
        String accessToken = insertingRecord.ReturnAccessToken(insertingRecord);
        String responseBody = InsertingRecordFromSecondOrg.getCountfromTargetOrg(accessToken);
        String expectedValue = '[3,9,3]';
        system.assertEquals(expectedValue, responseBody);
    }
    @isTest
    public static void getCVDataFromSecondOrgTest(){
        List_Setting__c testCustomSetting = new List_Setting__c();
        testCustomSetting.Client_Secret__c = '6062214781788623861';
        testCustomSetting.Consumer_Secret__c = '3MVG9fTLmJ60pJ5I9d8FcNmhnOyWg4QBXzptmhuhTNPXtWTsLGzeihB6UX.YrwAW6wOsB2SpHWM8AeoR8FUyz	';
        testCustomSetting.Login_c__c = 'vikaephimova1996@mycomp.com';
        testCustomSetting.Password__c = 'Hibd2014';
        testCustomSetting.Link_to_connected_org__c = 'https://eu16.salesforce.com/';
        insert testCustomSetting;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InsertingRecordFromSecondOrgMock());
        InsertingRecordFromSecondOrg insertingRecord = new InsertingRecordFromSecondOrg();
        String accessToken = insertingRecord.ReturnAccessToken(insertingRecord);
        String responseBody = InsertingRecordFromSecondOrg.getCVDataFromSecondOrg(100, 0);
        String expectedValue = '{"totalSize":3,"done":true,"records":[{"attributes":{"type":"CandidateCV__c","url":"/services/data/v24.0/sobjects/CandidateCV__c/a011t000006pRBZAA2"},"Id":"a011t000006pRBZAA2","Name":"TestCv","Phone__c":"0668567810","Email__c":"testcv651996@gmail.com","Status__c":"Employed","Candidate_Age__c":45.0},{"attributes":{"type":"CandidateCV__c","url":"/services/data/v24.0/sobjects/CandidateCV__c/a011t000006pTq2AAE"},"Id":"a011t000006pTq2AAE","Name":"TestCV 66","Phone__c"'+
                             +':"0668567810","Email__c":"testcv661996@gmail.com","Status__c":"Unemployed","Candidate_Age__c":45.0},{"attributes":{"type":"CandidateCV__c","url":"/services/data/v24.0/sobjects/CandidateCV__c/a011t000006pTq7AAE"},"Id":"a011t000006pTq7AAE","Name":"testcv 67","Phone__c":"0668567810","Email__c":"testcv671996@gmail.com","Status__c":"Unemployed","Candidate_Age__c":12.0}]}';
        system.assertEquals(expectedValue, responseBody);
    }
    @isTest
    public static void getJobApplicationDataFromSecondOrgTest(){
        List_Setting__c testCustomSetting = new List_Setting__c();
        testCustomSetting.Client_Secret__c = '6062214781788623861';
        testCustomSetting.Consumer_Secret__c = '3MVG9fTLmJ60pJ5I9d8FcNmhnOyWg4QBXzptmhuhTNPXtWTsLGzeihB6UX.YrwAW6wOsB2SpHWM8AeoR8FUyz	';
        testCustomSetting.Login_c__c = 'vikaephimova1996@mycomp.com';
        testCustomSetting.Password__c = 'Hibd2014';
        testCustomSetting.Link_to_connected_org__c = 'https://eu16.salesforce.com/';
        insert testCustomSetting;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InsertingRecordFromSecondOrgMock());
        InsertingRecordFromSecondOrg insertingRecord = new InsertingRecordFromSecondOrg();
        String accessToken = insertingRecord.ReturnAccessToken(insertingRecord);
        String responseBody = InsertingRecordFromSecondOrg.getJobApplicationDataFromSecondOrg(100, 0);
        String expectedValue = '{"totalSize":9,"done":true,"records":[{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005LzjVAAS"},'+
                             +'"Id":"a021t000005LzjVAAS","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tCyFAAU"},'+
                             +'{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005M01bAAC"},"Id":"a021t000005M01bAAC","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Employed",'+
                             +'"Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPqzAAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005M0YkAAK"},"Id":"a021t000005M0YkAAK",'+
                             +'"CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"+380937205866","Candidate_Salary__c":"12","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":"test","Job_Advertisement__c":"a001t000001tCyFAAU"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005Nk2fAAC"},'+
                             +'"Id":"a021t000005Nk2fAAC","CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tCyFAAU"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005Nk2gAAC"},'+
                             +'"Id":"a021t000005Nk2gAAC","CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPqzAAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxmAAE"},'+
                             +'"Id":"a021t0000068LxmAAE","CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPqzAAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxnAAE"},'+
                             +'"Id":"a021t0000068LxnAAE","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPr9AAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxoAAE"},'+
                             +'"Id":"a021t0000068LxoAAE","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tCyFAAU"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxrAAE"},'+
                             +'"Id":"a021t0000068LxrAAE","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":"testtesttesttesttesttest","Job_Advertisement__c":"a001t000001tCyFAAU"}]}';
    	system.assertEquals(expectedValue, responseBody);
    }
    @isTest
    public static void getCandidateImagesFromTargetOrgTest(){
        List_Setting__c testCustomSetting = new List_Setting__c();
        testCustomSetting.Client_Secret__c = '6062214781788623861';
        testCustomSetting.Consumer_Secret__c = '3MVG9fTLmJ60pJ5I9d8FcNmhnOyWg4QBXzptmhuhTNPXtWTsLGzeihB6UX.YrwAW6wOsB2SpHWM8AeoR8FUyz	';
        testCustomSetting.Login_c__c = 'vikaephimova1996@mycomp.com';
        testCustomSetting.Password__c = 'Hibd2014';
        testCustomSetting.Link_to_connected_org__c = 'https://eu16.salesforce.com/';
        insert testCustomSetting;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InsertingRecordFromSecondOrgMock());
        InsertingRecordFromSecondOrg insertingRecord = new InsertingRecordFromSecondOrg();
        String accessToken = insertingRecord.ReturnAccessToken(insertingRecord);
        String responseBody = InsertingRecordFromSecondOrg.getCandidateImagesFromTargetOrg(70, 0);
        String expectedValue = '[{"contentData":{"attributes":{"type":"ContentVersion","url":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4"},"Id":"0681t000000YYZGAA4","Title":"TestCv","VersionData":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4/VersionData","Candidate_Number__c":"a011t000006pRBZAA2","ContentBodyId":"05T1t000000VLgpEAG","FileType":"JPG"},"contentBody":"'+
                            +'dGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3'+
                             +'QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2U="},{"contentData":{"attributes":{"type":"ContentVersion","url":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4"},"Id":"0681t000000YYZGAA4","TestCV 66":"Dmitriy","VersionData":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4/VersionData","Candidate_Number__c":"a011t000006pTq2AAE","ContentBodyId":"05T1t000000VLgpEAG","FileType":"JPG"},"contentBody":"'+
                            +'dGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3'+
                             +'QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2U="},{"contentData":{"attributes":{"type":"ContentVersion","url":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4"},"Id":"0681t000000YYZGAA4","Title":"testcv 67","VersionData":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4/VersionData","Candidate_Number__c":"a011t000006pTq7AAE","ContentBodyId":"05T1t000000VLgpEAG","FileType":"JPG"},"contentBody":"'+
                            +'dGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3'+
                             +'QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2U="}]';
        system.assertEquals(expectedValue, responseBody);
    }
    @isTest
    public static void parsingCandidateRecordsTest(){
        String response = '{"totalSize":3,"done":true,"records":[{"attributes":{"type":"CandidateCV__c","url":"/services/data/v24.0/sobjects/CandidateCV__c/a011t000006pRBZAA2"},"Id":"a011t000006pRBZAA2","Name":"TestCv","Phone__c":"0668567810","Email__c":"testcv651996@gmail.com","Status__c":"Employed","Candidate_Age__c":45.0},{"attributes":{"type":"CandidateCV__c","url":"/services/data/v24.0/sobjects/CandidateCV__c/a011t000006pTq2AAE"},"Id":"a011t000006pTq2AAE","Name":"TestCV 66","Phone__c"'+
                             +':"0668567810","Email__c":"testcv661996@gmail.com","Status__c":"Unemployed","Candidate_Age__c":45.0},{"attributes":{"type":"CandidateCV__c","url":"/services/data/v24.0/sobjects/CandidateCV__c/a011t000006pTq7AAE"},"Id":"a011t000006pTq7AAE","Name":"testcv 67","Phone__c":"0668567810","Email__c":"testcv671996@gmail.com","Status__c":"Unemployed","Candidate_Age__c":12.0}]}';
        List<Candidate__c> candidates = InsertingRecordFromSecondOrg.parsingCandidateRecords(response);
        system.assertEquals(3, candidates.size());
    }
    @isTest
    public static void parsingJobAppliationsRecordsTest(){
        List<Position__c> positions = new List<Position__c>();
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US', Legacy_Position_Number__c = 'a001t000001tPr9AAE');
        Position__c pos2 = new Position__c(Name = 'Test2', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US', Legacy_Position_Number__c = 'a001t000001tCyFAAU');
        Position__c pos3 = new Position__c(Name = 'Test3', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US', Legacy_Position_Number__c = 'a001t000001tPqzAAE');
        positions.add(pos);
        positions.add(pos2);
        positions.add(pos3);
        insert positions;
        List<Candidate__c> candidates = new List<Candidate__c>();
        Candidate__c candidate = new Candidate__c(Legacy_Candidate_Number__c = 'a011t000006pTq2AAE', First_Name__c = 'Test', Last_Name__c = 'cv1');
        Candidate__c candidate2 = new Candidate__c(Legacy_Candidate_Number__c = 'a011t000006pRBZAA2', First_Name__c = 'Test', Last_Name__c = 'cv2');
        candidates.add(candidate);
        candidates.add(candidate2);
        insert candidates;
        String response = '{"totalSize":9,"done":true,"records":[{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005LzjVAAS"},'+
                             +'"Id":"a021t000005LzjVAAS","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tCyFAAU"},'+
                             +'{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005M01bAAC"},"Id":"a021t000005M01bAAC","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Employed",'+
                             +'"Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPqzAAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005M0YkAAK"},"Id":"a021t000005M0YkAAK",'+
                             +'"CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"+380937205866","Candidate_Salary__c":"12","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":"test","Job_Advertisement__c":"a001t000001tCyFAAU"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005Nk2fAAC"},'+
                             +'"Id":"a021t000005Nk2fAAC","CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tCyFAAU"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t000005Nk2gAAC"},'+
                             +'"Id":"a021t000005Nk2gAAC","CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":12.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPqzAAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxmAAE"},'+
                             +'"Id":"a021t0000068LxmAAE","CandidateCV__c":"a011t000006pTq2AAE","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPqzAAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxnAAE"},'+
                             +'"Id":"a021t0000068LxnAAE","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tPr9AAE"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxoAAE"},'+
                             +'"Id":"a021t0000068LxoAAE","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":null,"Job_Advertisement__c":"a001t000001tCyFAAU"},{"attributes":{"type":"Selected_Job__c","url":"/services/data/v24.0/sobjects/Selected_Job__c/a021t0000068LxrAAE"},'+
                             +'"Id":"a021t0000068LxrAAE","CandidateCV__c":"a011t000006pRBZAA2","Candidate_Phone__c":"0668567810","Candidate_Salary__c":"546","Candidate_Status__c":"Unemployed","Candidate_Age__c":45.0,"Additional_Info__c":"testtesttesttesttesttest","Job_Advertisement__c":"a001t000001tCyFAAU"}]}';
        List<Job_Application__c> jobApplications = InsertingRecordFromSecondOrg.parsingJobAppliationsRecords(response);
        system.assertEquals(9, jobApplications.size());
    }
    @isTest
    public static void parsingCandidateImagesDataTest(){
        List<Candidate__c> candidates = new List<Candidate__c>();
        Candidate__c candidate = new Candidate__c(Legacy_Candidate_Number__c = 'a011t000006pTq2AAE', First_Name__c = 'Test', Last_Name__c = 'cv1');
        Candidate__c candidate2 = new Candidate__c(Legacy_Candidate_Number__c = 'a011t000006pRBZAA2', First_Name__c = 'Test', Last_Name__c = 'cv2');
        Candidate__c candidate3 = new Candidate__c(Legacy_Candidate_Number__c = 'a011t000006pTq7AAE', First_Name__c = 'Test', Last_Name__c = 'cv3');
        candidates.add(candidate);
        candidates.add(candidate2);
        candidates.add(candidate3);
        insert candidates;
        String response = '[{"contentData":{"attributes":{"type":"ContentVersion","url":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4"},"Id":"0681t000000YYZGAA4","Title":"TestCv","VersionData":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4/VersionData","Candidate_Number__c":"a011t000006pRBZAA2","ContentBodyId":"05T1t000000VLgpEAG","FileType":"JPG"},"contentBody":"'+
                            +'dGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3'+
                             +'QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2U="},{"contentData":{"attributes":{"type":"ContentVersion","url":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4"},"Id":"0681t000000YYZGAA4","TestCV 66":"Dmitriy","VersionData":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4/VersionData","Candidate_Number__c":"a011t000006pTq2AAE","ContentBodyId":"05T1t000000VLgpEAG","FileType":"JPG"},"contentBody":"'+
                            +'dGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3'+
                             +'QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2U="},{"contentData":{"attributes":{"type":"ContentVersion","url":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4"},"Id":"0681t000000YYZGAA4","Title":"testcv 67","VersionData":"/services/data/v44.0/sobjects/ContentVersion/0681t000000YYZGAA4/VersionData","Candidate_Number__c":"a011t000006pTq7AAE","ContentBodyId":"05T1t000000VLgpEAG","FileType":"JPG"},"contentBody":"'+
                            +'dGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2V0ZXN0IHRvIGluc2VydCBpbWFnZXRlc3'+
                             +'QgdG8gaW5zZXJ0IGltYWdldGVzdCB0byBpbnNlcnQgaW1hZ2U="}]';
        Set<ContentVersion> files = InsertingRecordFromSecondOrg.parsingCandidateImagesData(response);
        system.assertEquals(3, files.size());
    }
}