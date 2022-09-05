trigger State_Trigger on State__c (After insert, After Update, After Delete) {
    if(trigger.isAfter){
        if(trigger.isInsert||trigger.isUpdate||trigger.isDelete){
            State_Helper.insertUpdateDeleteState(trigger.new,trigger.oldMap);
        }
    }

}