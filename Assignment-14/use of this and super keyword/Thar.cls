// accessing or extending Car class
public with sharing class Thar extends Car {
    // creating additional  getter and setter for Thar 
    String Engine{get;private set;}
    String color{get;private set;}
    // creating constructor for Thar
    public Thar(String name,String Model,Integer HoursePower,String Engine,String color) {
        // super is used to call a method or anything from parent to child Thar is sub class and Car is super class
        super(name,Model,HoursePower);
        this.Engine=Engine;
        this.color=color;
    }
    // over ride HighSpeed method of Car it only change here not in main class
    public override void HighSpeed(){
        system.debug('successfully override HighSpeed method');
    }
}