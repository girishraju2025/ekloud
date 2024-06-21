public class ContactTriggerDispatcher {
	//Trigger.OperationType
    //AFTER_INSERT,BEFORE_INSERT,AFTER_UPDATE,BEFORE_UPDATE,AFTER_DELETE,BEFORE_DELETE,
    //System.TriggerOperation = Trigger.OperationType
    
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            
            WHEN BEFORE_INSERT{
                
            }
            WHEN AFTER_INSERT{
               ContactTriggerHandler.handleAfterInsert((Map<Id,Contact>) Trigger.newMap);
            }
            WHEN BEFORE_UPDATE{
                 
             
            }
            WHEN AFTER_UPDATE{
				ContactTriggerHandler.handleAfterUpdate((Map<Id,Contact>) Trigger.newMap, (Map<Id,Contact>) Trigger.oldMap);
            }
            WHEN BEFORE_DELETE{
                
            }
            WHEN AFTER_DELETE{
               ContactTriggerHandler.handleAfterDelete((Map<Id,Contact>) Trigger.oldMap);  
            }
            WHEN AFTER_UNDELETE{
              ContactTriggerHandler.handleAfterUndelete((Map<Id,Contact>) Trigger.newMap);   
            }
            WHEN ELSE{
                
            }
            
        }
    }
}