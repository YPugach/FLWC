/**
 * Created by e.pugach on 9.03.20.
 */

@IsTest
private class BatchAccountsScheduleTest {
    @IsTest
    static void testBehavior() {

        Test.startTest();
        Datetime nextRunTime = System.now().addMinutes(5);
        String cronString = '' + nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' +
                nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' +
                nextRunTime.month() + ' ? ' + nextRunTime.year();
        String jobId = System.schedule('testBatchSchedule', cronString , new BatchAccountsSchedule());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobId];
        System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
        Integer countInteger = [SELECT COUNT() FROM Account LIMIT 400];
        System.assert(countInteger > 1);
    }
}
