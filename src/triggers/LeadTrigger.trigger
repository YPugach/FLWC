/**
 * Created by e.pugach on 18.02.20.
 */
trigger LeadTrigger on Lead (before insert, before update, after insert, after update ) {
    if (Trigger.isBefore && Trigger.isInsert) {
        LeadTriggerHandler.beforeInsert(Trigger.new);

    } else if (Trigger.isBefore && Trigger.isUpdate) {
        LeadTriggerHandler.beforeUpdate(Trigger.new);

    } else if (Trigger.isAfter && Trigger.isInsert) {
        LeadTriggerHandler.afterInsert(Trigger.new);

    } else if (Trigger.isAfter && Trigger.isUpdate) {
        LeadTriggerHandler.afterUpdate(Trigger.new, Trigger.old);
    }
}