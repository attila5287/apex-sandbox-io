@isTest
public class DMLPracticeTest {
 
    @isTest
    public static void dmlUpdate_3Test() {
        Account acc = new Account();
        acc.Name = 'Ninjas Updated';
        insert acc;

        Opportunity opp = new Opportunity();
        opp.Name= 'Opp Insert';
        opp.StageName= 'Prospecting';
        opp.CloseDate= Date.today();
        insert opp;

        DMLPractice.dmlUpdate_3();

        System.assertEquals(250000, opp.Amount);
        System.assertEquals(acc.Id, opp.AccountId);
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



}
