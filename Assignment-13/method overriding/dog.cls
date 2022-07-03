// accessing or extending Animal class
public with sharing class dog extends Animal {
    // creating additional  getter and setter for dog 
    String breed{get;private set;}
    String color{get;private set;}
    // creating constructor for dog
    public dog(String name,Integer weight,Integer age,String breed,String color) {
        // super is used to call a method or anything from parent to child dog is sub class and animal is super class
        super(name,weight,age);
        this.breed=breed;
        this.color=color;
    }
    // over ride eat method of animal it only change here not in main class
    public override void eat(){
        system.debug('successfully override eat method');
    }
}