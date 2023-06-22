@isTest
public class AwardHandlerTest {
    @isTest
    public static void medalTypeTest() {
        String result = AwardHandler.medalType(1);
        System.assertEquals('G O L D', result);
        System.assertEquals('Silver', AwardHandler.medalType(2));
        System.assertEquals('Bronze', AwardHandler.medalType(3));
        System.assertEquals('Try again...', AwardHandler.medalType(0));
        System.assertEquals('Try again...', AwardHandler.medalType(4));
        System.assertEquals('Try again...', AwardHandler.medalType(-1));
        System.assertEquals('Try again...', AwardHandler.medalType(10));
    }    
    @isTest
    public static void medalFinderTest() { 
        String result = AwardHandler.medalFinder(1);
        System.assertEquals('G O L D', result);
        // System.assertEquals('G O L D', AwardHandler.medalFinder(1));
        System.assertEquals('Silver', AwardHandler.medalFinder(2));
        System.assertEquals('Bronze', AwardHandler.medalFinder(3));
        System.assertEquals('Try again...', AwardHandler.medalFinder(0));
        System.assertEquals('Try again...', AwardHandler.medalFinder(4));
        System.assertEquals('Try again...', AwardHandler.medalFinder(-1));
        System.assertEquals('Try again...', AwardHandler.medalFinder(10));

        
    }

}
