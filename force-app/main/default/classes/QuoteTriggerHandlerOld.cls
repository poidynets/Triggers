public class QuoteTriggerHandler {
public static void beforeUpdate(Quote[] newQuotes) {
    for (Quote updatedQuote : newQuotes) 
if (
    
// !QuoteTriggerHandlerHelper.isSyncedQuoteEqualsNull(updatedQuote) &&
// !QuoteTriggerHandlerHelper.isUpdatedQuoteSyncedWithOpportunity(updatedQuote)&&
QuoteTriggerHandlerHelper.isSyncedQuoteInAccepted(updatedQuote))
        {
        updatedQuote.adderror('Error, "isSyncedQuoteInAccepted": ' + QuoteTriggerHandlerHelper.isSyncedQuoteInAccepted(updatedQuote));
                        }
        }
}
