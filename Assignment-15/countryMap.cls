public with sharing class countryMap {
    public countryMap() {
        map<String,map<String,map<String,List<String>>>> allMap= new map<String,map<String,map<String,List<String>>>>();
        map<String,List<String>> IndiaStateMap=new Map<String,List<String>>();
        IndiaStatemap.put('Uttar Pradesh',new List<String>{'Kanpur','Agra','Banaras','Lucknow','gorakhpur','Sas'});
        IndiaStatemap.put('Rajasthan',new List<String>{'Jaipur','jodhpur','Ajmer','Kota'});
        IndiaStatemap.put('Assam',new List<String>{'Nagon','Tezpur','jorhat','silchar'});
        IndiaStatemap.put('jammu_and_kashmir',new List<String>{'Gulmarg','Jammu','Srinagar','Leh'});
        IndiaStatemap.put('Punjab',new List<String>{'ludhiana','chandigarh','pind','Amritsar'});
        map<String,List<String>> AmericaStateMap=new map<String,List<String>>();
        AmericaStateMap.put('Alabma',new List<String>{'New york','Los angles','Texes','Vegas','Los'});
        AmericaStateMap.put('Alaska',new List<String>{'pery pery','sidney','Austin','Sanjue'});
        AmericaStateMap.put('Arizona',new List<String>{'Chicho','Dalas','Colombus','Shinchain'});
        AmericaStateMap.put('Arkansas',new List<String>{'Denever','Berlin','Nagori','Propers'});
        map<String,List<String>> EnglandStateMap=new Map<String,List<String>>();
        EnglandStateMap.put('Bedfordshire',new List<String>{'London','Bristolo','Kingston','Lesister'});
        EnglandStateMap.put('Berkshire',new List<String>{'ploymouth','Derby','Liver pool'});
        map<String,map<String,List<String>>> mapCountryState= new map<String,map<String,List<String>>>();
        mapCountryState.put('Indias',IndiaStateMap);
        mapCountryState.put('America',AmericaStateMap);
        mapCountryState.put('England',EnglandStateMap);
        allMap.put('INDS',mapCountryState);
        allMap.put('AMA',mapCountryState);
        allMap.put('ENG',mapCountryState);
        // public void findDistrictCityWithSpecifiedS(){
        List<String> CountryNameList=new List<String>();
        List<String> StateNameList=new List<String>();
        List<String> CityNameList=new List<String>();
        for(String Code :allMap.KeySet()){
            if(Code.containsIgnoreCase('S')){
                for(String CountryState :allMap.get(Code).KeySet()){
                    if(CountryState.containsIgnoreCase('s')){
                        CountryNameList.add(CountryState);
                        for(String StateName : allMap.get(Code).get(CountryState).KeySet()){
                            if(StateName.containsIgnoreCase('s')){
                                StateNameList.add(StateName);
                                for(String CityName :allMap.get(Code).get(CountryState).get(StateName)){
                                    if(CityName.length()>=5 && CityName.containsIgnoreCase('s')){
                                        CityNameList.add(CityName);
                                    }                                       
                                }
                            }
                        }
                    }
                }
            }
        }
        system.debug(CountryNameList);
        system.debug(StateNameList);
        system.debug(CityNameList);
        // }    
        // system.debug('all map :' +allMap);
        // system.debug(' all map India :'+ allMap.get('IND')); 
        // system.debug(' Country State District :'+ allMap.get('AMA').get('America').get('Alabma')); 
    }
}