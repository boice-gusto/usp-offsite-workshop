---
name: test-gap-analyzer
description: Analyze test coverage gaps, missing test scenarios, untested code paths, and test quality issues. Produces actionable reports on what needs testing, prioritized by risk. Use when assessing test health, planning test improvements, or validating coverage for deployment.
---

# Test Gap Analyzer

## When to Use

- Assessing test health for a class or feature before refactoring
- Planning test improvements for deployment readiness
- Identifying untested code paths after a code review
- Validating that a PR has sufficient test coverage
- Auditing test quality (not just line coverage, but scenario coverage)
- Building a regression test suite for a feature area

## Analysis Dimensions

### Dimension 1: Class-to-Test Mapping

Every production class should have a corresponding test class:

| Production Class | Expected Test Class  | Status                        |
| ---------------- | -------------------- | ----------------------------- |
| `ClassName.cls`  | `ClassName_Test.cls` | Exists / Missing / Incomplete |

**Detection**: Search for production classes without `*_Test.cls` counterparts.

### Dimension 2: Scenario Coverage

Each class needs coverage across multiple scenarios:

| Scenario Type         | Required?                   | Description                            |
| --------------------- | --------------------------- | -------------------------------------- |
| Positive (happy path) | Always                      | Valid inputs, expected outcomes        |
| Negative (error path) | Always                      | Invalid inputs, edge cases, exceptions |
| Bulk (200+ records)   | For triggers/handlers       | Governor limit safety                  |
| Null/empty input      | When applicable             | Null parameters, empty collections     |
| Boundary conditions   | When applicable             | Min/max values, threshold logic        |
| Async execution       | For @future/Queueable/Batch | Test.startTest/stopTest wrapping       |
| Callout mocking       | For integrations            | HttpCalloutMock/WebServiceMock         |

### Dimension 3: Branch Coverage

Beyond line coverage, verify that all conditional branches are tested:

```apex
if (objBO.RecordTypeId == RENEWAL_RT) {
    // Branch A — needs a test with Renewal record type
} else if (objBO.RecordTypeId == NEW_PLAN_RT) {
    // Branch B — needs a test with New Plan record type
} else {
    // Branch C — needs a test with other record type
}
```

All three branches need dedicated test methods.

### Dimension 4: Integration Mock Coverage

| Integration    | Mock Type         | Scenarios Needed                               |
| -------------- | ----------------- | ---------------------------------------------- |
| REST callout   | `HttpCalloutMock` | Success (200), Error (4xx/5xx), Timeout        |
| SOAP callout   | `WebServiceMock`  | Success, Fault, Timeout                        |
| Platform Event | Direct publish    | Success, Limit exceeded                        |
| Inbound API    | Direct invocation | Valid payload, Invalid payload, Missing fields |

### Dimension 5: Cross-Trigger Coverage

In a monolith with cascading triggers, verify coverage for:

- Primary trigger (direct DML on object)
- Cascading triggers (DML on parent/child that fires this trigger)
- Re-entrant scenarios (trigger A → DML → trigger B → DML → trigger A again)
- Skip-trigger bypass scenarios (code that sets skipTrigger before DML)

## Workflow

### 1. Inventory Production Code

List all production classes in scope with:

- Line count (complexity indicator)
- Method count
- Has trigger context? (handler/trigger)
- Has integration? (callout/mock)
- Has conditional branches? (if/switch)

### 2. Map Existing Tests

For each production class:

- Does a `*_Test.cls` exist?
- What scenarios are covered? (check test method names and logic)
- Are assertions meaningful? (not just `Assert.isTrue(true)`)
- Is skip-trigger used? (prohibited in individual test methods)
- Is data created properly? (`@testSetup`, `TestDataFactory`, manual)

### 3. Identify Gaps

| Gap Type             | How to Detect                          | Priority |
| -------------------- | -------------------------------------- | -------- |
| No test class at all | Missing `*_Test.cls` file              | Critical |
| No bulk test         | No test with 200+ records              | High     |
| No negative test     | No test exercising error/null paths    | High     |
| No async wrapping    | Async code without `Test.startTest`    | High     |
| No mock coverage     | Callout without `HttpCalloutMock`      | High     |
| Weak assertions      | `Assert.isTrue(true)` or no assertions | Medium   |
| Single-record only   | All tests use 1 record                 | Medium   |
| Missing branch       | Conditional without test for each path | Medium   |
| Legacy assert style  | `System.assert*` instead of `Assert.*` | Low      |
| Skip-trigger in test | `skipTrigger = true` in test method    | Blocker  |

### 4. Generate Gap Report

Produce a report with: summary stats (classes analyzed, test classes found, critical/high gaps), gap inventory table (class, gap type, priority, recommendation), and a phased test plan (Phase 1: Critical — missing test classes, Phase 2: High — missing scenarios, Phase 3: Medium — quality improvements).

## Test Quality

Apply the quality rules from `salesforce-testing-modern-asserts.mdc` and `gusto_sfdc_coding_standards.mdc` §7 to each test class found during analysis.

## Regression Suite Planning

For feature areas, build a regression matrix:

| Feature      | Test Classes                                               | Covers                         |
| ------------ | ---------------------------------------------------------- | ------------------------------ |
| BO Lifecycle | `BenefitOrderHelper_Test`, `BOCaseServices_Test`           | Insert, update, status cascade |
| CO Lifecycle | `CarrierOrderTriggerHelper_Test`, `COHelperFunctions_Test` | Insert, status, Kafka publish  |
| HI Events    | `HIFulfillmentEventHandler_Test`, handler-specific tests   | All event types                |
| Case Routing | `CaseTriggerHelper_Test`, `CRC_Test`                       | Creation, routing, ownership   |

## Guardrails

- Never recommend adding `skipTrigger` to make a test pass.
- Never recommend `@SeeAllData=true` to access org data.
- Always recommend fixing the production code if tests reveal bugs.
- Prioritize bulk test gaps over cosmetic improvements.
- Flag any test class that provides 0% dedicated coverage of its target class.

## Done Criteria

- All production classes in scope have mapped test classes
- Gap inventory produced with priority classifications
- Recommended test plan with phased approach
- Test quality checklist applied to existing tests
- Regression suite matrix built for feature areas
