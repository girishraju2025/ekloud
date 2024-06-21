public class AccountTriggerDispatcher {

    //Trigger.OperationType
    //AFTER_INSERT,BEFORE_INSERT,AFTER_UPDATE,BEFORE_UPDATE,AFTER_DELETE,BEFORE_DELETE,
    //System.TriggerOperation = Trigger.OperationType
    
    public static void dispatch(System.TriggerOperation operationType){
        switch on operationType{
            WHEN BEFORE_INSERT{
                // AccountTriggerHandler.handleBeforeInsert(Trigger.new);
            }
            WHEN AFTER_INSERT{
                 AccountTriggerHandler.handleAfterInsert(Trigger.new);
            }
            WHEN BEFORE_UPDATE{
                 //AccountTriggerHandler.handleBeforeUpdate(Trigger.new); 
            }
            WHEN AFTER_UPDATE{

            }
            WHEN BEFORE_DELETE{
                
            }
            WHEN AFTER_DELETE{
                
            }
            WHEN AFTER_UNDELETE{
                
            }
            WHEN ELSE{
                
            }            
        }
    }
}