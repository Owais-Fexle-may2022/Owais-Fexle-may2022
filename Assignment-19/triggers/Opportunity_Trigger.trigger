trigger Opportunity_Trigger on Opportunity (After Insert,After Update) {
    if(trigger.isAfter){
        if(trigger.isInsert|| trigger.isUpdate){
            List<opportunity> listOpp=new List<opportunity>();
            for(opportunity opp:Trigger.new){
                if(opp.StageName=='Shipped To Customer' || opp.StageName=='Return To HQ' || opp.StageName=='Return to Customer'){
                    listOpp.add(opp);
                }
            }
            if(!listOpp.isEmpty()){
                opportunity_Helper1.InsertAndUpdate(listOpp);
            }
        }
    }
}