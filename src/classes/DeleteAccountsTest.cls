/**
 * Created by e.pugach on 6.03.20.
 */

@IsTest
private class DeleteAccountsTest {
    @IsTest
    static void testBehavior() {
        List<Account> accounts = TestDataGenerator.createManyAccounts(1000);
        Test.startTest();
        Id batchid = Database.executeBatch(new DeleteAccounts(), 1000);
        Test.stopTest();
        Integer acc = [SELECT COUNT() FROM Account];
        System.assertEquals(acc,0);
    }
}