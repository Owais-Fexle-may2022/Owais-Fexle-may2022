public with sharing class State_Helper {
    static  Map<String,Map<String,List<String>>> globalMapWithCountryState= new Map<String,Map<String,List<String>>>();
     /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      This method is used when an State is inserted deleted or updated it updates total no of state on country object.
    * @author           Mohd Owais  <mohd.owais@fexle.com>
    * @Return           void
    * @Parameter        List of district
    * @created          2022-08-13
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    
    public static void insertUpdateDeleteState(List<State__c> newState,Map<Id,State__c> oldStateMap) {
        // initilizing map to store state parent and id.
        Map<Id,Country__c> mapOfCountryToBeUpdate=new Map<Id,Country__c>();
         // iterating state list.And putting values in map.
        for(State__c std:newState!=null ? newState:oldStateMap.Values()){
            if(std.Country_Name__c!=null){
                mapOfCountryToBeUpdate.put(std.Country_Name__c,new Country__c(Id=std.Country_Name__c,Total_Number_Of_States__c=0));
            }
            if(oldStateMap !=null && std.Country_Name__c != oldStateMap.get(std.Id).Country_Name__c){
                mapOfCountryToBeUpdate.put(oldStateMap.get(std.Id).Country_Name__c,new Country__c(Id=oldStateMap.get(std.Id).Country_Name__c,
                                                                                                                Total_Number_Of_States__c=0));
            }
        }
        if(!mapOfCountryToBeUpdate.isEmpty()){
            // iterating aggregate query and putting new value in total no of state field.
            for(AggregateResult agr:[SELECT COUNT(Id)NumofState,Country_Name__c FROM State__c WHERE Country_Name__c 
                                        IN:mapOfCountryToBeUpdate.keySet() GROUP BY Country_Name__c]){
                mapOfCountryToBeUpdate.get((Id)agr.get('Country_Name__c')).Total_Number_Of_States__c=(Integer)agr.get('NumofState');
                                        }
        }
        // updating map values
        update mapOfCountryToBeUpdate.Values();

        List<Id> countryList = new List<Id>();
        for(State__c s: newState!=null ? newState : oldStateMap.Values()) {
            countryList.add(s.Country_Name__c);           
        }
            CountryJosnGenerator(countryList);
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
