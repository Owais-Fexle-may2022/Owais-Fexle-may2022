public class StudentInsertData {
      public StudentInsertData(){
        
        //Insert Student Record
        Student__c s1 = new Student__c();
        s1.Student_Name__c = 'Mohd Owais';
        s1.Roll_Number__c = 2345;
        s1.Father_s_Name__c='Jamshed';
        s1.Father_s_phone_Number__c='9838816799';
        s1.Email_Address__c='owaispsit99@gmail.com';
        s1.OverAll_Grade__c ='A';
          //Insert Bank Record
        s1.Account_Number__c = 5555;
        s1.Bank_Name__c ='Axis Bank';
        s1.Bank_Phone_Number__c='1800210';
        s1.Home_Number__c ='800921102';
        s1.City__c ='Kanpur';
        s1.State__c ='Uttar Pradesh';
        s1.Exam_Fees_Submitted__c =True;
        s1.Fee_Submited__c =True;
        s1.Is_Donation__c=False;
        s1.Pending_Exam_Fees__c= 0;
        s1.Pending_Fees_Amount__c =0;
          //Insert Sem Reocrd
        s1.First_Sem_Percentage__c= 80;
        s1.Second_Sem_Percentage__c = 70;
        s1.Third_Sem_Percentage__c =60;
        s1.Fourth_Sem_Percentage__c =50;
        s1.First_Sem_Back__c = True ;
        s1.Second_Sem_Back__c =False;
        s1.Third_Sem_Back__c = True;
        s1.Fourth_Sem_Back__c =True;
        s1.Subjects_in_which_Back__c ='Maths,Physics';
        //Inser Class Record
        s1.secions__c ='C';
        s1.Pending_Overall_Amount__c=0;
        s1.Stream__c='CS';
        insert s1;
        
    }
}