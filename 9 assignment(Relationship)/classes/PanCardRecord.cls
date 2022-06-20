public class PanCardRecord {
    public PanCardRecord(){
        Pan_Card__c P1=new Pan_Card__c();
        P1.Name='Mohd Owais';
        P1.Pan_Number__c=1144556677;
        P1.Owner_Birth_Date__c=date.parse('17/07/1999');
        P1.Issue_Date__c=date.parse('02/02/2002');
        P1.Expire_Date__c=date.parse('02/02/2022');
        
    }

}