public with sharing class QuoteTriggerHandler {
public static void beforeUpdate(Quote[] oldQuotes, Quote[] newQuotes) {
        if (oldQuotes[0].status == newQuotes[0].status || newQuotes[0].status != 'Accepted') {
return;
        }
        for (Quote newQuote : newQuotes) {
            if (
!QuoteTriggerHandlerHelper.isSyncedQuoteEqualsNull(newQuote) 
&&!QuoteTriggerHandlerHelper.isUpdatedQuoteSyncedWithOpportunity(newQuote)
&&QuoteTriggerHandlerHelper.isSyncedQuoteInAccepted(newQuote)
){
newQuote.adderror('Error, Quote went to "Accepted" status where we have additonal checks');
                            }
                  }
        }
}