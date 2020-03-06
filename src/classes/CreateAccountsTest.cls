@IsTest
private class CreateAccountsTest {
    @IsTest
    static void testBacth() {
        Test.startTest();
        CreateAccounts ca = new CreateAccounts();
        Id batchId = Database.executeBatch(ca, 200);
        Test.stopTest();
    }
}
