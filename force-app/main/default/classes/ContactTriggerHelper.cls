public class ContactTriggerHelper {
	
    public static void countTotalNumberofContacts(Map<Id,Contact> xRecordsMap){
              
      	//Solution # 1 -Inner Query ///
     
      	//Get List of Account Ids;
      	Set<Id> accountIdSet=new Set<Id>();       
        for(Contact con:xRecordsMap.values()){
            if(con.AccountId <> NULL){
                 accountIdSet.add(con.AccountId);
            }           
        }
        
        /*
        //Solution 1 - Inner Query//
      	List<Account> accountList=new List<Account>();
        accountList=[SELECT Id,(SELECT Id FROM Contacts)FROM Account WHERE Id IN:accountIdSet];
        for(Account acc:accountList){
            List<Contact> contList= acc.CONTACTS;
            if(contList !=null){
                Integer size=contList.size();
                acc.Number_of_Contacts__c=size;
            }	
        }        
        update accountList;
        //Solution 1 - will fail incase of bulk records ( more than 50K)
       	*/
        
        
        //Solution #2 - Aggregate Query (Recommended) - SUM,COUNT,MIN,MAX
         List<AggregateResult> aggregateList= [SELECT count(Id) totalContact,AccountId FROM Contact WHERE AccountId IN:accountIdSet Group By AccountId];
        //(AggregateResult:{expr0=3, AccountId=0012w00001Pz63SAAR}) 
         //(AggregateResult:{totalContact=3, AccountId=0012w00001Pz63SAAR}) 
        
        List<Account> accUpdateList=new List<Account>();
        for(AggregateResult ag:aggregateList){
             String accountId = (String)ag.get('AccountId'); //object to we have to convert it into string
             Integer totalContacts = (Integer)ag.get('totalContact');
             Account accRec=new Account();
             accRec.id=accountId;
             accRec.Number_of_Contacts__c=totalContacts;
             accUpdateList.add(accRec);
        }
        update accUpdateList;
    }
    
    public static void countNumberofContactsUpdate(Map<Id,Contact> newMapRec, Map<Id,Contact> oldMapRec){
        Set<Id> accountIdsSet=new Set<Id>();
        for(Contact newRecord : newMapRec.values()){
            Contact oldRecord= oldMapRec.get(newRecord.Id);
            if(oldRecord.AccountId<>newRecord.AccountId){
                accountIdsSet.add(oldRecord.AccountId);
                accountIdsSet.add(newRecord.AccountId);
            }
        }
        
         
         List<AggregateResult> aggregateList= [SELECT count(Id) totalContact,AccountId 
                                               FROM Contact 
                                               WHERE AccountId IN:accountIdsSet 
                                               Group By AccountId];
      
        
        List<Account> accUpdateList=new List<Account>();
        
        for(AggregateResult ag:aggregateList){
             String accountId = (String)ag.get('AccountId'); //object to we have to convert it into string
             Integer totalContacts = (Integer)ag.get('totalContact');
             Account accRec=new Account();
             accRec.id=accountId;
             accRec.Number_of_Contacts__c=totalContacts;
             accUpdateList.add(accRec);
        }
        update accUpdateList;
    }
}