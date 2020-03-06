/**
 * Created by e.pugach on 5.03.20.
 */

@IsTest
private class UpdateAccountNamesTest {
    @IsTest
    static void updateAccountNames() {
        Test.startTest();
        List<Account> accounts = TestDataGenerator.createManyAccounts(200) ;
        UpdateAccountNames uan = new UpdateAccountNames();
        Id batchId = Database.executeBatch(uan);
        Test.stopTest();
        List<Account> accounts2 = [SELECT Id,Name FROM Account WHERE Name LIKE '%Updated'];
        System.assertEquals(accounts2.size(),200);

    }
}