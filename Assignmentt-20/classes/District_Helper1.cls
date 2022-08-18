public with sharing class District_Helper1 {
    // global Map
    static  Map<String,Map<String,List<String>>> globalMapWithCountryState= new Map<String,Map<String,List<String>>>();
    // global list and map
    static map<Id,State__c> mapStateDistrict=new map<Id,State__c>();
    static map<Id,Country__c> mapCountryDistrict=new map<Id,Country__c>();
    static List<Id> countryList = new List<Id>();
    static  List<District__c> districtlist=new List<District__c>();
       /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      This method is used when an district is inserted it updates total no of district on state object and country object.
    * @author           Mohd Owais  <mohd.owais@fexle.com>
    * @Return           void
    * @Parameter        List of district
    * @created          2022-08-13
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void InsertDistrict(List<District__c> listOfDistricts){
        //iterating list add adding list Id to list of countries
        for (District__c d : listOfDistricts) {
            countryList.add(d.State_Name__r.Country_Name__c);
        }
        // aggregrate query for updating total no of district on state object.
        AggregateResult[] aggegrateOnDistrict = [SELECT Count(ID)NumofDistrict, State_Name__c FROM District__c GROUP BY State_Name__c];
        for (District__c dist : listOfDistricts) {
            // Iterating Aggregrate query List
            for(aggregateResult agr:aggegrateOnDistrict){
                if (dist.State_Name__c == agr.get('State_Name__c')) {
                    mapStateDistrict.put(String.valueof(agr.get('State_Name__c')),
                    new State__c(Id=String.valueof(agr.get('State_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr.get('NumofDistrict'))));
                }
            }
        }
        // checking if map is have something or not.
        if(!mapStateDistrict.isEmpty()){
            // update state record
            update mapStateDistrict.Values();
        }
        // querying fata for updating total no of district on country object.
        AggregateResult[] aggregateOnState = [SELECT Country_Name__c, SUM(Total_Number_Of_Districts__c)NumofDistricts 
        FROM State__c GROUP BY Country_Name__c];
        for (District__c dist : listOfDistricts) {
            for(aggregateResult agr1:aggregateOnState){
                if (dist.State_Name__r.Country_Name__r.Id == agr1.get('Country_Name__c')) {
                    mapCountryDistrict.put(String.valueof(agr1.get('Country_Name__c')),
                    new Country__c(Id=String.valueof(agr1.get('Country_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr1.get('NumofDistricts'))));                    
                }
            }            
        }
        if(!mapCountryDistrict.isEmpty()){
            // updating country record
            update mapCountryDistrict.Values();
            // passing List of country to json generator.
            CountryJosnGenerator(countryList);
        }
    }
        /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      This method is used when an district is updated it updates total no of district on state object and country object.
    * @author           Mohd Owais  <mohd.owais@fexle.com>
    * @Return           void
    * @Parameter        List of district,List of old District.
    * @created          2022-08-13
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public Static void UpdateDistrict(List<District__c> newListDistrict,List<District__c> oldListDistrict){
        for (District__c d : newListDistrict) {
            //iterating list add adding list Id to list of countries
            countryList.add(d.State_Name__r.Country_Name__c);
        }
        if (!oldListDistrict.isEmpty()) {
            // it adds country id of old value of district.
            for (District__c d : oldListDistrict) {
                countryList.add(d.State_Name__r.Country_Name__c);
            }
        }
        // aggregrate query for updating total no of district on state object.
        AggregateResult[] aggegrateOnDistrict = [SELECT Count(ID)NumofDistrict, State_Name__c FROM District__c GROUP BY State_Name__c];
        for (District__c dist : newListDistrict) {
              // Iterating Aggregrate query List
            for(aggregateResult agr:aggegrateOnDistrict){
                if (dist.State_Name__c == agr.get('State_Name__c')) {
                    mapStateDistrict.put(String.valueof(agr.get('State_Name__c')),
                    new State__c(Id=String.valueof(agr.get('State_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr.get('NumofDistrict'))));
                }
            }
        }
        // checking if map is have something or not.
        if(!mapStateDistrict.isEmpty()){
            // update state record
            update mapStateDistrict.Values();
        }
        // querying fata for updating total no of district on country object.
        AggregateResult[] aggregateOnState = [SELECT Country_Name__c, SUM(Total_Number_Of_Districts__c)NumofDistricts
        FROM State__c GROUP BY Country_Name__c];
        for (District__c dist : newListDistrict) {
            for(aggregateResult agr1:aggregateOnState){
                if (dist.State_Name__r.Country_Name__r.Id == agr1.get('Country_Name__c')) {
                    mapCountryDistrict.put(String.valueof(agr1.get('Country_Name__c')),
                    new Country__c(Id=String.valueof(agr1.get('Country_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr1.get('NumofDistricts'))));                    
                }
            }            
        }
        if(!mapCountryDistrict.isEmpty()){
            // updating country record
            update mapCountryDistrict.Values();
            CountryJosnGenerator(countryList);
        }
    }
        /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      This method is used when an district is Deleted it updates total no of district on state object and country object.
    * @author           Mohd Owais  <mohd.owais@fexle.com>
    * @Return           void
    * @Parameter        List of old district.
    * @created          2022-08-15
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void DeleteDistrict(List<District__c> oldListDistrict){
        for (District__c d : oldListDistrict) {
            //iterating list add adding list Id to list of countries
            countryList.add(d.State_Name__r.Country_Name__c);
        }
        // aggregrate query for updating total no of district on state object.
        AggregateResult[] aggegrateOnDistrict = [SELECT Count(ID)NumofDistrict,State_Name__c FROM District__c GROUP BY State_Name__c];
        for (District__c dist : oldListDistrict) {
            // Iterating Aggregrate query List
            for(aggregateResult agr:aggegrateOnDistrict){
                if (dist.State_Name__c == agr.get('State_Name__c')) {
                    mapStateDistrict.put(String.valueof(agr.get('State_Name__c')),
                    new State__c(Id=String.valueof(agr.get('State_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr.get('NumofDistrict'))));
                }
            }
        }
         // checking if map is have something or not.
        if(!mapStateDistrict.isEmpty()){
            // update state record
            update mapStateDistrict.Values();

        }
        // querying fata for updating total no of district on country object.
        AggregateResult[] aggregateOnState = [SELECT Country_Name__c, SUM(Total_Number_Of_Districts__c)NumofDistricts
        FROM State__c GROUP BY Country_Name__c];
         for (District__c dist : oldListDistrict) {
            for(aggregateResult agr1:aggregateOnState){
                if (dist.State_Name__r.Country_Name__r.Id == agr1.get('Country_Name__c')) {
                    mapCountryDistrict.put(String.valueof(agr1.get('Country_Name__c')),
                    new Country__c(Id=String.valueof(agr1.get('Country_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr1.get('NumofDistricts'))));                    
                }
            }            
        }
        if(!mapCountryDistrict.isEmpty()){
            // updating country record
            update mapCountryDistrict.Values();
            CountryJosnGenerator(countryList);
        }
    }
       /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      This method is used  to fill global map.
    * @author           Mohd Owais  <mohd.owais@fexle.com>
    * @Return           void
    * @created          2022-08-15
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void CountryStateDistrictDataManipulation(){
       
        List<Country__c> countryList=[SELECT Id,
        Name 
        FROM Country__c]; //Fetching Record of Country
        List<State__c> stateList=[SELECT Id,
        Name,
        Country_Name__r.Name
        FROM State__c];// Fetching record of state
        List<District__c> districtList=[SELECT Id,
        Name,State_Name__r.Name
        FROM District__c];//fetching record of District
        // Iterating Country State And District List And Mapping them 
        for (Country__c c : countryList) {
            List<String> listTempState = new List<String>();
            Map<String, List<String>> mapTempState = new Map<String, List<String>>();
            for (State__c s : stateList) {
                if (s.Country_Name__c == c.Id) {
                    listTempState.add(s.Name);
                    List<String> listTempDistrict = new List<String>();
                    for (District__c d : districtList) {
                        if (d.State_Name__c == s.Id) {
                            listTempDistrict.add(d.Name);
                        }
                    }
                    mapTempState.put(s.Name, listTempDistrict);
                }    
            }
            globalMapWithCountryState.put(c.Name, mapTempState);
        }
    }
       /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      This Method is used to generate json data on country object.
    * @author           Mohd Owais  <mohd.owais@fexle.com>
    * @Return           void
    * @Parameter        List of Country id
    * @created          2022-08-15
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void CountryJosnGenerator(List<Id> listOfCountries ){
        // calling method
        CountryStateDistrictDataManipulation();
        // Filtering data with query using listof countries.
        List<country__c> conData=[SELECT Id,Name,
        Country_code__c,
        Total_Number_Of_Districts__c,
        Total_Number_Of_States__c,Country_JSON_Data__c
        FROM Country__c
        WHERE Id IN:listOfCountries];
        // check if con data is empty
        if(!conData.isEmpty()){ 
            //fetching country data from database
            for(Country__c count:conData){
                Country con = new Country();
                // Creating list of state
                List<States> listStates = new List<States>();
                // Iterating global map to store data in country instance
                for(String sName : globalMapWithCountryState.get(count.Name).keySet()){
                    States st = new States();
                    st.stateName = sName;
                    List<Districts> dst = new List<Districts>();//Initilizing a list of district
                    for(String dName : globalMapWithCountryState.get(count.Name).get(sName)){
                        Districts d = new Districts();
                        d.districtName = dName;
                        dst.add(d);
                    }
                    st.discricts = dst;
                    listStates.add(st);
                }  
                con.countryName = count.Name;
                con.countryCode=count.Country_code__c;
                con.countryTotalStates=(Integer)count.Total_Number_Of_States__c;
                con.countryTotalDistricts=(Integer)count.Total_Number_Of_Districts__c;      
                con.states = listStates;
                count.Country_JSON_Data__c=JSON.serialize(con);
            }
        }
        if(!conData.isEmpty()){
        update conData;//updating conData.
        }
        system.debug('Json Generated Data' + conData);
        // returning all data in json format
    }
      /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      Wrapper Class for Country.
    * @author           Mohd Owais  
    * @created          2022-08-16
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public class Country{
        public String countryName{get;set;}
        public String countryCode{get;set;}
        public Integer countryTotalStates{get;set;}
        public Integer countryTotalDistricts{get;set;}
        public List<States> states{get;set;}
    }

    /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      Wrapper Class for State.
    * @author           Mohd Owais
    * @created          2022-08-16
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public class States{
        public string stateName{get;set;}
        public List<Districts> discricts{get;set;}
    }

    /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      Wrapper Class for District.
    * @author           Mohd Owais
    * @created          2022-08-16
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */

    public class Districts{
        public string districtName{get;set;}
    }
}