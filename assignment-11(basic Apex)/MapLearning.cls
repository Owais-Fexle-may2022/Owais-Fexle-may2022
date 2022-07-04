public with sharing class MapLearning {
    public MapLearning() {

        // creating map 
        Map<String, String> country_currencies = new Map<String, String>();
        Map<ID, Set<String>> m = new Map<ID, Set<String>>();
        Map<String, String> MyStrings = new Map<String, String>{'a' => 'b', 'c' => 'd'.toUpperCase()};
        system.debug(MyStrings);
        Map<Integer, String> m1 = new Map<Integer, String>();
        m1.put(1, 'First entry');
        m1.put(2, 'Second entry');
        System.assert(m1.containsKey(1));
        String value = m1.get(2);
        System.assertEquals('Second entry', value);
        Set<Integer> s= m1.keySet();
        system.debug(m1);
    }
}