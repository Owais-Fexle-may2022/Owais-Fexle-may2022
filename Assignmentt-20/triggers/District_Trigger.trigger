trigger District_Trigger on District__c (After Insert,After Update,After Delete) {
    if(trigger.isAfter){
        if(trigger.isInsert||trigger.isUpdate||trigger.isDelete){
            District_Helper1.insertUpdateDeleteDistrict(trigger.new,trigger.oldMap);
        }
    }

}