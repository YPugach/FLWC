@IsTest
private class CreateAccountsTest {
    @IsTest
    static void testBatch() {
        Test.startTest();
        CreateAccounts ca = new CreateAccounts();
        Id batchId = Database.executeBatch(ca, 2000);
        Test.stopTest();
    }
}
