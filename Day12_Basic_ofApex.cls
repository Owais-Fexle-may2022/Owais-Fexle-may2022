public with sharing class Day12_Basic_ofApex {
    public Day12_Basic_ofApex(Integer choice) {
        if(choice==1){
            implementExpression();
        }
        else if(choice==2){
            implementExpressionOperator();

        }
        else if(choice==3){
            implementSafeNavigation();
        }
        else if(choice==4){
            implementComments();
        }
        else if(choice==5){
            implementRulesofConversion();
        }
        else{
            system.debug('you have choosen wrong try again');
    }   }
    public static void  implementExpression(){
        integer first=1+1;
        system.debug(first);
        //for list map integer set sobject
        Account acc= new Account();
        list<Account> l=new List<Account>();
        set<String> s1=new Set<String>{};
        Map<String, Integer> m1=new Map<String, Integer>();
        integer i = [SELECT COUNT() FROM Contact WHERE LastName ='Weissman'];
        List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        system.debug(i);
        system.debug('This list'+ searchList);
    }
        public static void implementExpressionOperator(){
            Integer a=20,b=30,n;
            system.debug('value of a' +a);
            system.debug('value of b' +b);
            //adding the value of b in a using operator
            a+=b;
            system.debug('Addition of value'+a);
            //multiplying the value of b in a using operator
            a*=b;
            system.debug('multiplication of value'+ a);
            //Subtracting  the value of b in a using operator
            a-=b;
            system.debug('subtractation of value'+a);
            // dividing the value of b in a using operator
            a/=b;
            system.debug('Division of value'+a);
            boolean x=True;
            boolean y=False;
            //OR assignment operator
            x|=y;
            system.debug('Or value of x'+x);
            //AND assignment operator
            x&=y;
            system.debug('AND value of x'+x);
            //Left shift operator
            a<<=b;
            system.debug('Shift value of a to left' + a);
            //right shift operator
            a>>=b;
            system.debug('shift value of a to right' + a);
            // unsigned shift right operator
            a>>>=b;
            system.debug('shift value of unsigned a to right' + a);
            // equality operator returns boolean value
            system.debug('value of a is equal to b'+ (a==b));
            //less than operator
            system.debug('value of a is less than be to b' + (a<b));
            // greater than operator 
            system.debug('value of a is greater than be to b' + (a>b));
            // less than or equal to operator
            system.debug('value of a is less than be to b' + (a<=b));
            //Not equal to operator
            system.debug('value of a is not equal  b' + (a!=b));
            // addition operator
            system.debug('adding value of a and b' + (a+b));
            //Increment operator
            system.debug('post increment value of a' + a++);
            system.debug('pre increment value of a' + ++a);
            system.debug('post decrement value of a'+ a--);
            system.debug('pre decerement value of a' + --a);
            


        }
        public static void  implementSafeNavigation(){
            //With out safe navigation
             list<Account> acclist=[SELECT Id,Name FROM Account WHERE Name='Owais'LIMIT 1];
             if(!acclist.isEmpty()){
                 String acc=acclist[0].Name;
                 system.debug('Account Name is : :' +acclist.size());
				 //With Safe navigation
            String accName=[SELECT Id,Name FROM Account WHERE Name='Owais'LIMIT 1]?.Name;
            system.debug('This is the account name ::  '+accName);
            map<Id,Student__c> StdMap=new map<Id,Student__c>([SELECT Id,Name FROM Student__c WHERE Name='Mohd Owais' LIMIT 1]);
            List<Student__c> StdList=[SELECT Id,Name FROM Student__c];
            for(Student__c Std :StdList){
                String StdFoundName=StdMap.get(Std.Id)?.Name;
                System.debug('This is the Name of Student : : :' + StdFoundName);
            }
        }
        public static void implementComments(){
            Integer a=1;//This comment is ignore by praser
            Integer i = 1; /* This comment can wrap over multiple
                  lines without getting interpreted by the 
                  parser. */
        }
        public static void implementRulesofConversion(){
            Long MillsPerYear = 365L * 24L * 60L * 60L * 1000L;
            Long ExpectedValue = 31536000000L;
            System.assertEquals(MillsPerYear, ExpectedValue);
        }

            

}