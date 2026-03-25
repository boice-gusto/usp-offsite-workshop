---
name: jira-summary
description: Analyzes JIRA tickets to assess complexity, dependencies, business value, ROI, and stakeholder impact. Use when asked to summarize, analyze, or evaluate JIRA tickets.
arguments:
  - name: ticket
    description: JIRA ticket ID (e.g., USPRTE-924)
    required: true
  - name: team
    description: Team/project to check cross-team dependencies against (optional)
    required: false
---

# JIRA Ticket Analyzer

## Usage

```
/jira-summary <TICKET_ID> [TEAM]
```

**Examples:**
- `/jira-summary USPRTE-924` — analyzes ticket (general analysis, no team-specific dependency check)
- `/jira-summary USPRTE-924 CARE` — analyzes ticket + checks cross-team dependencies with CARE

## Purpose

Analyze JIRA tickets to help teams understand ticket complexity, dependencies, and business value. Provides structured output for backlog refinement, sprint planning, and stakeholder communication.

**Team context:** If a team is specified, include cross-team dependency analysis for that team. If no team is provided, perform general ticket analysis without team-specific dependency checking.

## Trigger Conditions

**ALWAYS use this skill when the user:**
- Asks to "summarize" a JIRA ticket
- Asks to "analyze" a JIRA ticket
- Asks about ticket "dependencies"
- Asks about ticket "complexity" or "impact"
- Mentions a JIRA ticket ID (e.g., PROJ-123) with evaluation intent

## Required Steps

### Step 1: Fetch Ticket Data

1. Get accessible Atlassian resources to find cloudId
2. Fetch the ticket using `mcp__plugin_atlassian_atlassian__getJiraIssue`
3. If ticket is a sub-task, also fetch the parent ticket
4. Search for linked issues: `parent = {TICKET} OR issue in linkedIssues({TICKET})`
5. Check for blocking/blocked-by relationships

### Step 2: Analyze Using Framework

**Technical Complexity** (Low/Medium/High)
- System/service dependencies
- Cross-codebase changes required
- Integration points and API contracts
- Database or infrastructure changes

**Domain Complexity** (Low/Medium/High)
- Business rule complexity
- Edge cases and exception handling
- Regulatory/compliance requirements
- Cross-functional coordination

**Dependencies** (REQUIRED - always report)
- Parent ticket (if sub-task)
- Linked issues (blocks/blocked-by)
- Cross-team dependencies (only if team parameter provided)
- External system dependencies

**ROI Assessment**
- Quantifiable: measurable revenue/cost/time impact
- Qualitative: improvements without hard metrics
- Unclear: needs more definition

**Customer Impact**
- Direct: customer-facing changes
- Indirect: internal improvements affecting customer experience
- None: purely internal/operational

### Step 3: Output in REQUIRED Format

**YOU MUST USE THIS EXACT FORMAT. Do not deviate.**

```markdown
## Ticket Analysis: [TICKET-ID]

**Title:** [ticket title]
**Type:** [Issue type] | **Status:** [status] | **Assignee:** [name]

---

### Complexity Score: [Low/Medium/High]

| Dimension | Rating | Details |
|-----------|--------|---------|
| Technical | [L/M/H] | [1-2 sentence assessment] |
| Domain | [L/M/H] | [1-2 sentence assessment] |

---

### Dependencies

| Type | Ticket/System | Status | Blocking? |
|------|---------------|--------|-----------|
| Parent | [TICKET-ID or N/A] | [status] | [Yes/No] |
| Linked | [TICKET-ID or None] | [status] | [Yes/No] |
| External | [system name or None] | [status] | [Yes/No] |

**Dependency Summary:** [1 sentence summary of key dependencies or "No blocking dependencies identified"]

---

### Business Value

| Metric | Assessment |
|--------|------------|
| ROI | [Quantifiable/Qualitative/Unclear] |
| ROI Details | [1-2 sentence explanation] |
| Customer Impact | [Direct/Indirect/None] |
| Impact Details | [1-2 sentence explanation] |

---

### Stakeholder Impact

**Internal Teams Affected:**
- [Team 1]: [how affected]
- [Team 2]: [how affected]

**External Dependencies:** [list or "None"]

---

### Strategic Assessment

| Factor | Rating |
|--------|--------|
| Platform Reliability Impact | [Positive/Neutral/Negative] |
| Recommendation | [Prioritize/Defer/Needs Clarification] |

**Rationale:** [1-2 sentences explaining recommendation]

---

### Key Talking Points for Stakeholders

1. **[Topic]:** [point]
2. **[Topic]:** [point]
3. **[Topic]:** [point]
```

## Validation Rules

Before outputting, verify:
- [ ] All table headers present and formatted correctly
- [ ] Complexity Score section includes both Technical and Domain ratings
- [ ] Dependencies section is populated (use "None" if no dependencies, never omit)
- [ ] ROI is one of: Quantifiable, Qualitative, Unclear
- [ ] Customer Impact is one of: Direct, Indirect, None
- [ ] Recommendation is one of: Prioritize, Defer, Needs Clarification
- [ ] Exactly 3 Key Talking Points provided
- [ ] All talking points have bold topic labels

## Example Output

## Ticket Analysis: USPRTE-924

**Title:** QA USPRTE-879 - Design + Dev: "Re-Route" from Care to BenOps
**Type:** Sub-task | **Status:** In Progress | **Assignee:** Tyler Cooper

---

### Complexity Score: Medium

| Dimension | Rating | Details |
|-----------|--------|---------|
| Technical | M | Salesforce flow modifications, BenOps case integration, email insertion automation, Chatter API |
| Domain | M | Complex eligibility logic across 5 record types with varying Integration ID requirements |

---

### Dependencies

| Type | Ticket/System | Status | Blocking? |
|------|---------------|--------|-----------|
| Parent | USPRTE-879 | In Progress | No |
| Linked | None | - | - |
| External | Salesforce (staging) | Error | Yes |

**Dependency Summary:** Email insertion failing in staging environment blocks QA completion.

---

### Business Value

| Metric | Assessment |
|--------|------------|
| ROI | Quantifiable |
| ROI Details | Reduces manual case handling time ~5-10 min per misrouted case, ensures correct automations trigger |
| Customer Impact | Indirect |
| Impact Details | Faster resolution when cases reach correct team; no direct customer-facing UI change |

---

### Stakeholder Impact

**Internal Teams Affected:**
- BenOps: Receives re-routed cases with new Chatter notifications
- Care: New workflow in Re-Route flow
- BSA: Classification record tracking and reporting

**External Dependencies:** None

---

### Strategic Assessment

| Factor | Rating |
|--------|--------|
| Platform Reliability Impact | Positive |
| Recommendation | Needs Clarification |

**Rationale:** High-value feature blocked by staging bug; dev fix required before QA can validate.

---

### Key Talking Points for Stakeholders

1. **Blocker:** Email insertion to BenOps cases failing in staging - dev fix required
2. **Value:** Eliminates manual re-routing friction, ensures correct automations fire
3. **Scope:** Only affects Care-to-BenOps handoffs; skip option preserves existing workflow
