trigger ContactTrigger on Contact (before insert, before update, before delete, after insert, after update, after delete) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        contactTriggerHandler.afterInsert(Trigger.New);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        contactTriggerHandler.afterUpdate(Trigger.New, Trigger.oldMap);
    }
    
    if(Trigger.isAfter && Trigger.isDelete){
        contactTriggerHandler.afterDelete(Trigger.old);
    }
}