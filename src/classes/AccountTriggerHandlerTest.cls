/**
 * Created by e.pugach on 4.03.20.
 */

@IsTest
private class AccountTriggerHandlerTest {
    @IsTest
    static void searchMinMaxTest() {
        Account acc = TestDataGenerator.createAccount(15846273);
        Test.startTest();
        Account acc2 = [SELECT Id,Input_Number__c,Output_String__c FROM Account WHERE Id=:acc.Id];
        System.assertEquals(acc2.Output_String__c,'Maximal numeral : 8, minimal numeral : 1');
        Test.stopTest();
    }
    @IsTest
    static void searchMinMaxUpdateTest() {
        Account acc = TestDataGenerator.createAccount(15846273);
        Test.startTest();
        acc.Input_Number__c =57743243;
        update acc;
        Account acc2 = [SELECT Id,Input_Number__c,Output_String__c FROM Account WHERE Id=:acc.Id];
        System.assertEquals(acc2.Output_String__c,'Maximal numeral : 7, minimal numeral : 2');
        Test.stopTest();
    }
    @IsTest
    static void searchMinMaxFromZero() {
        Account acc = TestDataGenerator.createAccount(0);
        Test.startTest();
        Account acc2 = [SELECT Id,Input_Number__c,Output_String__c FROM Account WHERE Id=:acc.Id];
        System.assertEquals(acc2.Output_String__c,'Maximal numeral : 0, minimal numeral : 0');
        Test.stopTest();
    }
}