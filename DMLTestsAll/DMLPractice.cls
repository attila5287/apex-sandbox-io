public with sharing class DMLPractice {
    public static void dmlInsert_1() {
        Account acc = new Account();

        acc.Name = 'Ninjas';
        acc.Phone = '719-242-1262';
        acc.Rating = 'Hot';

        insert acc;
    }

    public static void dmlUpdate_1() {
        System.debug(' ---- DML UPDATE RUNNING ----');
        
        Account acc = [
            SELECT Id, Name, Phone, Rating
            FROM Account
            WHERE Name = 'Ninjas'
            LIMIT 1
        ];

        acc.Name = 'Ninjas Updated';
        acc.Rating = 'Warm';
        acc.Phone = '720-710-6443';

        update acc;
        System.debug(' ---- SUCCESS ----');
    }

    public static void dmlUpdate_2() {
        System.debug(' --- dmlUpdate_2 Running ---');       
        Account acc = [ 
            SELECT Id, Name
            FROM Account
            WHERE Name = 'Ninjas Updated'
            LIMIT 1
        ];
        
        Contact con = new Contact();

        con.FirstName = 'John';
        con.LastName = 'Doe';
        con.AccountId = acc.Id;

        insert con;
        System.debug(' --- SUCCESS ---');       
    }

    public static void dmlInsert_2() {
        System.debug('--- dmlInsert_2 ---');

        Opportunity opp = new Opportunity();

        opp.Name= 'Opp Insert';
        opp.StageName= 'Prospecting';
        opp.CloseDate= Date.today();

        insert opp;
        System.debug('--- success ---');
    }

    public static void dmlUpdate_3() {
        // Account acct = new Account();
        // acct.Name = 'Ninjas Updated';
        // acct.Phone = '719-242-1262';
        // acct.Rating = 'Hot';
        // insert acct;

        List<Account> acc = [
            SELECT Id, Name
            FROM Account
            WHERE Name = 'Ninjas Updated'
        ];
        
        List<Opportunity> opp = [
            SELECT Id, Name
            FROM Opportunity
            WHERE Name = 'Opp Insert'
        ];

        opp[0].Amount = 250000;
        opp[0].AccountId = acc[0].Id;

        update opp;
        System.debug(' --- SUCCESS --- ');
    }
    
    // 1. Write a method which creates new Lead.
    public static void createNewLead() {
        Lead ld = new Lead();
        ld.Company = 'Denver Ninjas Inc';
        ld.FirstName = 'John';
        ld.LastName = 'Elway';
        
        insert ld;
        System.debug(' --- SUCCESS ---');
    }

    // 2. Write a method which updates the leads status    
    public static void updateExistingLead() {
        List<Lead> ld = [
            SELECT Status
            FROM Lead
            WHERE FirstName = 'John' AND LastName = 'Elway'
        ];
        ld[0].Status = 'Working - Contacted';
        update ld;
        System.debug(' --- success ---');
    }
    
    public static void multInsert() {
        List<Account> accs = new List<Account>();
        for (Integer i = 1; i < 8; i++) {
            String accName = 'Ninja ForLoop'+i;
            Account acc = new Account(Name = accName);
            accs.add(acc);
        }
        insert accs;
    }

    public static void multUpdate() {
        List<Account> accs = [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE 'Ninja%'
        ];
        
        for (Account acc : accs) {
            acc.Name = acc.Name+ ' Updated';
        }

        update accs;
        
        System.debug('success');
    }

    public static void insertMultLeads() {
        List<Lead> leads = new List<Lead>();
        Lead ld1 = new Lead(LastName='Doe 1',FirstName='John',Company='ABC Inc Region 1');
        Lead ld2 = new Lead(LastName='Doe 2',FirstName='John',Company='ABC Inc Region 2');
        Lead ld3 = new Lead(LastName='Doe 3',FirstName='John',Company='ABC Inc Region 3');
        Lead ld4 = new Lead(LastName='Doe 4',FirstName='John',Company='ABC Inc Region 4');
        Lead ld5 = new Lead(LastName='Doe 5',FirstName='John',Company='ABC Inc Region 5');
        leads.add(ld1);
        leads.add(ld2);
        leads.add(ld3);
        leads.add(ld4);
        leads.add(ld5);
        insert leads;
        System.debug('success');
    }

    public static void updateMultLeads() {
        List<Lead> leads = [
            SELECT Id, Company
            FROM Lead
            WHERE Company LIKE 'ABC%'
        ];
        for (Lead ld : leads) {
            ld.Company = 'ABC Inc General';
        }
        update leads;
        System.debug('success');
    }
    
    public static void deleteRecords() {
        List<Account> accs = [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE 'Ninja%'
        ];
        delete accs;
        System.debug('success');
    }

    public static void insertContacts() {
        List<Contact> cons = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact();
            con.LastName = 'Contact'+i;
            con.FirstName = 'Ninja'+i;
            cons.add(con);
        }
        insert cons;
        System.debug('success');
    }

    public static void deleteContacts() {
        List<Contact> cons = [
            SELECT Id, LastName
            FROM Contact
            WHERE FirstName LIKE 'Ninja%'
        ];
        delete cons;
        System.debug('success');
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
    
    public static void undeleteAccounts() {
        List<Account> deletedAccs = [
            SELECT Name
            FROM Account
            WHERE IsDeleted=TRUE ALL ROWS
        ];
        undelete deletedAccs;
        System.debug('success');
    }
    
    public static void undeleteContacts() {
        List<Contact> deletedCons = [
            SELECT FirstName, LastName
            FROM Contact
            WHERE IsDeleted=TRUE ALL ROWS
        ];
        undelete deletedCons;
        System.debug('success');
    }

    public static void addDescOpp() {
        List<Opportunity> opps = [
            SELECT Amount
            FROM Opportunity
            WHERE Amount>50000
        ];
        for (Opportunity opp : opps) {
            opp.Description = 'Focus On';
        }
        update opps;
    }
    
    public static void annualRevenue() {
        List<Account> accs = [
            SELECT AnnualRevenue
            FROM Account
        ];

        for (Account acc : accs) {
            if (acc.AnnualRevenue > 1000000000) {
                acc.Rating = 'Hot';
            } else if (acc.AnnualRevenue > 500000000) {
                acc.Rating = 'Warm';
            } else {
                acc.Rating = 'Cold';
            }
        }
        
        update accs;
    }

    
}

