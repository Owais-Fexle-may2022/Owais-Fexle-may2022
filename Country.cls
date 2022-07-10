public with sharing class Country {
    public Country() {
        map<String,map<String,map<String,List<String>>>> allMap= new map<String,map<String,map<String,List<String>>>>();
        map<String,List<String>> SaudiStateMap=new Map<String,List<String>>();
        SaudiStatemap.put('Riyadhs',new List<String>{'Ras Tanura','Ranyah','Riyadh Al-Khabra','Saihat','Safwa city','Nas'});
        SaudiStatemap.put('Northern Borders',new List<String>{'Turaif','Arar'});
        SaudiStatemap.put('Qassim',new List<String>{'Al Nabhaniyah','Al Shimasiyah','Riyadh Al Khabra','Uyun AlJiwa'});
        map<String,List<String>> DubaiStateMap=new map<String,List<String>>();
        DubaiStateMap.put('Abu Dhabis',new List<String>{'Abu zaibi','Istayhah','Musaffah'});
        DubaiStateMap.put('Sharjah',new List<String>{'Al Majaz','Al Qasba','Al Noor',' Al Montazah'});
        DubaiStateMap.put('Ajman',new List<String>{'Ajman','Ajman City','Manama','Masfout'});
        DubaiStateMap.put('Umm Al-Quwain',new List<String>{'Al Rafaah','Al Rafaah','Al Yahar','Asimah'});
        map<String,List<String>> EuropeStateMap=new Map<String,List<String>>();
        EuropeStateMap.put('Albanias',new List<String>{'Tirana','Durres','Elbasan','Fier'});
        EuropeStateMap.put('Austria',new List<String>{'Graz','linzs','Liver Wels'});
        map<String,map<String,List<String>>> mapCountryState= new map<String,map<String,List<String>>>();
        mapCountryState.put('Saudi Arabia',SaudiStateMap);
        mapCountryState.put('Dubais',DubaiStateMap);
        mapCountryState.put('Europes',EuropeStateMap);
        allMap.put('SA',mapCountryState);
        allMap.put('DUS',mapCountryState);
        allMap.put('EUPS',mapCountryState);
        // public void findDistrictCityWithSpecifiedS(){
        List<String> CountryNameList=new List<String>();
        List<String> StateNameList=new List<String>();
        List<String> CityNameList=new List<String>();
        for(String Code :allMap.KeySet()){
            if(Code.containsIgnoreCase('S')){
                for(String CountryState :allMap.get(Code).KeySet()){
                    if(CountryState.containsIgnoreCase('s')){
                        CountryNameList.add('its a new Country'+CountryState);
                        for(String StateName : allMap.get(Code).get(CountryState).KeySet()){
                            if(StateName.containsIgnoreCase('s')){
                                StateNameList.add('State of' + CountryState);
                                StateNameList.add(StateName);
                                for(String CityName :allMap.get(Code).get(CountryState).get(StateName)){
                                    if(CityName.length()>=5 && CityName.containsIgnoreCase('s')){
                                        CityNameList.add('City of' + StateName);
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