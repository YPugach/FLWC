public with sharing class AccountTriggerHandler extends TriggerHandler{
    protected override void afterInsert() {
        searchMinMax(Trigger.new);
    }

    protected override void afterUpdate() {
        searchMinMax(Trigger.new);
    }
    public static void searchMinMax(List<Account> accounts){
        List<Account> accounts2= new List<Account>([SELECT Id, Input_Number__c, Output_String__c FROM Account WHERE Id=:accounts]);
        for(Account a :accounts2){
            Integer numb = Integer.valueOf(a.Input_Number__c.round());
            String str = String.valueOf(numb);
            List<String> strings =str.split('');
            List<Integer> integers = new List<Integer>();
            for (String s :strings){
                Integer i = Integer.valueOf(s);
                integers.add(i);
            }
            integers.sort();
            System.debug(integers);
            String minim = String.valueOf(integers[0]);
            String maxim = String.valueOf(integers[(integers.size()-1)]);
            a.Output_String__c = 'Maximal numeral : '+maxim+', minimal numeral : '+minim;
        }
        update accounts2;
    }


}