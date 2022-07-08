public with sharing class Day15_InstanceofExample {
    sObject s= new Account();
    Account a=(Account)s;
    // Contact c= (Contact)s;
    public Day15_InstanceofExample(){
        if(s instanceof Account){
            Account a=(Account)s;
            system.debug('This is account type');
        }else if(s instanceof Contact){
            Contact c=(Contact)s;
            system.debug('This is Contact Type');
        }
    }
}
