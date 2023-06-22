public class DateMethods {
    public static Integer calculateAgeInMonths() {
        Date bday = Date.newInstance(1987, 7, 8);
        Date today = Date.today();
        Integer res = bday.monthsBetween(today);
        System.debug('--------- My age in months');
        System.debug(res);
        return res;
    }
    public void calculateAgeInDays() {
        Date bday = Date.newInstance(1987, 7, 8);
        Date today = Date.today();
        Integer res = bday.daysBetween(today);
        System.debug('--------- My age in days');
        System.debug(res);
    }
    public void calculateDate() {
        Date today = Date.today();
        Date res = today.addDays(120);
        System.debug('--------- Add 120 days to Today');
        System.debug(res);
    }
    public void calculateDateTime() {
        Datetime now = Datetime.now();
        Datetime res = now.addHours(360);
        System.debug('--------- Add 360 hours to Now');
        System.debug(res);
    }
}
