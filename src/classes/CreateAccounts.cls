global class CreateAccounts implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }

    global void execute(Database.BatchableContext bc, List<Account> accts) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 1; i < 10000; i++) {
            Account a = new Account(
                    Name = 'BatchAccount' + i);
            accounts.add(a);
        }
        insert accounts;
    }
    global void finish(Database.BatchableContext bc) {
        Integer numAcc = [SELECT COUNT() FROM Account LIMIT 50000];
        if (numAcc<50000){
            Id batchProcessId = Database.executeBatch(new CreateAccounts(),2000);
        }
    }
}

