public class EmployeeRelation {
    public EmployeeRelation(){
         Employee__c e1=new Employee__c();
        e1.Name='Arpit';
        e1.Mentor__c='Seemu Sir';
        e1.Trainer__c='Rajiv Sir';
        insert e1;
    }

}