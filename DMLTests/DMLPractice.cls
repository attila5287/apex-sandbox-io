public with sharing class DMLPractice {
   
    public static void dmlUpdate_3() {
        Account acc = new Account();

        acc.Name = 'Ninjas Updated';
        acc.Phone = '719-242-1262';
        acc.Rating = 'Hot';
        insert acc;        

        System.debug(' --- Acc Inserted --- ');

        // Account acc = [
        //     SELECT Id, Name
        //     FROM Account
        //     WHERE Name = 'Ninjas Updated'
        // ];
        
        Opportunity opp = [
            SELECT Id, Name
            FROM Opportunity
            WHERE Name = 'Opp Insert'
            LIMIT 1
        ];

        opp.Amount = 250000;
        opp.AccountId = acc.Id;

        update opp;
        System.debug(' --- SUCCESS --- ');
    }
   
    // 2. Write a method which updates the leads status    
    public static void updateExistingLead() {
        Lead ld = [
            SELECT Status
            FROM Lead
            WHERE FirstName = 'John' AND LastName = 'Elway'
        ];
        ld.Status = 'Working - Contacted';
        update ld;
        System.debug(' --- success ---');
    }
   
    public static List<Contact> lastDeletedContacts() {
        List<Contact> cons = [
            SELECT Id, FirstName, LastName
            FROM Contact
            WHERE IsDeleted=True
            ORDER BY Id DESC LIMIT 10
        ];
        System.debug('success');
        return cons;
    }
   

    
}

