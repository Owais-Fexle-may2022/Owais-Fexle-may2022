public with sharing class PanCardValidation {
    static List<Id> setPanCard=new List<Id>();
    public static void ValidateContact(list<Contact>listContact){
        for (Contact con : listContact){
            setPanCard.add(con.Pan_Number__c);
        }
        Pan_Card__c listPanCard=[SELECT Id FROM Pan_Card__c WHERE Id = : setPanCard[0] LIMIT 1];
        if(listPanCard!=null){
            listContact[0].addError('this contact of pan card is already exist');
        }
    } 

}