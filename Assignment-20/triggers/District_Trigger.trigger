trigger District_Trigger on District__c (After Insert,After Update,After Delete) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            District_Helper1.InsertDistrict(trigger.new);
        }else if(trigger.isupdate){
            District_Helper1.UpdateDistrict(trigger.new,trigger.old);
        }else if(trigger.isDelete){
            District_Helper1.DeleteDistrict(trigger.old);
        }
    }

}