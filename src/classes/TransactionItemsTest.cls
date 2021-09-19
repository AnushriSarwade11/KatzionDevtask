/**
*    @Author - Anushri
*    @Description - Test class for TransactionItemTrigger, ProcessTransactions, MakeRESTAPICall, JsonPayloadGenerator
**/

@isTest
public class TransactionItemsTest {

    @TestSetup
    static void generateTransactionsData(){
        List<Transaction__c> transactions = new List<Transaction__c>();

        Transaction__c trans = new Transaction__c(Name = 'Test Transaction1', Total_Cost__c = 100.0, Total_Discount__c = 10.0, Transaction_Count__c = 2);
        transactions.add(trans);
        insert transactions;

        List<TransactionItem__c> transactionItems = new List<TransactionItem__c>();
        TransactionItem__c item1 = new TransactionItem__c(Name = 'Item1', Item_Cost__c = 50.0, Transaction__c = trans.Id);
        TransactionItem__c item2 = new TransactionItem__c(Name = 'Item2', Item_Cost__c = 50.0, Transaction__c = trans.Id);

        transactionItems.add(item1);
        transactionItems.add(item2);
        insert transactionItems;
    }

    static List<Transaction__c> getTransactionsData(){
        List<Transaction__c> transactions = new List<Transaction__c>();
        transactions = [
                SELECT
                        CreatedDate,
                        Name,
                        Total_Cost__c,
                        Total_Discount__c,
                        Transaction_Count__c,

                (SELECT Name, Item_Cost__c, Transaction__c FROM TransactionItem__r)

                FROM
                Transaction__c
        ];
        return transactions;
    }

    static Set<Id> getTransactionIds(){
        List<Transaction__c> trans = new List<Transaction__c>();
        trans = getTransactionsData();
        Set<Id> transactionIds = new Set<Id>();
        for (Transaction__c newItem : trans) {
            transactionIds.add(newItem.Id);
        }
        return transactionIds;
    }

    static testMethod void testJsonPayload(){
        List<Transaction__c> trans = new List<Transaction__c>();
        trans = getTransactionsData();
        List<TransactionItem__c> transactionItems = new List<TransactionItem__c>();
        transactionItems = trans[0].TransactionItem__r;
        Test.startTest();
        String transactionItemPayload = JsonPayloadGenerator.generateTransactionItemsPayload(transactionItems);
        String transactionPayload =JsonPayloadGenerator.generateTransactionPayload(trans[0]);
        
        System.assert(transactionItemPayload != null);
        System.assert(transactionPayload != null);
        Test.stopTest();
    }

    static testMethod void testDBQueries(){
        Set<Id> transactionIds = new Set<Id>();
        transactionIds = getTransactionIds();
        Test.startTest();
        List<Transaction__c> transactions = DBQueries.getTransactions(transactionIds);
        System.assert(transactions.size() > 0);
        Test.stopTest();
    }

    static testMethod void testRunMethod(){
        Set<Id> transactionIds = new Set<Id>();
        transactionIds = getTransactionIds();
        ProcessTransactions newProcess = new ProcessTransactions();
        Test.startTest();
        newProcess.run(transactionIds);
        Test.stopTest();
    }
}