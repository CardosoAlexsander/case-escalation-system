@isTest
public class CaseEscalationServiceTest {

    @isTest
    static void testCaseEscalation() {

        // Cria um Case com prioridade Normal
        Case testCase = new Case(
            Subject = 'Test Case',
            Priority = 'Medium',
            Status = 'New'
        );

        insert testCase;

        // Início do teste real
        Test.startTest();

        // Atualiza prioridade
        testCase.Priority = 'High';

        update testCase;

        Test.stopTest();

        // Busca novamente o Case atualizado
        testCase = [
            SELECT Id, Status
            FROM Case
            WHERE Id = :testCase.Id
        ];

        // Verifica Status
        System.assertEquals(
            'Escalated',
            testCase.Status
        );

        // Busca Tasks
        List<Task> tasks = [
            SELECT Id, Subject, Priority
            FROM Task
            WHERE WhatId = :testCase.Id
        ];

        // Verifica quantidade
        System.assertEquals(
            1,
            tasks.size()
        );

        // Verifica prioridade da Task
        System.assertEquals(
            'High',
            tasks[0].Priority
        );
    }
}