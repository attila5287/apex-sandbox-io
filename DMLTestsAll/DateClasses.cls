public class DateClasses {
    public static Date addDays(Integer d) {
        // System.debug('- - - - - - - - - d');
        Date myDate = Date.newInstance(2023, 3, 27);
        // System.debug('The actual date is: ' + myDate);
        Date newDate = myDate.addDays(d);
        // System.debug('The new date is: ' + newDate);
        return newDate;
    }
    public static Date addMonths() {
        // System.debug('- - - - - - - - - m');
        Date myDate = Date.newInstance(2023, 3, 27);
        // System.debug('The actual date is: ' + myDate);
        Date newDate = myDate.addMonths(3);
        // System.debug('The new date is: ' + newDate);
        return newDate;
    }
    public static Date addYears() {
        // System.debug('- - - - - - - - - y');
        Date myDate = Date.newInstance(2023, 3, 27);
        // System.debug('The actual date is: ' + myDate);
        Date newDate = myDate.addYears(3);
        // System.debug('The new date is: ' + newDate);
        return newDate;
    }
    
}
