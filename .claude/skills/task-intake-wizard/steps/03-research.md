# Step 3: Research

Deep-dive investigation for tasks that touch complex, unfamiliar, or high-risk areas. This step is optional and should be suggested when context reveals significant complexity.

## When to Recommend This Step

- Intake touches a high-risk coupling zone (BenefitOrderHelper, CarrierOrderTriggerHelper, TicketTriggerHelper)
- Multiple objects or trigger handlers are impacted
- No prior art or documentation was found in context phase
- The request involves unfamiliar integration points or async patterns

## Research Activities

### Execution Tracing

1. Trace the primary code path from entry point to terminal effects
2. Identify all trigger contexts involved (insert, update, delete, undelete)
3. Map cross-object side effects (e.g., updating Opportunity triggers Account handler)
4. Note any skipTrigger flags, feature flags, or conditional gates

### Prior Art Analysis

5. Review closed Jira tickets for similar work — note approach, pitfalls, and outcomes
6. Search Confluence for design decisions or architecture docs
7. Search Slack for past discussions and decisions on the topic
8. Check git history for recent changes to impacted files

### Risk Assessment

9. Assess impact radius — how many files/objects/integrations are affected
10. Identify governor limit concerns (bulk volume, SOQL count, DML operations)
11. Check for PII/PHI exposure in the affected data paths
12. Note any platform event or integration contract implications

### Skills to Chain

Invoke these skills as needed during research:

- `codebase-researcher` — for systematic cross-reference analysis
- `code-explainer` — for execution traces and sequence diagrams
- `sfdc-architecture` — for layer placement and design decisions
- `sfdc-anti-patterns` — for legacy risk detection

## Output Schema

```json
{
  "research": {
    "executionTrace": "",
    "triggerContexts": [],
    "crossObjectEffects": [],
    "priorArt": [
      { "source": "jira|confluence|slack|git", "reference": "", "summary": "" }
    ],
    "riskAssessment": {
      "impactRadius": "low|medium|high",
      "governorLimitConcerns": [],
      "piiPhiExposure": false,
      "integrationImpact": [],
      "overallRisk": "low|medium|high"
    },
    "recommendations": [],
    "openQuestions": []
  }
}
```

## Presentation

Present findings as:

1. **Execution summary** — paragraph describing the code path
2. **Risk matrix** — table of risk factors with severity
3. **Recommendations** — ordered list of suggested approaches
4. **Open questions** — things that need human input or org-level verification
