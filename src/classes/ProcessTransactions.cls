/**
*    @Author - Anushri
*    @Description - This class checks whether Transaction is eligible for API call or not
**/

public with sharing class ProcessTransactions {

    private static String transactionItemsEndpoint = 'https://webhook.site/1a977896-67f1-409c-8f13-67f088a8d2bc';
    private static String transactionEndpoint = 'https://webhook.site/1a977896-67f1-409c-8f13-67f088a8d2bc';
	
    /**
     * To check Number of Transaction Items and Transaction Item Record count on Transaction and make REST API call
     */
    public void run(Set<Id> transactionIds){
        List<Transaction__c> transactions = DBQueries.getTransactions(transactionIds);
        for(Transaction__c trx : transactions){
            if(trx.TransactionItem__r.size() == trx.Transaction_Count__c){
                String transactItemsPayload = JsonPayloadGenerator.generateTransactionItemsPayload(trx.TransactionItem__r);
                String transactionPayload = JsonPayloadGenerator.generateTransactionPayload(trx);
                if(transactItemsPayload != null && transactionPayload != null){
                    MakeRESTAPICall.callAPI(transactItemsPayload, transactionPayload, transactionItemsEndpoint, transactionEndpoint);
                }
            }
        }
    }
}