trigger AccountTrigger on Account (before insert, before update, after insert, after update) {

    if(Trigger.isInsert && Trigger.isBefore){
        AccountTriggerHandler.validateHighDeal(Trigger.New, null);
    }
    
    if(Trigger.isUpdate && Trigger.isBefore){
        AccountTriggerHandler.validateHighDeal(Trigger.New, Trigger.oldMap);
    }
}