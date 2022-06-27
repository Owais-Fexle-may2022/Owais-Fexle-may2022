trigger ContactTrigger on Contact (before insert) {
    if(trigger.isBefore && trigger.isInsert){
        PanCardValidation.ValidateContact(trigger.new);
    }

}