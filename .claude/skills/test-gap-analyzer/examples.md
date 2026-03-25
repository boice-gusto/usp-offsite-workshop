# Examples: test-gap-analyzer

## Example Prompt 1

User request:
"What test coverage gaps exist for the BenOps fulfillment pipeline?"

Expected behavior:
- Inventory all BenOps production classes: BenefitOrderHelper, CarrierOrderTriggerHelper, HI handlers, etc.
- Map each to its test class counterpart.
- Check for scenario coverage: positive, negative, bulk, async, mock.
- Identify missing test classes (no *_Test.cls).
- Identify weak tests (no meaningful assertions, single-record only).
- Produce a gap report with prioritized recommendations.
- Estimate effort for each gap (number of test methods needed).

## Example Prompt 2

User request:
"Does this PR have enough test coverage?"

Expected behavior:
- Analyze the changed production code.
- Check if corresponding test classes are updated in the PR.
- Verify new methods have test coverage.
- Check for branch coverage on new conditional logic.
- Verify bulk scenario if trigger-related.
- Verify mock coverage if integration-related.
- Produce a pass/fail assessment with specific gaps to address.

## Example Prompt 3

User request:
"Which classes don't have dedicated test classes?"

Expected behavior:
- List all production classes in force-app/main/default/classes/.
- For each, check if a *_Test.cls exists.
- Classify: Has dedicated test, Has indirect coverage only, No test at all.
- Prioritize by risk: trigger handlers > service classes > utility classes.
- Produce a table sorted by priority.

## Example Prompt 4

User request:
"Audit the test quality for CarrierOrderTriggerHelper_Test."

Expected behavior:
- Read the test class.
- Apply the test quality checklist.
- Check: Assert class usage, skipTrigger, SeeAllData, startTest/stopTest, assertion quality.
- Check scenario coverage: positive, negative, bulk, per-record-type branches.
- Check mock coverage for Kafka callouts.
- Identify weak assertions (isTrue(true), no message).
- Produce a findings list with specific improvement recommendations.

## Example Prompt 5

User request:
"Build a regression test plan for the skip-trigger removal project."

Expected behavior:
- Inventory all 49 files using skipTrigger.
- For each, identify the test class that covers the code path.
- Determine what additional tests are needed when skipTrigger is removed.
- Plan tests that verify trigger logic fires correctly without the skip.
- Include bulk scenarios (skip was often used to avoid governor limits in tests).
- Build a phased test plan: one phase per skipTrigger removal PR.
- Flag tests that currently pass ONLY because triggers are skipped.
