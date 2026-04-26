public class AccountTriggerHandler {
    
    public static void validateHighDeal(List<Account> accList, Map<Id,Account> oldMap){
        Integer HIGH_DEAL_THRESHOLD=OpportunityTriggerHandler.HIGH_DEAL_THRESHOLD;
        Map<Id, Account> accMap=new Map<Id, Account>();
        for(Account acc: accList){
            if(acc.Type == 'Prospect'){
                accMap.put(acc.Id, acc);
            }
        }
        List<AggregateResult> arr=[SELECT AccountId, max(Amount) maxAmount 
                                  FROM Opportunity 
                                  WHERE AccountId in: accMap.keySet() 
                                  AND Amount >= :HIGH_DEAL_THRESHOLD
                                  GROUP BY AccountId];
            
        for(AggregateResult ar: arr){
            Id accId = (Id) ar.get('AccountId');
            Decimal maxAmount = (Decimal) ar.get('maxAmount');
            if(maxAmount >= HIGH_DEAL_THRESHOLD){
                Account acc=accMap.get(accId);
                acc.addError('Accounts with High-value Opportunities cannot be converted to Prospect');
            }
        }
    }

}