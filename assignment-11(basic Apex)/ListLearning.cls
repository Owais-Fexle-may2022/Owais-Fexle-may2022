public with sharing class ListLearning {
    public ListLearning() {
        // Create an empty list of String
    List<String> my_list = new List<String>();
    // Create a nested list
    List<List<Set<Integer>>> my_list_2 = new List<List<Set<Integer>>>();
    // to access element in list 
    List<Integer> myList = new List<Integer>();
    myList.add(47);// Adds a second element of value 47 to the end  of the list
    Integer i = myList.get(0);
    myList.set(0, 1);// 
    myList.clear();
    // using array notation
    String[] colors = new List<String>();
    List<String> colors1 = new String[1];
    colors1[0] = 'Green';
    system.debug(colors1);
    // adding value to list 
    List<Integer> ints = new Integer[6];
    ints.add(5);
    ints.add(7);
    system.debug(ints);
    // list sorting 
    List<String> colors2 = new List<String>{'Yellow','Red','Green'};
        colors2.sort();
        System.assertEquals('Green', colors2.get(0));
        System.assertEquals('Red', colors2.get(1));
        System.assertEquals('Yellow', colors2.get(2));
        // Default Sort Order for SelectOption
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('A','United States'));
        options.add(new SelectOption('C','Canada'));
        options.add(new SelectOption('A','Mexico'));
        System.debug('Before sorting: ' + options);
        options.sort();
        System.debug('After sorting: ' + options);


    }
}