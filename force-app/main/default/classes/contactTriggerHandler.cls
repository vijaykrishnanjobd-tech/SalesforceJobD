public class contactTriggerHandler {
    
    public static void afterInsert(List<Contact> conList){
        updateTotalContacts(conList, NULL);
    }
    
    public static void afterUpdate(List<Contact> conList, Map<Id,Contact> oldMap){
        updateTotalContacts(conList, oldMap);
    }
    
    public static void afterDelete(List<Contact> oldContacts){
        updateTotalContacts(oldContacts, NULL);
    }
    
    public static void updateTotalContacts(List<Contact> conList, Map<Id,Contact> oldMap){
        Set<Id> accId=new Set<Id>();
        for(Contact cc:conList){
            if(oldMap == NULL && cc.AccountId != NULL){
               accId.add(cc.AccountId); 
            }else{
                Contact old=oldMap.get(cc.Id);
                if(cc.AccountId != old.AccountId && cc.AccountId != NULL){
                    accId.add(cc.AccountId);
                    accId.add(old.AccountId);
                }
            }
            
        }
        
        List<AggregateResult> arResult=[SELECT AccountId,Count(Id) totalContact FROM Contact WHERE AccountId in: accId GROUP BY AccountId];
        Map<Id,Integer> accResults=new Map<Id,Integer>();
        List<Account> accToUpdate = new List<Account>();
        for(AggregateResult ar: arResult){
            ID aId = (ID) ar.get('AccountId');
            Integer cnum = (Integer) ar.get('totalContact');
            accResults.put(aId,cnum);
        }
        
        for(Id acc:accId){
        	accToUpdate.add(new Account(Id=acc, Total_Contacts__c=accResults.get(acc)!=null?accResults.get(acc):0));
        }
        
        if(!accToUpdate.isEmpty()){
            Update accToUpdate;
        }
    }

}