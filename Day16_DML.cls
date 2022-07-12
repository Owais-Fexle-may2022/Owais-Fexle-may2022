public with sharing class Day16_DML {
   
        public Static void D_M_L(){
            // List to hold the new contacts to update.
            List<Contact> updatedList = new List<Contact>();
            List<Contact> conList = [Select Department , Description from Contact];
            for(Contact con : conList) {
                if (con.Department == 'Finance') {
                    con.Description = 'New description';
                    // Add updated contact sObject to the list.
                    updatedList.add(con);
                }
            }
            update updatedList;
            system.debug(updatedList);
        }
        public static void Adding_And_Retriving(){
            //creating new record of Account
            Account a = new Account(Name='Account Example');
            insert a;
            system.debug(a);
            // Query existing account.
            Account ac = [SELECT Name,Industry FROM Account WHERE Name='Account Example' LIMIT 1];
            // Write the old values the debug log before updating them.
            System.debug('Account Name before update: ' + ac.Name); // Name is Account Example
            System.debug('Account Industry before update: ' + ac.Industry);// Industry is not set
            // Modify the two fields on the sObject.
            ac.Name = 'Account of the Day';
            ac.Industry = 'Technology';
            // Persist the changes.
            update ac;
            system.debug(ac);
            // Get a new copy of the account from the database.
            Account acc= [SELECT Id, Name,Industry FROM Account WHERE Name='Account of the Day' LIMIT 1];
            // Verify that updated field values were persisted.
            System.assertEquals('Account of the Day', acc.Name);
            System.assertEquals('Technology', acc.Industry);
        }
        public static void Inserting_And_Updating(){
            Account[] accts = new List<Account>();
            for(Integer i=0;i<3;i++) {
                Account a = new Account(Name='Acme' + i,BillingCity='San Francisco');
                accts.add(a);
            }
            Account accountToUpdate;
            try {
                insert accts;                    
                // Update account Acme.
                accountToUpdate = [SELECT Id, BillingCity FROM Account WHERE Name='Acme' AND BillingCity='San Francisco'LIMIT 1];
                system.debug('Before Update->' + accountToUpdate);
                // Update the billing city.
                accountToUpdate.BillingCity = 'New York';
                update accountToUpdate;
                system.debug('After Update->' + accountToUpdate);
            }   catch(DmlException e) {
                System.debug('An unexpected error has occurred: ' + e.getMessage());
                }        
            // Verify that the billing city was updated to New York.
            Account afterUpdate =[SELECT Id, BillingCity FROM Account WHERE Id=:accountToUpdate.Id];
            System.assertEquals('New York', afterUpdate.BillingCity);
        }
        public static void Inserting(){
            try {
                Account acc = new Account(Name='Mohd Owais Inserting',Phone='7379215315',Active__c='Yes');
                insert acc;
                Contact con = new Contact(AccountId=acc.Id,FirstName='Joe',LastName='Smith',Phone='415.555.1212');
                insert con;
            } catch(DmlException e) {
                System.debug('An unexpected error has occurred: ' + e.getMessage());
            }
        }
        public static void Updating(){
            try {
                // Query for the contact, which has been associated with an account.
                Contact queriedContact = [SELECT Account.Name FROM Contact WHERE FirstName = 'Joe' AND LastName='Smith'LIMIT 1];       
                queriedContact.Phone = '415.555.1213';        
                // Update the related account industry
                queriedContact.Account.Industry = 'Technology';        
                update queriedContact;
                // 2. This call is to update the related account's Industry field.
                update queriedContact.Account; 
                system.debug(queriedContact);
                system.debug(queriedContact.Account);
            } catch(Exception e) {
                System.debug('An unexpected error has occurred: ' + e.getMessage());
            }
        }

        
        public static void Relating_Record_UsingExternal_Id(){
            Opportunity newOpportunity = new Opportunity(Name='OpportunityWithAccountInsert',StageName='Prospecting',CloseDate=Date.today().addDays(7));
            Account accountReference = new Account(ID='0015i00000K3Hb0AAF');                
            // Add the account sObject to the opportunity.
            newOpportunity.Account = accountReference;
            // Create the opportunity.
            Database.SaveResult results = Database.insert(newOpportunity);
            system.debug(newOpportunity);
        }
        public static void Upserting(){
            List<Account> acctsList = [SELECT Id, Name, BillingCity FROM Account WHERE BillingCity = 'Bombay'];
            for (Account a : acctsList) {
                a.BillingCity = 'Kanpur';    
            }
            Account newAcct = new Account(Name = 'Acmes', BillingCity = 'San Francisco');
            acctsList.add(newAcct);
            try {
                upsert acctsList;
                system.debug(acctsList);
            } catch (DmlException e) {
                system.debug('Error in upserting' + e.getMessage());

            }
        }
        public static void Merging(){
            // Insert new accounts
            List<Account> ls = new List<Account>();
            Account a=new Account(Name='Master Account');                                      
            Account b=new Account(Name='Mergable Account');
            ls.add(a);
            ls.add(b);
            insert ls;
            // Queries to get the inserted accounts 
            Account masterAcct = [SELECT Id, Name FROM Account WHERE Name = 'Master Account' LIMIT 1];
            Account mergeAcct = [SELECT Id, Name FROM Account WHERE Name = 'Mergable Account' LIMIT 1];
            // Add a contact to the account to be merged
            Contact c = new Contact(FirstName='Owais',LastName='Merged');
            c.AccountId = mergeAcct.Id;
            insert c;
            try {
                merge masterAcct mergeAcct;
            } catch (DmlException e) {
                System.debug('An unexpected error has occurred: ' + e.getMessage()); 
            }
            masterAcct = [SELECT Id, Name, (SELECT FirstName,LastName From Contacts) 
                        FROM Account WHERE Name = 'Master Account' LIMIT 1];
            System.assert(masterAcct.getSObjects('Contacts').size() > 0);
            System.assertEquals('Owais', masterAcct.getSObjects('Contacts')[0].get('FirstName'));
            System.assertEquals('Merged', masterAcct.getSObjects('Contacts')[0].get('LastName'));
            // Verify that the merge record got deleted
            Account[] result = [SELECT Id, Name FROM Account WHERE Id=:mergeAcct.Id];
            System.assertEquals(0, result.size());
        }
        public static void Deleting(){
            Account[] doomedAccts = [SELECT Id, Name FROM Account WHERE Name = 'DotCom']; 
            try {
                delete doomedAccts;
            } catch (DmlException e) {
                System.debug('DotCom is not in DataBase' + e.getMessage());
            }
        }
        public static void Leading(){
            //Creating a Lead and inserting it in org.
            Lead myLead = new Lead(LastName = 'Fry', Company='Fry And Sons');
            insert myLead;
            Database.LeadConvert lc = new database.LeadConvert();
            lc.setLeadId(myLead.id);
            LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
            lc.setConvertedStatus(convertStatus.MasterLabel);
            Database.LeadConvertResult lcr = Database.convertLead(lc);
            System.assert(lcr.isSuccess());
        }
}