trigger Opportunity_Trigger on Opportunity (After Insert,After Update) {
    if(trigger.isAfter){
        if(trigger.isInsert|| trigger.isUpdate){
            opportunity_Helper1.InsertAndUpdate(Trigger.new);
        }
    }

}