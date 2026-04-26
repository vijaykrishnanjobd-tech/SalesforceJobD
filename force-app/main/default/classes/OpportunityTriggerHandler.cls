public without sharing class OpportunityTriggerHandler {
    public static final Integer HIGH_DEAL_THRESHOLD=10000;
    
    public static void updateCustomerSinceDate(List<Opportunity> oppList, Map<Id,Opportunity> oldMap){
        Set<Id> accId=new Set<Id>();
        for(Opportunity op: oppList){
            if(oldMap == null && op.StageName == 'Closed Won' && op.AccountId!=null){
                accId.add(op.AccountId);
            }else if(oldMap != null){
                Opportunity old=oldMap.get(op.id);
                if(old.StageName != op.StageName && op.StageName == 'Closed Won' && op.AccountId!=null){
                    accId.add(op.AccountId);
                }
            }
        }
        List<AggregateResult> accList=[SELECT AccountId,MIN(CloseDate) minCloseDate
                                        FROM opportunity 
                                        WHERE AccountId in: accId AND Account.Customer_Since__c = null AND StageName = 'Closed Won' 
                                        GROUP BY AccountID ];
        List<Account> accToUpdate=new List<Account>();
        for(AggregateResult ar:accList){
            Id aId = (Id) ar.get('AccountId');
            Date cDate = (Date) ar.get('minCloseDate');
            accToUpdate.add(new Account( Id=aId, Customer_Since__c=cDate ));
        }
        
        if(!accToUpdate.isEmpty()){
            update accToUpdate;
        }
        
        
    }
    
    public static void validateHighDeal(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        Set<Id> accId=new Set<Id>();
        Map<Id,Opportunity> opptyMap=new Map<Id,Opportunity>();
        for(Opportunity op: oppList){
            if(op.Amount >= HIGH_DEAL_THRESHOLD && op.AccountId != null){
                accId.add(op.AccountId);
                opptyMap.put(op.Id, op);
            }
        }
        
        Map<Id, Account> accMap=new Map<Id, Account>([SELECT Id,Type FROM Account WHERE Id in: accId]);
        for(Opportunity opp: opptyMap.values()){
            Account acc=accMap.get(opp.AccountId);
            if(acc!=null && acc.Type == 'Prospect'){
                opp.addError('High-value Opportunities cannot be created for Prospect Accounts');
            }
        }
        
    }

}