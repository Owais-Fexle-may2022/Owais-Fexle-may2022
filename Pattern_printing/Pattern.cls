public class Pattern {
   /// public class PatternPrinting {
        static void Pattern1(){
             no of row is 9
             no of column is 5
             formula is 2*n-1
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
       //  }
     }
     // second pattern2
     Integer n1=1,n2=7,count=0;
     String s='';
     for(Integer row=0;row<5;row++)
     {
          s='';
         for(Integer col=0;col<9;col++)
         {
             if(row==0){
            //System.debug('*');
            s=s+'*';
         }
             else{
                 if(col==n1||col==n2)
                 {
                         // System.debug(s+'*');
                        s=s+'*';
                         count++;
                 }
                 else
                 {
                     // System.debug(s+'');
                    s=s+'_';    
                 }
             }
     
         }
         // if(n1<=5)
         System.debug(s);
         //remember that % operator is not valid for apex
         Integer result=math.mod(count,2);
         if(result==0&&count>0)
         {
             n1++;
             n2--;
             count=0;
         }
     }

}