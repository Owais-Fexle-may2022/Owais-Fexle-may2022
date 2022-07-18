public with sharing class CountryStateDistrictDataManipulation{
    // Initilizing Global map
    static  Map<String,Map<String,List<String>>> globalmapWithCountryState= new Map<String,Map<String,List<String>>>();
    //  @Description  This Constructor is used to fill map      
    public CountryStateDistrictDataManipulation(){
        //Fetching Record of Country
        List<Country__c> CountryList=[SELECT Id,Name FROM Country__c];
        // Fetching record of state
        List<State__c> StateList=[SELECT Id,Name,Country_Name__r.Name FROM State__c];
        //fetching record of District
        List<District__c> DistrictList=[SELECT Id,Name,State_Name__r.Name FROM District__c];
        // Iterating Country State And District List And Mapping them 
        for(Country__c c: CountryList ){
            globalMapWithCountryState.put(c.Name,new map<String,List<String>>());
            for(State__c s:StateList){
                if(s.Country_Name__r.Name==c.Name){
                    globalMapWithCountryState.get(c.Name).put(s.Name,new List<String>());
                    for(District__c d:DistrictList){
                        List<String> listdistrict=new list<String>();
                        if(d.State_Name__r.name==s.Name){
                            listdistrict.add(d.Name);
                            globalMapWithCountryState.get(c.Name).get(s.Name).addAll(listdistrict);
                    }   } 
                }
            }                
        } 
        system.debug('Map With Country State District' + globalMapWithCountryState);
    }
    // @Description this method is used to Search Record containing char or and length of string 
    public  void FindingSpecificLengthAndValue(String Str,Integer i){
        // Initilizing map for mapping state and district 
        Map<String,List<String>> mapState;
        // Initilizing List for district
        List<String> ListCity;
        // Iterating values of map for searching
        for(String CountryName:globalMapWithCountryState.KeySet()){
            if(CountryName.containsIgnoreCase(Str)){
                mapState=new map<String,List<String>>();
                for(String StateName:globalMapWithCountryState.get(CountryName).KeySet()){
                    if(StateName.containsIgnoreCase(Str)){
                        ListCity=new List<String>();
                        for(String DistrictName:globalMapWithCountryState.get(CountryName).get(StateName)){
                            if(DistrictName.length()>i && DistrictName.containsIgnoreCase(Str)){
                                ListCity.add(DistrictName);
                            }
                        }
                        mapState.put(StateName,ListCity);
                    }
                }
                globalMapWithCountryState.put(CountryName,mapState);
            }
        }
        system.debug('Filtering Country State District: : :' +globalMapWithCountryState);
    }
    // This method is used for calculating total no of state and district in country and updating it.
    public  void rollUpDistrictAndStateOnCountry(){
        // Map to hold state Record to update
        map<Id,State__c> mapStateDistrictUpdate=new map<Id,State__c>();
        map<Id,Country__c> mapCountryDistrictUpdate=new map<Id,Country__c>();
        //Getting aggregrate result on district
        for(aggregateResult agr:[SELECT Count(ID)NumofDistrict,State_Name__c FROM District__c GROUP BY State_Name__c]){
            mapStateDistrictUpdate.put(String.valueof(agr.get('State_Name__c')),new State__c(
                Id=String.valueof(agr.get('State_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr.get('NumofDistrict'))));
        }
        if(!mapStateDistrictUpdate.isEmpty()){
            // update state record
            update mapStateDistrictUpdate.Values();
            system.debug('Successfully update Total Number of district in state');
        }
        // get aggegrate result on state 
        for(aggregateResult agr1:[SELECT COUNT(Id)NumofState,Country_Name__c,SUM(Total_Number_Of_Districts__c)NumofDistricts FROM State__c
            GROUP BY Country_Name__c]){
                mapCountryDistrictUpdate.put(String.valueof(agr1.get('Country_Name__c')),new Country__c(
                Id=String.valueof(agr1.get('Country_Name__c')),Total_Number_Of_Districts__c=Integer.valueof(agr1.get('NumofDistricts')),
                Total_Number_Of_States__c=Integer.valueof(agr1.get('NumofState'))));
        }
        if(!mapCountryDistrictUpdate.isEmpty()){
            // updating country record
            update mapCountryDistrictUpdate.Values();
            system.debug('Successfully Update Total number of state and district in Country');
        }
    }
    //  @Description  This method is used to update the record that Json is generated
    public void updateCountryJson(String CountryName){
        // fetching the record from data base 
        Country__c Con =[SELECT Name,Country_JSON_Data__c FROM Country__c WHERE Name =:CountryName];
        Con.Country_JSON_Data__c=CountryJosnGenerator(Con.Name);
        update Con;
        system.debug('successfully update the record and inserted json data to it');
    }
    // this method is used to generate the data in jason format 
    public String CountryJosnGenerator(String CountryName){
        country__c conData=[SELECT Id,Country_code__c,Total_Number_Of_Districts__c,Total_Number_Of_States__c FROM Country__c WHERE Name=:CountryName];
        Country con = new Country();
        con.countryName = countryName;
        con.CountryCode=conData.Country_code__c;
        con.TotalState=(Integer)conData.Total_Number_Of_States__c;
        con.TotalDistrict=(Integer)conData.Total_Number_Of_Districts__c;
        List<States> listStates = new List<States>();
        for(String sName : globalMapWithCountryState.get(countryName).keySet()){
            States st = new States();
            st.stateName = sName;
            List<Districts> dst = new List<Districts>();
            for(String dName : globalMapWithCountryState.get(countryName).get(sName)){
                Districts d = new Districts();
                d.districtName = dName;
                dst.add(d);
            }
            st.discricts = dst;
            listStates.add(st);
        }        
        con.states = listStates;
        System.debug('Country Data : ' + con);
        System.debug('JSON Data : ' + JSON.serialize(con));
        return JSON.serialize(con);
    }
    // getter and setters
    public class Country{
        public string countryName{get;set;}
        public String CountryCode{get;set;}
        public Integer TotalState{get;set;}
        public Integer TotalDistrict{get;set;}
        public List<States> states{get;set;}
    }
    public class States{
        public string stateName{get;set;}
        public List<Districts> discricts{get;set;}
    }
    public class Districts{
        public string districtName{get;set;}
    }
}