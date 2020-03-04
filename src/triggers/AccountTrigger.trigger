/**
 * Created by e.pugach on 4.03.20.
 */
trigger AccountTrigger on Account (after insert, after update ) {
    new AccountTriggerHandler().run();
}