public with sharing class ChatGPT {
   //private static String CHAT_GPT_KEY = ChatGPTKey__c.getValues('keyValue').APIkey__c;
    private static final String ENDPOINT ='https://api.openai.com/v1/completions';

    @AuraEnabled
    public static String getChatGPTResult(String searchString){
        try{
            String seachQueryEscaped = (searchString).trim();
            Http http = new Http();
            String reqBody = '{"model": "text-davinci-003","prompt":"'
                +seachQueryEscaped+
                '","max_tokens": 4000,"temperature": 0,'
                +'"stream": false,"top_p": 0.5}';
            System.debug('Query '+seachQueryEscaped+' '+reqBody);
            HttpRequest request = new HttpRequest();
            request.setEndpoint(ENDPOINT);
            request.setMethod('POST');
            request.setHeader('Authorization', 'Bearer '+String.escapeSingleQuotes('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').trim());
            //Setting timeout to max 120 second to get whole response from Chat GPT Open API
            request.setTimeout(120000);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            // Set the body as a JSON object
            request.setBody(reqBody);
            HttpResponse response = http.send(request);
            // Parse the JSON response
            if(response.getStatusCode() != 200) {
                System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getBody());
                return response.getBody();
            }
            System.debug(response.getBody());
            return response.getbody();

        }catch(Exception ex){
            System.debug('Exception in Catch of Server-Side Controller '+ex);
            throw new AuraHandledException(ex.getMessage());
        }
    }
}