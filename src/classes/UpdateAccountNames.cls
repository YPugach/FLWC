/**
 * Created by e.pugach on 5.03.20.
 */
global class UpdateAccountNames implements Database.Batchable<SObject>{
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }
    global void execute(Database.BatchableContext bc, List<Account> accounts){
        for(Account a :accounts){
            a.Name = a.Name + ' Updated';
        }
        update accounts;
    }
    global void finish(Database.BatchableContext bc){
    }
}