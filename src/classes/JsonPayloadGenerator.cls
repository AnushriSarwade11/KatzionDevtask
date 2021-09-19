/**
*    @Author - Anushri
*    @Description - This class generates Json payloads
**/

public class JsonPayloadGenerator {

    /**
     * To generate Transaction Item Payload
	 **/
    public static String generateTransactionItemsPayload(list<TransactionItem__c> transactItems){
        JSONGenerator generator = JSON.createGenerator(true);
        String jsonPayload = null;
        try {
            generator.writeStartArray();

            for (TransactionItem__c item : transactItems) {
                generator.writeStartObject();
                generator.writeFieldName('keys');
                generator.writeStartObject();
                generator.writeStringField('TransactionItemID', item.Id);
                generator.writeEndObject();

                generator.writeFieldName('values');
                generator.writeStartObject();
                generator.writeStringField('ItemCost', String.valueOf(item.Item_Cost__c));
                generator.writeStringField('ItemName', String.valueOf(item.Name));
                generator.writeEndObject();
                generator.writeEndObject();
            }
            generator.writeEndArray();

            jsonPayload = generator.getAsString();
            System.debug(LoggingLevel.INFO, 'Transaction Items JSON Payload:  ' + jsonPayload);
        }catch (JSONException jsonException){
            System.debug(LoggingLevel.ERROR, 'Exception occurred while generating Transaction Items JSON Payload:' + jsonException.getMessage());
            System.debug(LoggingLevel.ERROR, 'Stacktrace:' + jsonException.getStackTraceString());
        }

        return jsonPayload;
    }

    /**
     * To generate Transaction Payload
	 **/
    public static String generateTransactionPayload(Transaction__c transact){
        JSONGenerator generator = JSON.createGenerator(true);
        String jsonPayload = null;
        try{
            generator.writeStartObject();
            generator.writeFieldName('keys');
            generator.writeStartObject();
            generator.writeStringField('TransactionID', transact.Id);
            generator.writeEndObject();

            generator.writeFieldName('values');
            generator.writeStartObject();
            generator.writeStringField('TotalCost', String.valueOf(transact.Total_Cost__c));
            generator.writeStringField('TotalDiscount', String.valueOf(transact.Total_Discount__c));
            System.debug(LoggingLevel.DEBUG, transact.CreatedDate);
            Date transactionCreatedDate = Date.newInstance(transact.CreatedDate.year(), transact.CreatedDate.month(), transact.CreatedDate.day());
            generator.writeStringField('TransactionDate', String.valueOf(transactionCreatedDate));
            generator.writeStringField('TotalCount', String.valueOf(transact.Transaction_Count__c));
            generator.writeEndObject();
            generator.writeEndObject();

            jsonPayload = generator.getAsString();
            System.debug(LoggingLevel.INFO, 'Transaction JSON Payload:  ' + jsonPayload);
        }catch (JSONException jsonException){
            System.debug(LoggingLevel.ERROR, 'Exception occurred while generating Transaction JSON Payload:' + jsonException.getMessage());
            System.debug(LoggingLevel.ERROR, 'Stacktrace:' + jsonException.getStackTraceString());
        }

        return jsonPayload;
    }
}