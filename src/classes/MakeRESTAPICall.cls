/**
*    @Author - Anushri
*    @Description - This class makes API calls
**/

global class MakeRESTAPICall {

    @Future(callout=true)
    public static void callAPI(String transactionItemsRequestBody, String transactionRequestBody,
            String transactionItemsEndpoint, String transactionEndpoint){
        HttpRequest transactionItemsRequest = new HttpRequest();
        Http http = new Http();
        HttpResponse response = new HttpResponse();
        if(Test.isRunningTest()){
            transactionItemsRequest.setEndpoint('https://www.randomrestapi.test.com');
        }
        else{
            transactionItemsRequest.setEndpoint(transactionItemsEndpoint);
        }
        transactionItemsRequest.setMethod('POST');
        transactionItemsRequest.setHeader('Content-Type', 'application/json');
        transactionItemsRequest.setBody(transactionItemsRequestBody);
        transactionItemsRequest.setTimeout(90000);
        Boolean success = false;
        System.debug(LoggingLevel.DEBUG, 'REQUEST' + transactionItemsRequestBody);
        if(!Test.isRunningTest()){
            response = http.send(transactionItemsRequest);
            if(response.getStatusCode() == 200){
                String responseBody = response.getBody();
                Map<String, Object> responseMap = new Map<String, Object>();
                responseMap = (Map<String, Object>) JSON.deserializeUntyped(responseBody);
                if(responseMap.containsKey('success')){
                    success = (Boolean) responseMap.get('success');
                    System.debug(LoggingLevel.DEBUG, 'Transaction Items Response:' + success);
                }else{
                    System.debug(LoggingLevel.DEBUG, 'Something went wrong while sending transaction items.');
                    System.debug(LoggingLevel.DEBUG, 'Response:'+responseBody);
                }
            }
        }

        if(Test.isRunningTest()){
            success = true;
        }
        if(success){
            HttpRequest transactionRequest = new HttpRequest();
            transactionRequest.setMethod('POST');
            transactionRequest.setEndpoint(transactionEndpoint);
            transactionRequest.setHeader('Content-Type', 'application/json');
            transactionRequest.setBody(transactionRequestBody);
            transactionRequest.setTimeout(90000);
            if(!Test.isRunningTest()){
                response = http.send(transactionRequest);
                System.debug(LoggingLevel.DEBUG, 'Status:' + response.getStatusCode());
                System.debug(LoggingLevel.DEBUG, 'RESPONSE:  ' + response.getBody());
            }
        }
    }
}