/**
*    @Author - Anushri
*    @Description - This class deals with Database
**/

public class DBQueries{
    
    public static List<Transaction__c> getTransactions(Set<Id> transactionIds){
        return [
                SELECT Id, Name, Transaction_Count__c, Total_Cost__c, Total_Discount__c, CreatedDate, (SELECT Id, Name, Item_Cost__c  FROM TransactionItem__r)
                FROM Transaction__c
                WHERE Id IN :transactionIds
        ];
    }
}