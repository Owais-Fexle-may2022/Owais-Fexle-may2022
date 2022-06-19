public class JunctionRelation {
    public JunctionRelation(){
        //Insert Subject Name
        Subject__c s1=new Subject__c();
        s1.Name='Maths';
        //Insert Student Detail
          Student__c std = new Student__c();
        std.Student_Name__c = 'Amit';
        std.Roll_Number__c = 2345;
        std.Father_s_Name__c='Bhadana';
        std.Father_s_phone_Number__c='8009210100';
        std.Email_Address__c='amitbhadana99@gmail.com';
        std.OverAll_Grade__c ='b';
        insert s1;
        insert std;
        //Insert Employee Record
        Employee__c e1=new Employee__c();
        e1.Name='Arpit';
        e1.Mentor__c='Seemu Sir';
        e1.Trainer__c='Rajiv Sir';
    }

}