global class BatchAccountsSchedule implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Datetime now  = Datetime.now();
        Datetime nextRunTime = now.addMinutes(5);
        String cronString = '' + nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' +
                nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' +
                nextRunTime.month() + ' ? ' + nextRunTime.year();
        System.schedule( '-' + now.format(), cronString, new BatchAccountsSchedule());
        Id jobId = ctx.getTriggerId();
        System.abortJob(jobId);
        Database.executeBatch(new CreateTenThousandAccounts());

//        CreateTenThousandAccounts ctta = new CreateTenThousandAccounts();
//        Database.executeBatch(ctta);
//        CronTrigger ct = [SELECT Id, CronExpression FROM CronTrigger WHERE Id = :ctx.getTriggerId()];
//        System.abortJob(ctx.getTriggerId());
    }
}