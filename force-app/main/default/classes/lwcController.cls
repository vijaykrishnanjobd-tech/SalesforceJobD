public class lwcController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT id,Name,Industry,Phone,Total_Contacts__c FROM Account];
    }

}