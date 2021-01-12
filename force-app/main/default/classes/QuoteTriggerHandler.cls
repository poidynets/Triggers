public with sharing class QuoteTriggerHandler {
public static void beforeUpdate(Quote[] oldQuotes, Quote[] newQuotes) {
System.Debug ('old Quote status +++ ' + oldQuotes[0].status + ' new Quote status +++ ' + newQuotes[0].status);
        if (oldQuotes[0].status == newQuotes[0].status || newQuotes[0].status != 'Accepted') {
System.Debug ('1 New Quote Status +++ ' + newQuotes[0].status);
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