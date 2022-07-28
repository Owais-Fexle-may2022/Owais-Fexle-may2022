trigger Trigger_Bank on Bank_Account__c (before insert,before update,before delete,after insert,after update,after delete,after undelete) {
    if(trigger.isbefore){
        if(trigger.isInsert){
            bankTriggerHandler.beforeAccountInsertion(trigger.new);        
        }
        else if(trigger.isUpdate){
            bankTriggerHandler.beforeAccountUpdation(trigger.old,trigger.new);
        }
        else if(trigger.isDelete){
            bankTriggerHandler.beforeAccountDeletion(trigger.old);
        }
    }
        if(trigger.isAfter){
            if(trigger.isInsert){
                bankTriggerHandler.afterAccountInsertion(trigger.new);
            }else if(trigger.isupdate){
                bankTriggerHandler.afterAccountUpdation(trigger.old,trigger.new);
            }
            else if(trigger.isDelete){
                bankTriggerHandler.afterAccountDeleted(trigger.old);
            }
            else if(trigger.isUndelete){
                bankTriggerHandler.afterAccountUndletion(trigger.new);
            }
        }

}