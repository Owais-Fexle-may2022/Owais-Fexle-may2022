public class RelationShipRecord {
    public RelationShipRecord(){
        //Insert College Detail
        College__c c1=new College__c();
        c1.Name='Psit college of Engineering';
        c1.Email_Address__c='psitkanpur@gmail.com';
        c1.TollFree_Number__c='0512-888-999';
        c1.College_Established_On__c=date.parse('17/07/1881');
        //Insert TeacherData
        Teacher__c t1=new Teacher__c();
        t1.Name='Mohd Owais';
        t1.College__c='Psit college of Engineering';
        t1.Teacher_Phone_Number__c='7379215315';
        t1.Email_Address__c='owaispsit99@gmail.com';
        insert c1;
        insert t1;
        
    }

}