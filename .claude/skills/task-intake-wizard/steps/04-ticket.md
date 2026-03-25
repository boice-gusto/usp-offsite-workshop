# Step 4: Ticket Writing

Create a structured Jira ticket (and optionally a Notion page) from the accumulated intake, context, and research data.

## Ticket Assembly

1. Load the ticket template from `templates/ticket.md`
2. Populate template fields from the running context:
   - **Summary** ← `intake.title`
   - **Description** ← rendered template with all sections
   - **Type** ← `intake.type` mapped to Jira issue type
   - **Labels** ← from config defaults + intake type
   - **Acceptance Criteria** ← `intake.acceptanceCriteria`
   - **Technical Context** ← `context` summary
   - **Research Findings** ← `research` summary (if research step was run)
3. Present the assembled ticket to the user for review before creating

## Jira Creation

Resolve required Jira parameters via MCP, then create the issue.

### Parameter Resolution (MCP-first, config fallback)

1. **Cloud ID** — call `getAccessibleAtlassianResources` (MCP: `user-jira-confluencegusto`) to resolve automatically. Never stored in config.
2. **Project Key** — use `config.preferences.jira.projectKey` if set. If blank, call `getVisibleJiraProjects` and present the list to the user via `AskQuestion`.
3. **Issue Type** — map from `intake.type` using the table below. If the project doesn't support the mapped type, call `getJiraProjectIssueTypesMetadata` and let the user pick.

```
Server: user-jira-confluencegusto
Tool: createJiraIssue
Arguments:
  cloudId: {resolved via getAccessibleAtlassianResources}
  projectKey: {from config preference or user selection}
  issueTypeName: {mapped from intake.type}
  summary: {intake.title}
  description: {rendered template in Markdown}
  additional_fields: {labels, story points, epic link as needed}
```

### Type Mapping

| Intake Type   | Jira Issue Type |
| ------------- | --------------- |
| Bug Fix       | Bug             |
| Feature       | Story           |
| Enhancement   | Story           |
| Tech Debt     | Task            |
| Investigation | Spike           |
| Documentation | Task            |
| Other         | Task            |

## Notion Page (Optional)

If `config.preferences.notion.enabled` is true:

- Search for the target database/page via `notion-search` MCP tool
- Present matches and let the user confirm the destination
- Create a Notion page with extended documentation
- Link the Jira ticket in the Notion page
- Link the Notion page back in the Jira ticket description

## User Review Gate

**Always** present the ticket content to the user before calling the Jira API. Use `AskQuestion` to confirm:

- "Create this ticket in Jira?" → Yes / Edit first / Skip

## Output Schema

```json
{
  "ticket": {
    "jiraKey": "",
    "jiraUrl": "",
    "summary": "",
    "issueType": "",
    "notionPageUrl": "",
    "content": ""
  }
}
```
