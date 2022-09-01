trigger Trigger_Contact_property on Contact (before insert) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            Property_Helper.Contact_Sync(trigger.new);
        }
    }

}