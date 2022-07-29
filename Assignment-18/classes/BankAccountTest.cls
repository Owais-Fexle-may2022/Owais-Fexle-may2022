@isTest
public with sharing class BankAccountTest {
    @isTest
    private static void BankAccountInsertion(){
        Bank_Account__c acc=new Bank_Account__c();
        acc.Name='Test';
        acc.Account_Holder_Name__c='Mohd Owais';
        acc.Account_Number__c='123456789';
        acc.Bank_Address__c='88/322 Chaman Ganj Kanpur';
        acc.Email__c='OwaisPsit99@gmail.com';
        acc.Mobile_Number__c='7379215315';
        acc.Type__c='Saving';
        test.StartTest();
        insert acc;
        test.StopTest();
        Bank_Account__c updateAcc=[SELECT Name FROM Bank_Account__c WHERE Id =:acc.id];
        system.assertEquals('Test',updateAcc.Name);

    }

}