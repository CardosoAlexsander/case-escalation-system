public with sharing class CaseEscalationService {

    // Método responsável por processar os Cases
    public static void processCases(
        List<Case> newCases,
        Map<Id, Case> oldCases
    ) {

        // Lista de Tasks que serão inseridas
        List<Task> tasksToInsert = new List<Task>();

        // IDs dos Cases que precisam escalar
        Set<Id> caseIds = new Set<Id>();


        /*
         * LOOP 1
         * Descobre quais Cases precisam de escalonamento
         */
        for (Case newCase : newCases) {

            // Busca o valor antigo do Case
            Case oldCase = oldCases.get(newCase.Id);

            // Verifica se a prioridade mudou para High
            if (
                newCase.Priority == 'High' &&
                oldCase.Priority != 'High'
            ) {

                // Adiciona o ID do Case no Set
                caseIds.add(newCase.Id);

                // Atualiza o Status
                newCase.Status = 'Escalated';
            }
        }


        /*
         * SOQL
         * Busca Tasks já existentes para esses Cases
         */
        List<Task> existingTasks = [
            SELECT Id, WhatId
            FROM Task
            WHERE WhatId IN :caseIds
        ];


        /*
         * Set para armazenar Cases
         * que já possuem Task
         */
        Set<Id> casesWithTasks = new Set<Id>();

        for (Task existingTask : existingTasks) {

            casesWithTasks.add(existingTask.WhatId);

        }


        /*
         * LOOP 2
         * Cria Task apenas se ainda não existir
         */
        for (Case newCase : newCases) {

            Case oldCase = oldCases.get(newCase.Id);

            if (
                newCase.Priority == 'High' &&
                oldCase.Priority != 'High'
            ) {

                // Verifica se o Case NÃO possui Task
                if (!casesWithTasks.contains(newCase.Id)) {

                    Task t = new Task();

                    t.Subject = 'Urgent Case Review';
                    t.WhatId = newCase.Id;
                    t.Status = 'Not Started';
                    t.Priority = 'High';

                    tasksToInsert.add(t);
                }
            }
        }


        /*
         * DML final
         */
        if (!tasksToInsert.isEmpty()) {

            insert tasksToInsert;

        }
    }
}