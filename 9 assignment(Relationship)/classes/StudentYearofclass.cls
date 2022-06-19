public class StudentYearofclass {
    public StudentYearofclass(){
        //Insert Year of Student
        Year_of_Class__c y1=new Year_of_Class__c();
        y1.Name='First Year';
        insert y1;
        //Insert Student Details
          Student__c s1 = new Student__c();
        s1.Student_Name__c = 'Mohd Owais';
        s1.Roll_Number__c = 2345;
        s1.Father_s_Name__c='Jamshed';
        s1.Father_s_phone_Number__c='9838816799';
        s1.Email_Address__c='owaispsit99@gmail.com';
        s1.OverAll_Grade__c ='A';
        insert s1;
    }

}