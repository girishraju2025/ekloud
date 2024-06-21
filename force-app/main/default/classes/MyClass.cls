public class MyClass {
	 static {
         System.debug('Hi am from the Static block');
     }
    
    {
        System.debug('Hi am from the instance/object block');
    }
    
    public MyClass(){
        System.debug('Hi am from the constructor class');
    }
}