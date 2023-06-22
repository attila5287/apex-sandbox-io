@isTest
public class DMLPracticeTest {
    @isTest
    public static void dmlInsert_1Test() {
        DMLPractice.dmlInsert_1();
        List<Account> listAcc = [
            SELECT Id, Name, Phone, Rating
            FROM Account
            WHERE Name='Ninjas'
        ];
        System.assertEquals(1, listAcc.size());
        System.assertEquals('Ninjas', listAcc[0].Name);
        System.assertEquals('719-242-1262', listAcc[0].Phone);
        System.assertEquals('Hot', listAcc[0].Rating);
    }

    @isTest
    public static void dmlUpdate_1Test() {
        Account acc = new Account();
        acc.Name = 'Ninjas';
        insert acc;

        DMLPractice.dmlUpdate_1();
        List<Account> listAcc = [
            SELECT  ID, Name
            FROM Account
            WHERE Name = 'Ninjas Updated'
        ];

        System.assertEquals(1, listAcc.size());
        System.assertEquals('Ninjas Updated', listAcc[0].Name);
    }
    
    @isTest
    public static void dmlUpdate_2Test() {
        Account acc = new Account();
        acc.Name = 'Ninjas Updated';
        insert acc;
        
        DMLPractice.dmlUpdate_2();


        List<Contact> con = [
            SELECT Id, FirstName, LastName, AccountId
            FROM Contact
            WHERE FirstName='John'
        ];

        System.assertEquals(1, con.size());
        System.assertEquals('Doe', con[0].LastName);
        System.assertEquals(acc.Id, con[0].AccountId);
    }

    @isTest
    public static void dmlInsert_2Test() {
        DMLPractice.dmlInsert_2();

        List<Opportunity> opps = [
            SELECT Id, Name, StageName, CloseDate
            FROM Opportunity
            WHERE Name = 'Opp Insert'
        ];

        System.assertEquals(1, opps.size());
        System.assertEquals('Prospecting', opps[0].StageName);
        System.assertEquals(Date.today(), opps[0].CloseDate);
    }

    @isTest
    public static void dmlUpdate_3Test() {
        Account acc = new Account();
        acc.Name = 'Ninjas Updated';
        acc.Phone = '719-242-1262';
        acc.Rating = 'Hot';
        insert acc;

        Opportunity opp = new Opportunity();
        opp.Name= 'Opp Insert';
        opp.StageName= 'Prospecting';
        opp.CloseDate= Date.today();
        insert opp;

        DMLPractice.dmlUpdate_3();

        System.assertEquals(acc.Id, opp.AccountId);
        System.assertEquals(250000, opp.Amount);
    }

    @isTest
    public static void createNewLeadTest() {
        DMLPractice.createNewLead();
        List<Lead> leads = [
            SELECT Id, Company, FirstName 
            FROM Lead 
            WHERE LastName = 'Elway'
        ];
        System.assertEquals(1, leads.size());
    }

    @isTest
    public static void updateExistingLeadTest() {
        Lead lead = new Lead();
        lead.FirstName = 'John';
        lead.LastName = 'Elway';
        lead.Company = 'Ninjas';
        insert lead;

        DMLPractice.updateExistingLead();

        System.assertEquals('Working - Contacted', lead.Status);
    }

    @isTest
    public static void multInsertTest() {
        DMLPractice.multInsert();

        List<Account> accs = [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE 'Ninja ForLoop%'
        ];

        System.assertEquals(7, accs.size());
    }

    @isTest
    public static void multUpdateTest() {
        DMLPractice.multInsert();
        DMLPractice.multUpdate();

        List<Account> accs = [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE '%Updated'
        ];
        System.assertEquals(7, accs.size());
    }

    @isTest
    public static void insertMultLeads() {
        DMLPractice.insertMultLeads();

        List<Lead> leads = 
        [
            SELECT Id, FirstName, LastName, Company
            FROM Lead
            WHERE Company LIKE 'ABC Inc Region%'
        ];

        System.assertEquals(5, leads.size());
    }
    
    @isTest
    public static void updateMultLeadsTest() {
        DMLPractice.insertMultLeads();
        DMLPractice.updateMultLeads();
        
        List<Lead> leads = 
        [
            SELECT Id, FirstName, LastName, Company
            FROM Lead
            WHERE Company LIKE 'ABC Inc General%'
        ];
    
        System.assertEquals(5, leads.size());
    }

    @isTest
    public static void deleteRecordsTest() {
        List<Account> accs = new List<Account>();
        for (Integer i = 1; i < 8; i++) {
            String accName = 'Ninja ForLoop'+i;
            Account acc = new Account(Name = accName);
            accs.add(acc);
        }
        insert accs;
        DMLPractice.deleteRecords();
        
        List<Account> accs2 = [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE 'Ninja ForLoop%'
        ];
        System.assertEquals(0, accs2.size());
    }
    
    @isTest
    public static void insertContactsTest() {
        DMLPractice.insertContacts();
        List<Contact> cons = [
            SELECT Id, LastName, FirstName
            FROM Contact
            WHERE LastName LIKE 'Contact%'
        ];
        System.assertEquals(5, cons.size());
    }

    @isTest
    public static void deleteContactsTest() {
        DMLPractice.insertContacts();
        DMLPractice.deleteContacts();
        List<Contact> cons = [
            SELECT Id, LastName
            FROM Contact
            WHERE FirstName LIKE 'Ninja%'
        ];
        System.assertEquals(0, cons.size());
    }

    @isTest
    public static void lastDeletedContactsTest() {
        List<Contact> cons = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            Contact con = new Contact();
            con.LastName = 'Contact'+i;
            con.FirstName = 'Ninja'+i;
            cons.add(con);
        }
        insert cons;
        DMLPractice.deleteContacts();
        
        List<Contact> consDeleted = DMLPractice.lastDeletedContacts();

        System.assertNotEquals(0, consDeleted.size());
    }

    @isTest
    public static void undeleteAccountsTest() {
        List<Account> accs = new List<Account>();
        for (Integer i = 1; i < 8; i++) {
            String accName = 'Ninja ForLoop'+i;
            Account acc = new Account(Name = accName);
            accs.add(acc);
        }
        insert accs;
        DMLPractice.deleteRecords();
        DMLPractice.undeleteAccounts();
        List<Account> deletedAccs = [
            SELECT Name
            FROM Account
            WHERE IsDeleted=TRUE ALL ROWS
        ];
        System.assertEquals(0, deletedAccs.size());
    }

    @isTest
    public static void undeleteContactsTest() {
        DMLPractice.deleteContacts();
        DMLPractice.undeleteContacts();
        List<Contact> deletedCons = [
            SELECT FirstName, LastName
            FROM Contact
            WHERE IsDeleted=TRUE ALL ROWS
        ];
        System.assertEquals(0, deletedCons.size());
    }

    @isTest
    public static void addDescOppTest() {
        Opportunity opp = new Opportunity();

        opp.Name= 'Opp Insert';
        opp.StageName= 'Prospecting';
        opp.CloseDate= Date.today();
        opp.Amount= 50001;
        insert opp;        
        
        DMLPractice.addDescOpp();
        
        List<Opportunity> opps = [
            SELECT Id, Amount,Description
            FROM Opportunity
            // WHERE Description LIKE 'Focus On%'
        ];

        System.assertNotEquals(0, opps.size());
    }

    @isTest
    public static void annualRevenueTest() {
        List<Account> accs = new List<Account>();
        Account acc1 = new Account();
                acc1.Name = 'Test1';
                acc1.AnnualRevenue = 500000001;
                acc1.Rating = 'Cold';
        Account acc2 = new Account();
                acc2.Name = 'Test2';
                acc2.AnnualRevenue = 1000000001;
                acc2.Rating = 'Warm';
        Account acc3 = new Account();
                acc3.Name = 'Test3';
                acc3.AnnualRevenue = 400000000;
                acc3.Rating = 'Hot';

        accs.add(acc1);
        accs.add(acc2);
        accs.add(acc3);
        insert accs;

        DMLPractice.annualRevenue();

        List<Account> accs2 = [
            SELECT Id, AnnualRevenue, Rating
            FROM Account
        ];
        
        for (Account acc : accs2) {
            if (acc.AnnualRevenue > 1000000000) {
                System.assertEquals('Hot', acc.Rating);
            } else if (acc.AnnualRevenue > 500000000) {
                System.assertEquals('Warm', acc.Rating);
            } else {
                System.assertEquals('Cold', acc.Rating);
            }
        }
    }



}
