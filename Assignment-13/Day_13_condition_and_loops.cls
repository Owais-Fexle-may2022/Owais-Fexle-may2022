public with sharing class Day_13_condition_and_loops {
    public Day_13_condition_and_loops(Integer Choice) {
        if(Choice==1){
            If_Else_Condition();
        }
        else if(Choice==2){
            Do_While();
        }
        else if(Choice==3){
            while_loops();
        }
        else if(Choice==4){
            For_loops();
        }
        else if(Choice==5){
            List_Set_Iteration();
        }
        else{
            system.debug('This is invalid input try again with valid input');
        }
    }

        public static void If_Else_Condition(){
            Integer value1=12,Value2=13;
            if(Value1<Value2){
                system.debug('Value1 is less than value2');
            }
            else{
                system.debug('Value2 is less than value1');
            }
            Integer x=14, sign;
            // Your code
            if (x <= 0) if (x == 0) sign = 0; else sign = -1;
            Integer place=2;
            String medal_color;
            if (place == 1) {
                medal_color = 'gold';
            } else if (place == 2) {
                medal_color = 'silver';
            } else if (place == 3) {
                medal_color = 'bronze';
            } else {
                medal_color = null;
            }
        }
        public static void Do_While(){
            Integer count = 1;
            do {
                System.debug(count);
                count++;
            } while (count < 11);
        }
        public static void while_loops(){
            Integer count = 1;
            while (count < 11) {
                System.debug(count);
                count++;
            }
        }
        public static void For_loops(){
            integer n=6;
            for(integer row=1;row<=9;row++){
                String s=' ';
                if(row<=n){
                    n--;
                }
                else{
                    n++;
                }
                for(integer col=1;col<=5;col++){
                    if(col>=n){
                        s=s+'*';
                    }
                    // else
                    // {
                    //     s=s+' ';
                    // }
                }
                System.debug(s);
            }
        }
        public static void List_Set_Iteration(){
            Integer[] myInts = new Integer[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
            for (Integer i : myInts) {
                System.debug(i);
            }
        }
}