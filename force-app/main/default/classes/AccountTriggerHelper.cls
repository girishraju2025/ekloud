public class AccountTriggerHelper {
   
    public static void checkDuplicateAccount(List<Account> newRecords){
        
        Set<String>accountNameSet=new Set<String>();
        Set<String>accountRatingSet=new Set<String>();
        
        for (Account acc:newRecords){
            accountNameSet.add(acc.Name);
            accountRatingSet.add(acc.Rating);
        }
        
        List<Account> existingAccountList=[SELECT Name,Rating 
                                           FROM Account 
                                           WHERE Name IN:accountNameSet
                                           AND Rating IN:accountRatingSet
                                  		   AND Id NOT IN :newRecords];
            
        
        For (Account acc:newRecords){
            for(Account extAcc:existingAccountList){
                if(acc.Name == extAcc.Name && acc.Rating==extAcc.Rating){
                    acc.addError('Duplicate account already exist with same name and rating');
                    acc.Name.addError('Duplicate account already exists with same name and rating');
                    acc.Rating.addError('Duplicate account already exist with same name and rating');
                }  
            }           
        }
        
    }
    
    public static void updateAccountShippingAddress(List<Account> accList){
            for(Account acc:accList){//Id is not generated in case of before insert
        acc.Industry='Education';
        
        if(acc.ShippingStreet==NULL){
            acc.shippingStreet=acc.billingStreet;
        }
        if(acc.shippingCity==NULL){
            acc.shippingCity=acc.billingCity;
        }
        if(acc.shippingState==NULL){
            acc.shippingState=acc.billingState;
        }
        if(acc.shippingPostalCode==NULL){
            acc.shippingPostalCode=acc.billingPostalCode;
        }
        if(acc.shippingCountry==NULL){
            acc.shippingCountry=acc.billingCountry;
        }              
        if(acc.description==NULL){
            acc.Description='Account Description is Blank';
        }      
   	 }
    }
    
    public static void createAccountTasks(List<Account> accList){
         
        List<task> taskList=new List<task>();
        List<Messaging.SingleEmailMessage> emailMessages=new List<Messaging.SingleEmailMessage>();
        List<Account> newAccountList=[SELECT Id,Name,Phone,Industry,OwnerId,Owner.Name,Owner.Email FROM Account WHERE Id IN: accList];
        
        System.debug('newAccountlist : '+newAccountList);
            for(Account acc: newAccountList){
                if(acc.Phone == null && acc.Industry == null){
                    	task taskrec=new task();
                        taskrec.Subject='Created from Apex Trigger';
                        taskrec.Description='Created from Apex Trigger';
                        taskrec.Status='Not Started';
                        taskrec.Priority='High';
                        taskrec.ActivityDate = System.today()+7;
                        taskrec.WhatId=acc.Id;
                        taskrec.OwnerId=acc.OwnerId;
                        taskList.add(taskrec);
                    	System.debug('TaskRec : '+taskrec);
                    
                    //Requirement 2 to Send email   
                		Messaging.SingleEmailMessage email=new Messaging.SingleEmailMessage();
                    	email.setSubject('New Account '+acc.Owner.Name+' has been assigned!');
                    	String emailBody='Dear Account Owner, <br/>';
                    	emailBody+='A new account '+acc.Name+' has been created in Salesforce.<br/><br/>';
                    	emailBody+='Please try to collect this information and update the account ASAP<br/><br/><br/>';
                    	emailBody+='Thanks and Regards<br/><br/>';
                    	emailBody+='RG Infotech';
                    	
                    	//email.setPlainTextBody(emailBody);
                    	email.setHtmlBody(emailBody);
						List<String> toAddress=new List<String>();
                    	//Lead/Contact/User - we can use email/Id
                    	toAddress.add(acc.OwnerId);
                    	email.setToAddresses(toAddress);
                    
                    	List<String> toBccAddress=new List<String>();
                    	toBccAddress.add('girishraju2024@gmail.com');
                    	email.setBccAddresses(toBccAddress);
                    
                    	//Preapare the attachment and send along with the email
                    	Messaging.EmailFileAttachment attach=new Messaging.EmailFileAttachment();
                    	attach.setFileName('RGInfoAttachment.txt');	
                   		Blob textbody = blob.valueOf('This sample attachment file for testing in salesforce');                    	
                    	attach.setBody(textbody);
                    
                    	List<Messaging.EmailFileAttachment> fileAttachments=new List<Messaging.EmailFileAttachment>();
                    	fileAttachments.add(attach);
                    	email.setFileAttachments(fileAttachments);
                    	email.setReplyTo('girishdev27@gmail.com');
                    	email.setSenderDisplayName('RGInfotech and Consultancy');
        				emailMessages.add(email); 
                    
                
                }
                //end if
              
            }
        	//end for
        	system.debug('taskList after:' +taskList);
            insert taskList;
        
        	List<Messaging.SendEmailResult> sendEmailResults=Messaging.sendEmail(emailMessages,false);
        	for(Messaging.SendEmailResult sr: sendEmailResults){
            	boolean isSuccess=sr.isSuccess();
                if(isSuccess){
                    	System.debug('Email Sent Successfully');
                }else{
                    	System.debug('Error Sending Email');
                        List<Messaging.SendEmailError> errors=sr.getErrors();
                        System.debug(errors);
                    }
                }
        	}
        
}