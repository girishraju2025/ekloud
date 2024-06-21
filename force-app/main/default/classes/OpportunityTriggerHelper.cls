public class OpportunityTriggerHelper {

    /*
    If the discount amount and discount field is not blank,then calculate the discount using the below formula
	Decimal discount = (Discount * Amount)/100
	Calculate the discounted price use the below calcualtion and store it in a variable 
	Dcimal discountedAmount = Amount - discount;
	*/
    public static void calcuateDiscount(List<Opportunity> oppList){
        
        List<Opportunity> oppLists=new List<Opportunity>();
        
        for(Opportunity opp:oppList){
            If (opp.Amount !=null && opp.Discount__c !=null){
                
                Decimal discount = (opp.Amount*(opp.Discount__c/100));
                Decimal discountedAmount=opp.Amount-discount;
                opp.Discounted_Price__c=discount;
                opp.Price_After_Discount__c=discountedAmount;
              
            }
            
        }
        
    }
    
 	public static void amountUpdated(List<Opportunity> newRecords,Map<Id,Opportunity> oldMapRecords){
        for(Opportunity newRecord:newRecords){
            Opportunity oldRecord=oldMapRecords.get(newRecord.Id);
              	 if(oldRecord.StageName=='Closed Won' && newRecord.StageName=='Closed Won' && oldRecord.Amount<>newRecord.Amount){
                        newRecord.Amount.addError('Amount can not be changed once the change is set to closed won');           
 			     }     
    	}
        
	}
    
}