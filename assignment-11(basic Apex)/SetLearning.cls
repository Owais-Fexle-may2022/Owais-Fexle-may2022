public with sharing class SetLearning {
    public SetLearning() {

        // creating set 
        Set<String> myStringSet = new Set<String>();
        
        // Defines a new set with two elements
        Set<String> set1 = new Set<String>{'New York', 'Paris'};
        system.debug(set1);
        // Define a new set
        Set<Integer> mySet = new Set<Integer>();
        // Add two elements to the set
        mySet.add(1);
        mySet.add(3);
        // Assert that the set contains the integer value we added
        System.assert(mySet.contains(1)); 
        // Remove the integer value from the set
        mySet.remove(1);
        system.debug(mySet);
        // Define a new set that contains the
    // elements of the set created in the previous example
    Set<Integer> mySet2 = new Set<Integer>(mySet);
    // Assert that the set size equals 1
    // Note: The set from the previous example contains only one value
    System.assert(mySet2.size() == 1);
    system.debug(mySet2);

    }
}