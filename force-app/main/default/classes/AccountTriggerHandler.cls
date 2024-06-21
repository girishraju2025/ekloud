public class AccountTriggerHandler {

    //before Insert
    public static void  handleBeforeInsert(List<Account> accList){
        AccountTriggerHelper.updateAccountShippingAddress(accList);
        AccountTriggerHelper.checkDuplicateAccount(accList);
    }
   
    //before Update 
    public static void  handleBeforeUpdate(List<Account> accList){
        //AccountTriggerHelper.updateAccountShippingAddress(accList);
        //AccountTriggerHelper.checkDuplicateAccount(accList);
    }
     
    //After Insert 
    public static void  handleAfterInsert(List<Account> accList){
        AccountTriggerHelper.createAccountTasks(accList);   
    }
    
    //After Update
    public static void  handleAfterUpdate(List<Account> accList){
        //AccountTriggerHelper.createAccountTasks(accList);  
    }
     
     
}