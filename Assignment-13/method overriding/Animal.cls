public virtual with sharing class Animal {
    //creating getter setter
    String name{get;private set;}
    Integer weight{get;private set;}
    Integer age{get;private set;}
    // creating constructor 
    public Animal(String name,Integer weight,Integer age){
        this.name=name;
        this.weight=weight;
        this.age=age;
    }
    //it cant be override
    public void makeSound(){
        system.debug(this.name +'makes a sound');
    }
    // it can be override because virtual give us ability to access a class and with override keyword
    // we can modify this method
    public virtual void eat(){
        system.debug(this.name +'is eating'); 
    }
    public virtual void move(){
        system.debug('The animal is moving');
    }
    }