public with sharing class QuoteTriggerHandlerHelper {
    public static Boolean isSyncedQuoteEqualsNull (Quote newQuote){
       
        Opportunity SyncedQuoteValue = [SELECT SyncedQuoteId 
FROM Opportunity 
WHERE id IN (SELECT OpportunityId FROM Quote WHERE id=: newQuote.id)];
if (SyncedQuoteValue.SyncedQuoteId==null){
    return true;
            }
            return false;
       }
    public static Boolean isUpdatedQuoteSyncedWithOpportunity (Quote newQuote){
       
        Opportunity SyncedQuoteComparison = [SELECT SyncedQuoteId 
FROM Opportunity 
WHERE id IN (SELECT OpportunityId FROM Quote WHERE id=: newQuote.id)];
if (newQuote.id==SyncedQuoteComparison.SyncedQuoteId){
    return true;
}
return false;
       }
    public static Boolean isSyncedQuoteInAccepted (Quote newQuote){

        Opportunity SyncedQuoteIds = [SELECT SyncedQuoteId 
FROM Opportunity 
WHERE id IN (SELECT OpportunityId FROM Quote WHERE id=: newQuote.id)];

Quote SyncedQuoteStatus = [SELECT Status 
FROM Quote 
WHERE id =: SyncedQuoteIds.SyncedQuoteId];

if (SyncedQuoteStatus.Status=='Accepted'){
    return true;
    }
return false;
       }
}
