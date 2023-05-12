public with sharing class database101 {
    public Id insertStudent(String name, String email) {
        // #126 
        apxio__Student__c obj = new apxio__Student__c();
        
        obj.Name = name;
        obj.apxio__Email__c = email;
        
        insert obj;
        return obj.Id;
    }
}
