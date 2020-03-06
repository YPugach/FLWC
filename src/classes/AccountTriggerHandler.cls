public with sharing class AccountTriggerHandler extends TriggerHandler {
    protected override void beforeInsert() {
        searchMinMax(Trigger.new);
    }

    protected override void beforeUpdate() {
        searchMinMax(Trigger.new);

    }
    public static void searchMinMax(List<Account> accounts) {
        for (Account a : accounts) {
            if (a.Input_Number__c!= null) {
                Integer numb = Integer.valueOf(a.Input_Number__c.round());
                if (numb == 0) {
                    a.Output_String__c = 'Maximal numeral : 0, minimal numeral : 0';
                } else {
                    Integer minim = 9;
                    Integer maxim = 0;
                    while (numb > 0) {
                        Integer remainder2 = Math.mod(numb, 10);
                        if (maxim < remainder2) {
                            maxim = remainder2;
                        }
                        if (minim > remainder2) {
                            minim = remainder2;
                        }
                        Decimal dec = numb / 10;
                        numb = Integer.valueOf(dec.round(System.RoundingMode.FLOOR));
                    }
                    a.Output_String__c = 'Maximal numeral : ' + String.valueOf(maxim) + ', minimal numeral : ' + String.valueOf(minim);
                }
            }
        }
    }
}