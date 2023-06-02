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
        return (String) JSON.serialize(accounts);
    }

    public List<sObject> getListOfsObject(List<Account> accounts, List<Contact> contacts)
    { //#96 - Deserialize sObjects
        List<sObject> res=new List<sObject>();
        
        if (accounts!=null) {
            res.addAll(accounts);
        } 
        
        if (contacts!= null) {
            res.addAll(contacts);
        } 
        return res;
    }
    public List<Account> getAccountsFromJSONString(String inputJSON){
        // #96 - Deserialize sObjects
        if (inputJSON==null) {
            return null;
        } else {
            return (List<Account>) JSON.deserialize (inputJSON, List<Account>.class);
        }    
    }    
    
    public Map<String,String> getContextUserInformation(){
        //#106 - Context User
        Map<String, String> res =  new Map<String, String> {
              'EmailId' => UserInfo.getUserEmail(),
              'ProfileId'=> UserInfo.getProfileId(),
              'Type' => UserInfo.getUserType(),
              'UserName' => UserInfo.getUserName()
        };
        return res;
    }    
    
    public void validateInsert(List<Opportunity> opportunities){
        // #105 Trigger Validation
        /*
        Implement the method validateInsert, which accepts a newly inserted list of opportunities as an input and adds errors to the opportunity fields as follows: if the opportunity record’s StageName is Closed Won and the Description is null or empty, add an error on the Description field of that record with the error message
        */
        String msg = 'Description should not be empty for Closed Won opportunity.';
        for(Opportunity opp : opportunities) {
            if(opp.StageName == 'Closed Won') {
                if (opp.Description == '' || opp.Description == null) {
                    opp.Description.addError(msg);
                }   
            }
        } 
    }

    // ------- THE LAST QUESTION STARTS HERE -------
    public List<Account> getAccounts(List<Account> accounts) {
        // #98 - Sort List of sObjects
        if(accounts == null) {
            return null;
        } else {
            List<AccountWrapper> accsToSort = new List<AccountWrapper>();
        
            for(Account acc : accounts) {
                accsToSort.add(new AccountWrapper(acc));
            }
        
            accsToSort.sort();
        
            for(Integer i=0; i<accounts.size(); i++) {
                accounts[i] = accsToSort[i].accy;
            }
            
            return accounts;
        }
    }
    // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_list_sorting_sobject.htm
    public class AccountWrapper implements Comparable {
    
        public Account accy;
        
        // Constructor
        public AccountWrapper(Account acc) {
            // Guard against wrapping a null 
            if(acc == null) {
                Exception ex = new NullPointerException();
                ex.setMessage('Account argument cannot be null'); 
                throw ex;
            }
            accy = acc;
        }
        
        // Compare opportunities based on the Account amount.
        public Integer compareTo(Object compareTo) {
            // Cast argument to AccountWrapper
            AccountWrapper compareToAccy = (AccountWrapper)compareTo;
            
            // The return value of 0 indicates that both elements are equal.
            Integer returnValue = 0;
            if ((accy.AnnualRevenue == null) && (compareToAccy.accy.AnnualRevenue == null)) {
                // both wrappers have null AnnualRevenues
                returnValue = 0;
            } else if ((accy.AnnualRevenue == null) && (compareToAccy.accy.AnnualRevenue != null)){
                // nulls-first implementation
                returnValue = 1;
            } else if ((accy.AnnualRevenue != null) && (compareToAccy.accy.AnnualRevenue == null)){
                // nulls-first implementation
                returnValue = -1;
            } else if (accy.AnnualRevenue > compareToAccy.accy.AnnualRevenue) {
                // Set return value to a positive value.
                returnValue = -1;
            } else if (accy.AnnualRevenue < compareToAccy.accy.AnnualRevenue) {
                // Set return value to a negative value.
                returnValue = 1;
            } 
            return returnValue;
        }
    }
    // ------- THE LAST QUESTION ENDS HERE ------- 
}
