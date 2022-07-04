public virtual with sharing class Car {
   //creating getter setter
   String name{get;private set;}
   String  Model{get;private set;}
   Integer HoursePower{get;private set;}
   // creating constructor 
   public Car(String name,String Model,Integer HoursePower){
       this.name=name;
       this.Model=Model;
       this.HoursePower=HoursePower;
   }
   //it cant be override
   public void CarStart(){
       system.debug(this.name +'Starting');
   }
   // it can be override because virtual give us ability to access a class and with override keyword
   // we can modify this method
   public virtual void HighSpeed (){
       system.debug(this.name +'180 KM/HR'); 
   }
   public virtual void Seater(){
       system.debug(this.name +'Five seater');
   }
   }