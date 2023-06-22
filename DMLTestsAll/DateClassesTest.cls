@isTest
public class DateClassesTest {
    @isTest
    public static void addDaysTest() {
        Date result = Date.newInstance(2023, 3, 31);
        Date actual = DateClasses.addDays(4);
        System.assertEquals(result, actual);
    }
    
    @isTest
    public static void addMonthsTest() {
        Date result = Date.newInstance(2023, 6, 27);
        Date actual = DateClasses.addMonths();
        System.assertEquals(result, actual);
    }

    @isTest
    public static void addYearsTest() {
        Date result = Date.newInstance(2026, 3, 27);
        Date actual = DateClasses.addYears();
        System.assertEquals(result, actual);
    }



}
