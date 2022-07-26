/*------------------------------------------------------------------------------------------------------------------------------------------
@Description   This trigger is used before and after a record  is Inserted in account object.
* @author      Mohd Owais   <mohd.owais@fexle.com>
* @version     1.0
* @created     20/07/2022
*/
trigger Trigger_Account on Account (before insert,After insert) {
    // this if condition is activated when we want to insert a record in database.
    //  firstly it checks that the logic implemented in apex before trigger is executed completely.
    if(trigger.isbefore){
        // this checks if the account is new and wants to insert in data base.
       if(trigger.isInsert){
            // This is a helperclass of trigger_Account where we sent the record as a parameter to execute some logic before inserting record.
            AccountTriggerHandler.accountPrefixInsertion(trigger.new);
        }
    }
    //This if condition activated after inserting a record into database. 
   if(trigger.isAfter){
       if(trigger.isInsert){
        // This is a helperclass of trigger_Account where we sent the record as a parameter to generate an email for notification.
           AccountTriggerHandler.SentEmailNotification(trigger.new);
        }
    }
}