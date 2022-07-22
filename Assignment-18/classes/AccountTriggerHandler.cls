/*------------------------------------------------------------------------------------------------------------------------------------------
@Description   This class is used to Help Trigger_Account and used to generate a email notification to sent to particular user.
*              In This class two method is present. 
*			   First  method is used to generate random number for account number field and adding prefix to account number.
*			   Second method is used to generates an email for bulk of records.
* @author      Mohd Owais   <mohd.owais@fexle.com>
* @version     1.0
* @created     20/07/2022
------------------------------------------------------------------------------------------------------------------------------------------------*/
public with sharing class AccountTriggerHandler {
/*------------------------------------------------------------------------------------------------------------------------------------------
@Description   This method takes the list of record as parameter and generating a random number and adding it to
				Account number field and add prefix before accountNumber if the account type is saving or FD account.
*              if the account is not saving or FD account then it display an error on the Type field of Account.
* @author      Mohd Owais   <mohd.owais@fexle.com>
*parameter     List of Account
*Return        static
*/
    public static void accountPrefixInsertion(List<Account>accList){
		//Iterating list of Accounts
        for(Account acc:accList){
			//Check if account number field is null
           if(acc.AccountNumber==null){
			//Creating a random number and type cast it to Integer.
            Integer ranInt=Integer.valueof(100000000 *Math.random());
			//type cast random generated number to string and added it to account number field
            acc.AccountNumber=String.valueof(ranInt);
           }
            // comparing that account's type field is equal to Specific String
            if(acc.Type=='Saving'){
                // adding acc Type before account Number
                   acc.AccountNumber=acc.Type +'-'+acc.AccountNumber;
               } 
               else if(acc.Type=='FD Account'){
                   acc.AccountNumber=acc.Type +'-'+acc.AccountNumber;
               }
               else{
                // if both the condition not meet then an error message popup at type field in acout Tab.
                   acc.Type.adderror('You should have to choose either saving or FD account');
               }
        }
    }
/*------------------------------------------------------------------------------------------------------------------------------------------
@Description   This Method takes the record of Account as parameter and generate an email for that record's email which
*              have already been inserted inside database record of account object and sent email to account record's mail.
* @author      Mohd Owais   <mohd.owais@fexle.com>
*Parameter     List of account from trigger
*return        Static
*/
    public static void SentEmailNotification(List<Account> accList){
        // Creating a  object which stores List of email by using method called messaging email. 
        List<Messaging.Email> emailList=new List<Messaging.Email>();
        // Iterating account list which is passes in parameter
        for(Account acc:accList){
            // Checking the condition if email field is empty or not
            if(acc.Email__c!=Null){
                // creating the emailmsg object which stores all the details related to message.
                Messaging.SingleEmailMessage emailMsg=new Messaging.SingleEmailMessage();
                // Creating a List pf address which holds email related to account.
                List<String> toAdress=new List<String>{acc.Email__c};
                // setting the value of email adress to emailMsg object
                emailMsg.setToAddresses(toAdress);
                // Creating email subject and adding it to emailMsg object
                String emailSub= 'Welcome' + acc.Name;
                emailMsg.setSubject(emailSub);
                // Creating a String variable which stores the display name From Whom the email has been sended.
                String disName='Axis Bank Private Limited';
                emailMsg.setSenderDisplayName(disName);
                // Creating the email body and storing it into HTML Format
                String content='Hii  Congratulations' + acc.Name + '<br/><br/>' + 
                    			'Your Account Number is :' + acc.AccountNumber + '<br/><br/>' +
                    			'Thank You For Choosing our service';
                emailMsg.setHtmlBody(content);
                // adding emailMsg to email List.
                emailList.add(emailMsg);
            }
            else{
                // if Account related List is empty then this error message will popup while saving record
                acc.adderror('Please insert email to update you about process');
            }
        }
        // senting emails to all the email Address which have been added to emailList or Which has been fetch by acount related Email field.
        Messaging.sendEmail(emailList);
        
    }

}