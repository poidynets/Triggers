@IsTest
private class QuoteTriggerHandlerHelperTest {
   private static Quote createMockQuote(boolean isNull, string recordName) {
    Account acc = new Account(
        
      Name = recordName
      );
System.Debug('Account Name: ' + acc.Name + ' Random String: ' + recordName);
insert acc;
System.Debug('acc Id: ' + acc.Id + ' random String: ' + recordName);

        DateTime todaysDate = System.today();
        String todaysDateStr = todaysDate.format('yyyy-MM-dd HH:mm:ss');
        
               
        String oppName = 'Mock Name of Op' + recordName;
        Opportunity opp = new Opportunity(
        AccountId = acc.Id,
        CloseDate = Date.valueOf(todaysDateStr),
        Name = oppName,
        Type = 'Pilot',
        StageName = 'Proposal',
        ForecastCategoryName = 'Pipeline'
    );
    insert opp;

     Quote quo = new Quote(
      Name = 'Mock Name of Quo',
        OpportunityId = opp.Id,
        BillingStreet = '123b Baker St.',
        BillingCity = 'London',
         BillingState = 'England',
         BillingPostalCode='343234',
         ShippingStreet = '123b Baker St.',
         ShippingCity = 'London',
         ShippingState = 'England',
         ShippingPostalCode='343234'
        );
    insert quo;

    if (!isNull && recordName == ' ForNotNull'){
      opp.SyncedQuoteId = quo.id;
      upsert opp;
    }
    if (recordName == ' Updated Quote Synced With Opportunity'){
      opp.SyncedQuoteId = quo.id;
      upsert opp;
    }
   return quo;
   }

@IsTest
private static void testIsSyncedQuoteEqualsNull(){


Test.startTest();
Quote quoForNull = createMockQuote(true, ' ForNull');

boolean isNull = QuoteTriggerHandlerHelper.isSyncedQuoteEqualsNull(quoForNull);

Quote quoForNotNull = createMockQuote(false, ' ForNotNull');

boolean isNotNull = QuoteTriggerHandlerHelper.isSyncedQuoteEqualsNull(quoForNotNull);

Quote quoSyncedWithOpp = createMockQuote(true, ' Updated Quote Synced With Opportunity');

boolean isSyncedWithOpp = QuoteTriggerHandlerHelper.isUpdatedQuoteSyncedWithOpportunity(quoSyncedWithOpp);


Test.stopTest();
System.assertEquals(true, isNull);
System.assertEquals(false, isNotNull);
System.assertEquals(false, isSyncedWithOpp);

}

}




// @IsTest
// private class QuoteTriggerHandlerHelperTest {
// @testSetup
//    static void createMockOpportunity() {
//       Account acc = new Account(
//       Name = 'Mock Name of Acc',
//       fferpcore__ValidatedBillingCity__c = 'Test City'
// );
// insert acc;

//         DateTime todaysDate = System.today();
//         String todaysDateStr = todaysDate.format('yyyy-MM-dd HH:mm:ss');

//         Opportunity opp = new Opportunity(
//         AccountId = acc.Id,
//         CloseDate = Date.valueOf(todaysDateStr),
//         Name = 'Mock Name of Op',
//         Type = 'Pilot',
//         StageName = 'Proposal',
//         ForecastCategoryName = 'Pipeline'
//     );
//     insert opp;

//      Quote quo = new Quote(
//       Name = 'Mock Name of Quo',
//         OpportunityId = opp.Id,
//         BillingStreet = '123b Baker St.',
//         BillingCity = 'London',
//          BillingState = 'England',
//          BillingPostalCode='343234',
//          ShippingStreet = '123b Baker St.',
//          ShippingCity = 'London',
//          ShippingState = 'England',
//          ShippingPostalCode='343234'
//         );
//     insert quo;

//     System.Debug('quo.Id +' + quo.Id);

//     String nameOfQ = 'Mock Name of Quo';
//    List<Quote> quos = [SELECT Id FROM Quote WHERE Name =:nameOfQ LIMIT 1];
//    System.Debug('Debug 2' + quos);
//    }

// @IsTest
// private static void testIsSyncedQuoteEqualsNull(){
// System.Debug('Debug 0');

// System.Debug('Debug 1');



// Test.startTest();

// List<Quote> quos = [SELECT Id FROM Quote WHERE Name = 'Mock Name of Quo' LIMIT 1];

// boolean isnull = QuoteTriggerHandlerHelper.isSyncedQuoteEqualsNull(quos[0]);
// System.Debug ('  test String');

// Test.stopTest();
// System.assertEquals(true, isnull);

// }

// }

