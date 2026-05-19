trigger CaseTrigger on Case (before update) {

    CaseEscalationSystem.processCases(
        Trigger.new,
        Trigger.oldMap
    );

}