@IsTest
private class QuoteTriggerHandlerHelperTest {
   private static Quote createMockQuote(boolean isNull, string recordName) {
      Account acc = new Account(
        
      Name = recordName
      );
insert acc;

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
    if (recordName == ' Synced Quote is in Accepted Status'){
      opp.SyncedQuoteId = quo.id;
      quo.Status = 'Accepted';
      upsert opp;
      upsert quo;
    }
    if (recordName == ' NOT in Acc, but in other - Draft'){
      opp.SyncedQuoteId = quo.id;
      quo.Status = 'Draft';
      upsert opp;
      upsert quo;
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
boolean isNotSyncedWithOpp = QuoteTriggerHandlerHelper.isUpdatedQuoteSyncedWithOpportunity(quoForNull);

Quote quoIsInAccepted = createMockQuote(true, ' Synced Quote is in Accepted Status');
boolean isInAcceptedStatus = QuoteTriggerHandlerHelper.isSyncedQuoteInAccepted(quoIsInAccepted);

Quote quoIsNotInAccepted = createMockQuote(true, ' NOT in Acc, but in other - Draft');
boolean isNotInAcceptedStatus = QuoteTriggerHandlerHelper.isSyncedQuoteInAccepted(quoIsNotInAccepted);

Test.stopTest();
System.assertEquals(true, isNull);
System.assertEquals(false, isNotNull);
System.assertEquals(true, isSyncedWithOpp);
System.assertEquals(false, isNotSyncedWithOpp);
System.assertEquals(true, isInAcceptedStatus);
System.assertEquals(false, isNotInAcceptedStatus);

}

}