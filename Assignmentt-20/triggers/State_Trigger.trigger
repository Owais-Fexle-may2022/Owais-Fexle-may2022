trigger State_Trigger on State__c (After insert, After Update, After Delete) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            State_Helper.StateIsInsert(trigger.new);
        }else if(trigger.isupdate){
            State_Helper.StateUpdate(trigger.new,trigger.old);
        }else if(trigger.isDelete){
            State_Helper.StateDelete(trigger.old);
        }
    }

}