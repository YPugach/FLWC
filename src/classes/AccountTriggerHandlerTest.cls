/**
 * Created by e.pugach on 4.03.20.
 */

@IsTest
private class AccountTriggerHandlerTest {
    @IsTest
    static void searchMinMaxTest() {
        Account acc = TestDataGenerator.createAccount(14275842);
        Test.startTest();
        Account acc2 = [SELECT Id,Input_Number__c,Output_String__c FROM Account WHERE Id=:acc.Id];
        System.assertEquals(acc2.Output_String__c,'Maximal numeral : 8, minimal numeral : 1');
        Test.stopTest();
    }
    @IsTest
    static void searchMinMaxAfterUpdateTest() {
        Account acc = TestDataGenerator.createAccount(14275842);
        Test.startTest();
        acc.Input_Number__c =85638479;
        update acc;
        Account acc2 = [SELECT Id,Input_Number__c,Output_String__c FROM Account WHERE Id=:acc.Id];
        System.assertEquals(acc2.Output_String__c,'Maximal numeral : 9, minimal numeral : 3');
        Test.stopTest();
    }
}