public with sharing class District_Helper1 {
    // global Map
    static  Map<String,Map<String,List<String>>> globalMapWithCountryState= new Map<String,Map<String,List<String>>>();
    /*
    ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @Description      This method is used when an district is inserted deleted or updated it updates total no of district on state object.
    * @author           Mohd Owais  <mohd.owais@fexle.com>
    * @Return           void
    * @Parameter        List of district
    * @created          2022-08-13
    * ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
    */
    public static void insertUpdateDeleteDistrict(List<District__c> newDistrict,Map<Id,District__c> oldDistrictMap){
        // initilizing map to store district parent and id.
        Map<Id,State__c> mapOfStateToBeUpdate=new Map<Id,State__c>();
        // iterating district list.And putting values in map.
        for(District__c dist:newDistrict!=null ? newDistrict:oldDistrictMap.Values()){
            if(dist.State_Name__c!=null){
                mapOfStateToBeUpdate.put(dist.State_Name__c,new State__c(Id=dist.State_Name__c,Total_Number_Of_Districts__c=0));
            }
            if(oldDistrictMap !=null && dist.State_Name__c != oldDistrictMap.get(dist.Id).State_Name__c){
                mapOfStateToBeUpdate.put(oldDistrictMap.get(dist.Id).State_Name__c,new State__c(Id=oldDistrictMap.get(dist.Id).State_Name__c,
                                                                                                            Total_Number_Of_Districts__c=0));
            }
        }
        if(!mapOfStateToBeUpdate.isEmpty()){
            // iterating aggregate query and putting new value in total no of district field.
            for(AggregateResult agr:[SELECT COUNT(Id)numberOfDistrict,State_Name__c FROM District__c WHERE State_Name__c 
                                        IN:mapOfStateToBeUpdate.keySet() GROUP BY State_Name__c]){
                mapOfStateToBeUpdate.get((Id)agr.get('State_Name__c')).Total_Number_Of_Districts__c=(Integer)agr.get('numberOfDistrict');
                                        }
        }
        // updating map values.
        update mapOfStateToBeUpdate.Values();

        List<Id> countryList = new List<Id>();
        for(District__c d: newDistrict!=null ? newDistrict : oldDistrictMap.Values()) {
            countryList.add(d.State_Name__r.Country_Name__c);           
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
