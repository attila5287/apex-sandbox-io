public class AwardHandler {
    public static String medalType(Integer place) {
        System.debug('medal Type');
        if (place == 1) {
            System.debug('G O L D');
            return 'G O L D';
        } else if (place == 2) {
            System.debug('Silver');
            return 'Silver';
        } else if (place ==3) {
            System.debug('Bronze');
            return 'Bronze';
        } else {
            System.debug('Try again...');
            return 'Try again...';
        }
    }

    public static String medalFinder(Integer place) {
        System.debug('medal Finder');
        String result = '';
        switch on place {
            when  1{
                System.debug('G O L D');
                result= 'G O L D';
            }
            when  2{
                System.debug('Silver');
                result= 'Silver';
            }
            when  3{
                System.debug('Bronze');
                result= 'Bronze';
            }
            when  else{
                System.debug('Try again...');
                result= 'Try again...';
            }
        }
        return result;
        
    }

}
