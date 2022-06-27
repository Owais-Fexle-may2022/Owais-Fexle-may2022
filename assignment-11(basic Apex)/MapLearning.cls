public with sharing class MapLearning {
    public MapLearning() {

        // creating map 
        Map<String, String> country_currencies = new Map<String, String>();
        Map<ID, Set<String>> m = new Map<ID, Set<String>>();
        Map<String, String> MyStrings = new Map<String, String>{'a' => 'b', 'c' => 'd'.toUpperCase()};
        system.debug(MyStrings);
        Map<Integer, String> m1 = new Map<Integer, String>(); // Define a new map
        m1.put(1, 'First entry');// Insert a new key-value pair in the map
        m1.put(2, 'Second entry');// Insert a new key-value pair in the map
        System.assert(m1.containsKey(1));// Assert that the map contains a key
        String value = m1.get(2);// Retrieve a value, given a particular key
        System.assertEquals('Second entry', value);
        Set<Integer> s= m1.keySet();// Return a set that contains all of the keys in the map
        system.debug(m1);
    }
}