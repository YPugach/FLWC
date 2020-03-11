global class CreateTenThousandAccounts implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account LIMIT 1');
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
//        System.scheduleBatch(new CreateTenThousandAccounts(),'New Batch Job - ' + Datetime.now().getTime(),5);
    }
}