/*────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
* Created Date          :       30/7/2022
* Author                :       Mohd Owais
* Description           :       This is OpportunityTriggerHelper class.
*                               It has one method. which is used for perform insert and update operation on Opportunity when stage modified to Shipped to Customer, Return to HQ and Return to Customer.
* ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
public with sharing class opportunity_Helper1 {
    // Global variable
    static Integer maxSize=18;
      /*
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * Created Date         :       30/7/2022
    * Author               :       Mohd Owais
    * Description          :       Perform INSERT and UPDATE Operation on Opportunity when stage changes to Shipped to Customer, Return to HQ and Return to Customer.
    * Returns              :       Void
    * Parameters           :       List<Opportunity>
    ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
public static void InsertAndUpdate(List<Opportunity> oppList){
    List<sObject> newAutomobileRecords = new List<sObject>();
    List<sObject> existingAutomobileRecords = new List<sObject>();
    List<sObject> updateInsertRecord=new List<sObject>();
    //Fetching data From Database.
    List<Automobile_Sensor__c> autoSensorList = [Select Id, Name, Account__c, Opportunity__c From Automobile_Sensor__c Where Opportunity__c IN :oppList];
    List<Automobile_Presence_Sensor__c> autoPresenceList = [Select Id, Name, Account__c, Opportunity__c From Automobile_Presence_Sensor__c Where Opportunity__c IN : oppList];
    List<Automobile_TDU__c> autoTDUList = [Select Id, Name, Account__c, Opportunity__c From Automobile_TDU__c Where Opportunity__c IN : oppList];
    List<Automobile_Tag__c> autoTagList = [Select Id, Name, Account__c, Opportunity__c From Automobile_Tag__c Where Opportunity__c IN : oppList];
    Map<String, Automobile_Sensor__c> autoSensorMap = new Map<String, Automobile_Sensor__c>();
    Map<String, Automobile_Presence_Sensor__c> autoPresenceMap = new Map<String, Automobile_Presence_Sensor__c>();
    Map<String, Automobile_TDU__c> autoTDUMap = new Map<String, Automobile_TDU__c>();
    Map<String, Automobile_Tag__c> autoTagMap = new Map<String, Automobile_Tag__c>();
    //Iterating data and storing it in map
    for (Automobile_Sensor__c autoSensor : autoSensorList) {
        autoSensorMap.put(autoSensor.Name, autoSensor);
        }
    for (Automobile_Presence_Sensor__c autoPSensor : autoPresenceList) {
        autoPresenceMap.put(autoPSensor.Name, autoPSensor);
        }
    for (Automobile_TDU__c autoTDU : autoTDUList) {
        autoTDUMap.put(autoTDU.Name, autoTDU);
        }
    for (Automobile_Tag__c autoTag : autoTagList) {
        autoTagMap.put(autoTag.Name, autoTag);
    }
    // Iterating opportunity From Opportunity List
    for(opportunity opp:oppList){
        // Checking Opportunity Stage
        if (opp.StageName == 'Return to Customer' || opp.StageName == 'Shipped To Customer') {
            Set<String> setOfTagDetails = new Set<String>();
            if (opp.Automobile_Tag_Details_1__c != null) {
                for (String tagName : opp.Automobile_Tag_Details_1__c.split('\n')) {
                    setOfTagDetails.add(TagName.trim());                                            
                }
            }
            if (opp.Automobile_Tag_Details_2__c != null) {
                for (String tagName : opp.Automobile_Tag_Details_2__c.split('\n')) {
                    setOfTagDetails.add(tagName.trim());                                            
                }
            }
            if (opp.Automobile_Tag_Details_3__c != null) {
                for (String TagName : opp.Automobile_Tag_Details_3__c.split('\n')) {
                    setOfTagDetails.add(TagName.trim());                                            
                }
            }
            if (opp.AccountId != null) {
                if (!setOfTagDetails.isEmpty()) {
                    // iterating set of tag 
                    for (String recordName : setOfTagDetails) {
                        if (recordName.startsWith('00:11:CE:00')) {
                            if (autoSensorMap.containsKey(recordName) && recordName == autoSensorMap.get(recordName).Name) {
                                autoSensorMap.get(recordName).Account__c = opp.AccountId;
                                existingAutomobileRecords.add(autoSensorMap.get(recordName));
                            }
                            else if (!autoSensorMap.containsKey(recordName)) {
                                Automobile_Sensor__c newAutoSensor = new Automobile_Sensor__c();
                                if (recordName.length() > maxSize) {
                                    newAutoSensor.Name = recordName.substring(0,maxSize);
                                }
                                else {
                                    newAutoSensor.Name = recordName;
                                }
                                newAutoSensor.Account__c = opp.AccountId;
                                newAutoSensor.Opportunity__c = opp.Id;
                                newAutomobileRecords.add(newAutoSensor);
                            }
                        }
                        else if (recordName.startsWith('00:11:CE:D')) {
                            if (autoPresenceMap.containsKey(recordName) && recordName == autoPresenceMap.get(recordName).Name) {
                                autoPresenceMap.get(recordName).Account__c = opp.AccountId;
                                existingAutomobileRecords.add(autoPresenceMap.get(recordName));
                            }
                            else if (!autoPresenceMap.containsKey(recordName)) {
                                Automobile_Presence_Sensor__c newAutoPresence = new Automobile_Presence_Sensor__c();
                                if (recordName.length() > maxSize) {
                                    newAutoPresence.Name = recordName.substring(0,maxSize);
                                }
                                else {
                                    newAutoPresence.Name = recordName;
                                }
                                newAutoPresence.Account__c = opp.AccountId;
                                newAutoPresence.Opportunity__c = opp.Id;
                                newAutomobileRecords.add(newAutoPresence);
                            }
                        }
                        else if (recordName.startsWith('00:11:CE:E')) {
                            if (autoTDUMap.containsKey(recordName) && recordName == autoTDUMap.get(recordName).Name) {
                                autoTDUMap.get(recordName).Account__c = opp.AccountId;
                                existingAutomobileRecords.add(autoTDUMap.get(recordName));
                            }
                            else if (!autoTDUMap.containsKey(recordName)) {
                                Automobile_TDU__c newAutoTdu = new Automobile_TDU__c();
                                if (recordName.length() > maxSize) {
                                    newAutoTdu.Name = recordName.substring(0,maxSize);
                                }
                                else {
                                    newAutoTdu.Name = recordName;
                                }
                                newAutoTdu.Account__c = opp.AccountId;
                                newAutoTdu.Opportunity__c = opp.Id;
                                newAutomobileRecords.add(newAutoTdu);
                            }
                        }
                        else if (recordName.substring(1,3).isNumeric()) {
                            if (autoTagMap.containsKey(recordName) && recordName == autoTagMap.get(recordName).Name) {
                                autoTagMap.get(recordName).Account__c = opp.AccountId;
                                existingAutomobileRecords.add(autoTagMap.get(recordName));
                            }
                            else if (!autoTagMap.containsKey(recordName)) {
                                Automobile_Tag__c newAutoTag = new Automobile_Tag__c();
                                if (recordName.length() > maxSize) {
                                    newAutoTag.Name = recordName.substring(0,maxSize);
                                }
                                else {
                                    newAutoTag.Name = recordName;
                                }
                                newAutoTag.Account__c = opp.AccountId;
                                newAutoTag.Opportunity__c = opp.Id;
                                newAutomobileRecords.add(newAutoTag);
                            }
                        }
                    }
                }
            }
        }else if (opp.StageName == 'Return to HQ') {
            Set<String> setOfReturnToHQRecords = new Set<String>();
            if (opp.Shipment_Account__c != null && opp.Return_To_HQ__c != null) {
                for (String recordName : opp.Return_To_HQ__c.split('\n')) {
                    setOfReturnToHQRecords.add(recordName.trim());                            
                }
                for (String recordName : setOfReturnToHQRecords) {
                    if (recordName.startsWith('00:11:CE:00')) {
                        if (autoSensorMap.containsKey(recordName) && recordName == autoSensorMap.get(recordName).Name) {
                            autoSensorMap.get(recordName).Account__c = opp.Shipment_Account__c;
                            existingAutomobileRecords.add(autoSensorMap.get(recordName));
                        }
                    }
                    else if (recordName.startsWith('00:11:CE:D')) {
                        if (autoPresenceMap.containsKey(recordName) && recordName == autoPresenceMap.get(recordName).Name) {
                            autoPresenceMap.get(recordName).Account__c = opp.Shipment_Account__c;
                            existingAutomobileRecords.add(autoPresenceMap.get(recordName));
                        }
                    }
                    else if (recordName.startsWith('00:11:CE:E')) {
                        if (autoTDUMap.containsKey(recordName) && recordName == autoTDUMap.get(recordName).Name) {
                            autoTDUMap.get(recordName).Account__c = opp.Shipment_Account__c;
                            existingAutomobileRecords.add(autoTDUMap.get(recordName));
                        }
                    }
                    else if (recordName.substring(1,3).isNumeric()) {
                        if (autoTagMap.containsKey(recordName) && recordName == autoTagMap.get(recordName).Name) {
                            autoTagMap.get(recordName).Account__c = opp.Shipment_Account__c;
                            existingAutomobileRecords.add(autoTagMap.get(recordName));
                        }
                    }
                }
            }
        }
    }
    // adding Both List to a Single List 
    updateInsertRecord.addAll(newAutomobileRecords);
    updateInsertRecord.addAll(existingAutomobileRecords);
    // system.debug('New automoblies List:' + NewAutomobileRecords);
    // system.debug('Existing automoblies List:' + ExistingAutomobileRecords);
    if(!updateInsertRecord.isEmpty()){
        // sending lists to sendMail method as parameter
        sendMail(updateInsertRecord,oppList);
        // system.debug('update insert list:' + updateInsertRecord);

    }

}
public static void sendMail(List<sObject> autoRecordList, List<Opportunity> opportunityList) {
    Map<String, List<sObject>> mapOfAutoRecords = new Map<String, List<sObject>>();
    // saving List to Database save result function for partially insertion or updation.
    Database.UpsertResult[] results=Database.upsert(AutoRecordList, false);  
    String htmlBody = '';
    String htmlBody1 ='';
    String msgRefr;
    // Creating EmailList 
    List<Messaging.Email> emailList = new List<Messaging.Email>();
    if (autoRecordList != null) {
        // Iterating opportunity List
        for (Opportunity opp : opportunityList) {
            List<SObject> temp = new List<SObject>();
            // Iterating recordList
            for (SObject autoRecord : autoRecordList) {
                if ((String)autoRecord.get('opportunity__c') == opp.Id) {
                    // adding them to temp variable.
                    temp.add(autoRecord);
                }
                
            }
            // setting values to map
            mapOfAutoRecords.put(opp.Name, Temp);
        }
    }
    // iterating opportunity List
    for (Opportunity opp : opportunityList) {
        Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
        emailMsg.setToAddresses(new String[]{opp.Email__c});
        emailMsg.setSubject(opp.Name + ', Sensor Shipment Completed ' + Datetime.now());
        // Creating Email Body.
        htmlBody = 'Successful <br> <table border="1" style="border-collapse: collapse"><caption>Request Summary Data</caption><tr><th>Auto Mobile Type</th><th>Name</th><th>Message</th></tr>';
        htmlBody1 = 'UnSuccessful <br> <table border="1" style="border-collapse: collapse"><caption>Request Summary Data</caption><tr><th>Auto Mobile Type</th><th>Name</th><th>Message</th></tr>';
        for (SObject recordName : mapOfAutoRecords.get(opp.Name)) {
            String sensorName = (String)recordName.get('Name');
            String sensorType;
            String message;
            String message1;
                // iterating results and checking for success and unsuccess operation.
            for (Database.UpsertResult result : results) {
                if (sensorName.contains('00:11:CE:00')) {
                    sensorType = 'Auto Sensor';
                    if (result.isSuccess()) {
                        message = 'Record Successfully Created, Opprotunity Name is: ' + result.getId();
                    }
                    else {
                        for (Database.Error error : result.getErrors()) {
                            message1 = error.getStatusCode() + ': ' + error.getMessage() + 
                            ' Fields that affected the error: ' + error.getFields();
                        }
                    }
                }
                else if (sensorName.contains('00:11:CE:D')) {
                    sensorType = 'Auto Presence';
                    if (result.isSuccess()) {
                        message = 'Record Successfully Created, Opprotunity Name is: ' + result.getId();
                    }
                    else {
                        for (Database.Error error : result.getErrors()) {
                            message1 = error.getStatusCode() + ': ' + error.getMessage() + 
                            ' Fields that affected the error: ' + error.getFields();
                        }
                    }
                }
                else if (sensorName.contains('00:11:CE:E')) {
                    sensorType = 'Auto TDU ';
                    if (result.isSuccess()) {
                        message = 'Record Successfully Created, Opprotunity Name is: ' + result.getId();
                    }
                    else {
                        for (Database.Error error : result.getErrors()) {
                            message1 = error.getStatusCode() + ': ' + error.getMessage() + ' Fields that affected the error: ' + error.getFields();
                        }
                    }
                }
                else if (sensorName.substring(1,3).isNumeric()) {
                    sensorType = 'Auto Tag';
                    if (result.isSuccess()) {
                        message = 'Record Successfully Created, Opprotunity Name is: ' + result.getId();
                    }
                    else {
                        for (Database.Error error : result.getErrors()) {
                            message1 = error.getStatusCode() + ': ' + error.getMessage() + ' Fields that affected the error: ' + error.getFields();
                        }
                    }
                }
            }
            htmlBody += '<tr><td>' + sensorType + '</td><td>' + sensorName + '</td><td>' + message + '</td></tr>';
            htmlBody1 += '<tr><td>' + sensorType + '</td><td>' + sensorName + '</td><td>' + message1 + '</td></tr>';
            msgRefr=message1;
        }
        htmlBody += '</table>';
        htmlBody1 += '</table>';
        if(msgRefr!=null){
        emailMsg.setHtmlBody(htmlBody + htmlBody1);
        }
        else{
            emailMsg.setHtmlBody(htmlBody);
        }
        emailList.add(emailMsg);
    }
    // sending mail.
    Messaging.sendEmail(emailList);
}   
}
