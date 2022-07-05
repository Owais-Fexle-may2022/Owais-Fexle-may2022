public with sharing class DiscountProccessor {
    //Interface
    public interface DiscountProccessor {
        Double percentageDiscountToBeApplied();
    }
    public class premiumCustomer implements DiscountProccessor{
        //method calling
        public Double percentageDiscountToBeApplied(){
            // for premium customer,discount should be 30%
            return 0.30;
        }
    }
    //Normal customer class
    public class NormalCustomer implements DiscountProccessor{
        //Method call
        public Double percentageDiscountToBeApplied(){
            // for normal customer discount shpould be 10%
            return 0.10;
        }
    }
}
