public  with sharing class Day14_INstanceOfExample {
    sObject s= new Contact();
    // Account a=(Account)s;
    Contact c= (Contact)s;
    
    public  Day14_INstanceOfExample() {
        if(s instanceof Account){
            // Account a=(Account)s;
            system.debug('This is account type');
        }else if(s instanceof Contact){
            Contact c=(Contact)s;
            system.debug('This is Contact Type');

        }

       

    }
}
