// public with sharing class Day_13ClassConcept {
public class Day_13ClassConcept {
    public void myOuterClass() {
        // Additional myOuterClass code 
        myInnerClass MIC= new myInnerClass();
        MIC.AddingTwoNumbers();
    }
        class myInnerClass {
            // myInnerClass code here
            public void AddingTwoNumbers(){
            Integer a=12,b=20;
            system.debug('addition of two numbers a and b are :::' + (a+b));
            }
        }
        public static Student__c stdata {
            get {
                if(stdata==Null){
                    //onetime run
                    stdata=[SELECT Id,Student_Name__c FROM Student__c WHERE name !=Null LIMIT 1];
                }
                return stdata;
            }
            set{
                stdata.Student_Name__c=stdata.Student_Name__c+DateTime.now();
                system.debug('Checksdata.Name'+stdata.Student_Name__c);
            }
        }
        public static Student__c st{get;set;}
        @AuraEnabled
        public static Student__c getstdata(){
            Student__c stLocal;
            if(stdata==null){
                stdata=[SELECT Id,name FROM Student__c WHERE name !=null];
            }
            return stdata;
        }        
}