# 🚨 Case Escalation System

Sistema de automação desenvolvido em Apex no Salesforce para escalonamento automático de Cases críticos.

---

# 📌 Objetivo

Automatizar o processo de escalonamento de Cases quando a prioridade é alterada para **High**, garantindo que o time responsável seja notificado rapidamente através da criação automática de Tasks.

---

# ⚙️ Funcionalidades

✅ Detecta atualização de prioridade para `High`  
✅ Atualiza automaticamente o Status do Case para `Escalated`  
✅ Cria Task automática para revisão urgente  
✅ Evita criação de Tasks duplicadas  
✅ Processamento bulkificado para múltiplos registros  
✅ Test Class validando comportamento do sistema  

---

# 🏗️ Arquitetura

O projeto utiliza:

- Trigger Apex
- Service Layer
- SOQL
- DML
- Collections (`List`, `Set`, `Map`)
- `Trigger.oldMap`
- Bulkification
- Test Classes

---

# 🔄 Fluxo do Sistema

```text
Usuário atualiza o Case
↓
Trigger detecta o before update
↓
Trigger envia Trigger.new e Trigger.oldMap
↓
Classe de serviço processa os dados
↓
Loop identifica Cases críticos
↓
SOQL busca Tasks existentes
↓
Sistema evita Tasks duplicadas
↓
Nova Task é criada
↓
Insert final salva as Tasks
```

---

# 🧠 Conceitos praticados

## Bulkification

O sistema foi desenvolvido para suportar múltiplos registros simultaneamente, evitando:

- SOQL dentro de loops
- DML dentro de loops
- Duplicidade de registros
- Problemas de governor limits

---

# 🛠️ Tecnologias utilizadas

- Apex
- Salesforce CLI
- VS Code
- Git & GitHub

---

# 📂 Estrutura do Projeto

```text
force-app/
└── main/
    └── default/
        ├── classes/
        │   ├── CaseEscalationService.cls
        │   ├── CaseEscalationServiceTest.cls
        │
        └── triggers/
            └── CaseTrigger.trigger
```

---

# ✅ Testes

A aplicação possui Test Class cobrindo:

- Atualização de prioridade
- Mudança automática de Status
- Criação de Task
- Validação de Task duplicada

---

# 🚀 Aprendizados

Durante o desenvolvimento deste projeto foram praticados conceitos fundamentais de desenvolvimento Salesforce, principalmente:

- Fluxo de execução do Apex
- Arquitetura orientada a serviços
- Collections avançadas
- Escalabilidade
- Governança da plataforma

---

# 👨‍💻 Autor

Alexsander Cardoso

Desenvolvedor Salesforce em evolução 🚀
