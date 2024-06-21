public class ContactTriggerHandler {

    public static void handleAfterInsert(Map<Id,Contact> newRecordsMap){
 		ContactTriggerHelper.countTotalNumberofContacts(newRecordsMap);
    }
    
    public static void handleAfterUndelete(Map<Id,Contact> newRecordsMap){
 		ContactTriggerHelper.countTotalNumberofContacts(newRecordsMap);
    }
     
    public static void handleAfterDelete(Map<Id,Contact> oldRecordsMap){
        //Trigger.old, Trigger.oldMap
 		ContactTriggerHelper.countTotalNumberofContacts(oldRecordsMap);
    }
    
    public static void handleAfterUpdate(Map<Id,Contact> newMapRec, Map<Id,Contact> oldMapRec){
    	 ContactTriggerHelper.countNumberofContactsUpdate(newMapRec,oldMapRec);        
    }
    
}