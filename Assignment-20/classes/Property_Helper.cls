/*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       17/08/2022
    * Author               :       Mohd Owais
    * Description          :       This class is used when an contact is inserted in property's account.
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
public with sharing class Property_Helper {
     /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       17/08/2022
    * Author               :       Mohd Owais
    * Description          :       Updates Total Districts on Country and State Object using Aggregate Query When a District is Inserted Updated or Deleted.
    * Returns              :       Void
    * Parameters           :       List of Contact
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
   public static void Contact_Sync(List<Contact> contactList){
        set<id> AccountIds=new set<id>();
        // iterating contact add adding contact related account id.
        for(Contact con:contactList){
            AccountIds.add(con.AccountId);
        }
        map<id,Account> accMap=new map<id,account>();
        // adding values of account to map.
        accMap.putAll([SELECT Id,Name,Status__c,Property__c FROM Account WHERE Id IN: AccountIds]);
        map<id,Property__c> PropMap=new map<id,Property__c>();
        // adding values of property to map.
        PropMap.putAll([SELECT Id,Status__c FROM Property__c]);
        for(contact con: contactList){
            // checking contact status
            if(con.Status__c==null){
                Account acc=accMap.get(con.AccountId);
                // checking account status 
                if(acc.Status__c!=null){
                    con.Status__c=acc.Status__c;
                }
                else{
                    // checking property status.
                    Property__c prop=PropMap.get(acc.Property__c);
                    if(prop.Status__c!=null){
                        con.Status__c=prop.Status__c;
                    }
                }
            }
        }
    }
}