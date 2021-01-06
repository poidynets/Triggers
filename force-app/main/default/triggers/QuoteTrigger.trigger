trigger QuoteTrigger on Quote (before update) {
    if (Trigger.isUpdate) {
        QuoteTriggerHandler.beforeUpdate(Trigger.old, Trigger.new);
    }
}