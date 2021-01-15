@IsTest

public with sharing class QuoteTriggerHandlerHelperTest {
@testSetup
    static void createMockOpportunity() {
        Account acc = [SELECT Id, Account_Currency__c, CurrencyIsoCode FROM Account LIMIT 1];
        DateTime todaysDate = System.today();
        String todaysDateStr = todaysDate.format('yyyy-MM-dd HH:mm:ss');

        Opportunity opp = new Opportunity(
         AccountId = acc.Id,
         CloseDate = Date.valueOf(todaysDateStr),
         Name = 'Mock Name of Op',
         Type = 'Pilot',
         StageName = 'Prospecting',
         ForecastCategoryName = 'Pipeline'
     );
    insert opp;

     Quote quo = new Quote(
        OpportunityId = opp.Id,
        Name = 'Mock Name of Quo'
        );
    insert quo;
    }
@IsTest

private static void testIsSyncedQuoteEqualsNull(){
Opportunity opp = [SELECT Id FROM Opportunity WHERE Name = 'Mock Name of Op' LIMIT 1];

Quote quo = [SELECT Id FROM Quote WHERE OpportunityId =: opp.Id LIMIT 1];

Test.startTest();
boolean isnull = QuoteTriggerHandlerHelper.isSyncedQuoteEqualsNull(quo);

Test.stopTest();
System.assertEquals(true, isnull);
}

}

