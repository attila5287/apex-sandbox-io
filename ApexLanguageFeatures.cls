public with sharing class ApexLanguageFeatures {
    public Boolean isTypeAccount(sObject record)
    {
        /*
            #100 sObject Type Implement the method isTypeAccount(), which accepts a sObject as input and returns a true if type of input is Account object else it should return as false.
        */
        if( record == null ) {
            return false;
        } else if(String.valueOf(record.getSobjectType()).toLowerCase() == 'account' ) {
            return true;
        } else {
            return false;
        }
    }
    
    public String convert15to18DigitId(String fifteenDigit)
    {
        // #93 - Convert 15-digit ID to 18-digit ID
        if (fifteenDigit == null) {
            return '-1';
        } else if (fifteenDigit.length()==15) {
            return (Id)fifteenDigit;
        } else {
            return '-1';        
        }
        // return String.isBlank(fifteenDigit) ? null : fifteenDigit.length() !=15 ? '-1' : (Id)fifteenDigit ;    
    }
    
    public String divide(Integer a, Integer b){
        // #97 - Handle Exception
        String res = '';
        if (b == 0) {
            res = 'Divide by 0';
        }else {
            try {
                res = String.valueOf(a / b);
            } catch (Exception ex) {
                res= ex.getMessage();
            }
        }

        return res;
    }    
    // #102 - Throw An Exception ------- Start
    public List<Account> checkAccounts(List<Account> accounts)
    {
        if (accounts == null) throw new IllegalArgumentException('accounts should not be null');
        else {
            for (Account account : accounts) {
                if (account.BillingCity == null) throw new AccountException('Invalid BillingCity');
            }
            return accounts;
        }
    }
    //do not remove the following custom-defined exception
    public class AccountException extends Exception {}
    // ------------#102 - Throw An Exception END ----

    public String getAccountBillingCityWithSafeNavigation(List<Account> accounts){
        // #94 - Safe Navigation Operator
        // if (accounts[0].BillingCity == null) {
        // return null;
        // } else {
        // return accounts[0].BillingCity.toUpperCase();
        // }
       return accounts[0]?.BillingCity?.toUpperCase();
    }

    public List<String> getFieldsValue(Account acc, List<String> fields)
    {
        // #103 - Dynamic Field Values
        List<String> res = new List<String>();
        for(String field : fields){
            res.add(String.valueOf(acc.get(field)));
        }
        return res;        
    }    

    public String getAccountsInJSONFormat(List<Account> accounts){
        // #95 - Serialize sObjects
        return JSON.serialize(accounts);
    }

}
