public with sharing class bankTriggerHandler {

public static void beforeAccountInsertion(List<Bank_Account__c> bankAccList){
    for(Bank_Account__c BAL:BankAccList){
           if(BAL.Type__c=='Saving'){
               BAL.Account_Number__c='SA-'+ BAL.Account_Number__c;
           } 
           else if(BAL.Type__c=='Business'){
               BAL.Account_Number__c='FD-'+ BAL.Account_Number__c;
           }
           else{
               BAL.adderror('You should have to choose either saving or Business account');
           }
       }

}
public static void beforeAccountUpdation(List<Bank_Account__c> oldvalue,List<Bank_Account__c> newValue){
    for(Bank_Account__c ovalue:oldvalue){
        for(Bank_Account__c nValue:newValue){
            if(ovalue.id==nValue.id && ovalue.Account_Number__c!=nValue.Account_Number__c)
                nValue.Account_Number__c.adderror('You cannot change account number');
        }
    }
}
public static void beforeAccountDeletion(List<Bank_Account__c> AccountDetails){
    for(Bank_Account__c acc:AccountDetails){
        if(acc.Amount__c!=null)
            acc.adderror('This account is having some balance! Firstly clear that amount. Amount is :'+acc.Amount__c);
    }
}
public static void afterAccountInsertion(List<Bank_Account__c> accList){
    List<Contact> conToBeinserted=new List<Contact>();
    for(Bank_Account__c acc:accList){
        Contact con=new Contact();
        con.LastName=acc.Account_Holder_Name__c;
        con.Account_Contact__c=acc.Id;
        con.Phone=acc.Mobile_Number__c;
        conToBeinserted.add(con);
    }
    if(!conToBeinserted.isEmpty())
        Insert conToBeinserted;
}
public static void afterAccountUpdation(List<Bank_Account__c> oldvalues,List<Bank_Account__c> newvalues){
    for(Bank_Account__c nValue:newValues){
        for(Bank_Account__c oValue:oldvalues){
            if(nvalue.id==ovalue.id && nvalue.Account_Holder_Name__c!=ovalue.Account_Holder_Name__c)
                nvalue.Account_Holder_Name__c.adderror('Sorry Account holder Name should be created once and cant update');
        }
    }
}
public static void afterAccountDeleted(List<Bank_Account__c> AccList){
     List<Messaging.Email> emailList=new List<Messaging.Email>();
        for(Bank_Account__c acc:AccList){
            if(acc.Email__c!=Null){
                Messaging.SingleEmailMessage emailMsg=new Messaging.SingleEmailMessage();
                List<String> toAdress=new List<String>{acc.Email__c};
                emailMsg.setToAddresses(toAdress);
                String emailSub='Sorry to Hear That!!' + acc.Account_Holder_Name__c;
                emailMsg.setSubject(emailSub);
                String disName=acc.Name;
                emailMsg.setSenderDisplayName(disName);
                String content='Hii ' + acc.Account_Holder_Name__c + '<br/><br/>' + 
                    			'Your Account Number is :' + acc.Account_Number__c + '<br/><br/>' +
                    			'has been deleted from our end';
                emailMsg.setHtmlBody(content);
                emailList.add(emailMsg);
            }
        }
        Messaging.sendEmail(emailList);
}
public static void afterAccountUndletion(List<Bank_Account__c> RestoredList){
    List<Bank_Account__c> accList = new List<Bank_Account__c>();
    for(Bank_Account__c undeletedAccount : [SELECT ID, Name from Bank_Account__c where Id IN : RestoredList]){ 
        undeletedAccount.Name = ('Undeleted :' + undeletedAccount.Name);
        accList.add(undeletedAccount);
    } 
    update accList;
}
}