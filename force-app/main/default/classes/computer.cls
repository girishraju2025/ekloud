public class computer {
	
    String brandName;
    public computer(String brandName){
        System.debug('Brand Name:' +brandName);
        this.brandName=brandName;
    }
    
    public void printComputerBrand(){
        System.debug('Captured Brand : '+brandName);
    }
    
}