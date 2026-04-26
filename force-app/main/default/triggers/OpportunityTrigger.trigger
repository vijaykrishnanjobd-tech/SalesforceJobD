trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update) {
    
    if(Trigger.isInsert && Trigger.isAfter){
        OpportunityTriggerHandler.updateCustomerSinceDate(Trigger.New, null);
    }
    
    if(Trigger.isUpdate && Trigger.isAfter){
        OpportunityTriggerHandler.updateCustomerSinceDate(Trigger.New, Trigger.oldMap);
    }
    
    if(Trigger.isInsert && Trigger.isBefore){
        OpportunityTriggerHandler.validateHighDeal(Trigger.New, null);
    }
    
    if(Trigger.isUpdate && Trigger.isBefore){
        OpportunityTriggerHandler.validateHighDeal(Trigger.New, Trigger.oldMap);
    }

}