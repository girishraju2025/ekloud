public class OpportunityTriggerHandler {

    
    //before Insert
    public static void  handleBeforeInsert(List<Opportunity> oppList){
        OpportunityTriggerHelper.calcuateDiscount(oppList);
    }
    
    public static void handleBeforeUpdate(List<Opportunity> newRecords,Map<Id,Opportunity> oldRecords){
        OpportunityTriggerHelper.amountUpdated(newRecords,oldRecords);
    }
    
}