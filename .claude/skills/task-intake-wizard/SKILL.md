---
name: task-intake-wizard
description: Configurable wizard that guides task intake through discovery, context gathering, research, ticket writing, sizing, prioritization, scheduling, and stakeholder announcements. Uses Jira, Slack, Notion, and Confluence MCPs. Use when the user wants to intake a new task, write a ticket, plan work, or announce a project.
---

# Task Intake Wizard

Modular, config-driven workflow for taking a task from idea to actionable ticket with optional stakeholder notification.

## Quick Start

1. Read `config.json` in this skill directory to load active steps and defaults.
2. Present the wizard intro and ask which optional steps the user wants for this run.
3. Execute enabled steps in order, collecting outputs into a running context object.
4. Produce a final summary linking all artifacts created.

## Configuration

Load [`config.json`](config.json) at the start of every run. It controls:

- **steps** — which phases are enabled/required and their order
- **preferences** — optional defaults for Jira, Slack, Notion, Confluence (see below)
- **sizing** — scale type and options (t-shirt, fibonacci, custom)
- **priority** — scale labels and evaluation factors
- **templates** — paths to message/ticket templates

### MCP Handles Auth — Config Stores Preferences Only

All authentication and connection details are managed by the MCP servers themselves. The config file **never** stores credentials, cloud IDs, tokens, or connection strings.

The `preferences` section stores optional convenience defaults:

- `jira.projectKey` — pre-fill the Jira project; blank = ask during intake
- `slack.announceChannels` — pre-set channels to post to; blank = discover via MCP and ask
- `slack.draftMode` — whether to draft messages for review before sending
- `notion.enabled` / `confluence.enabled` — whether to use these integrations at all

**Blank preference = wizard prompt.** Any preference left empty will trigger an interactive prompt during the relevant step. Users can also override pre-set defaults at runtime.

## Wizard Flow

### Phase 0: Setup

Read `config.json`. Present enabled steps to the user:

```
This intake wizard will walk you through:
 1. ✅ Intake    — Capture the request
 2. ✅ Context   — Gather codebase and domain context
 3. ✅ Research   — Investigate dependencies and prior art
 4. ☐ Ticket    — Create Jira/Notion ticket
 5. ☐ Sizing    — Estimate effort
 6. ☐ Prioritize — Assess priority
 7. ☐ Schedule  — Assign to sprint/milestone
 8. ☐ Announce  — Notify stakeholders via Slack
```

Use `AskQuestion` to let the user toggle optional steps on/off for this run. Required steps (marked in config) cannot be skipped.

### Phase 1: Intake (step file: `steps/01-intake.md`)

Capture the core request. Ask structured questions about:

- What is being requested
- Who is requesting it (stakeholder)
- Why it matters (business justification)
- Desired outcome / acceptance criteria
- Known constraints or deadlines

Output: `intake` context object with all captured fields.

### Phase 2: Context (step file: `steps/02-context.md`)

Gather technical and domain context using available tools:

- Search codebase for related files, classes, triggers, flows
- Check for existing tickets (Jira) or docs (Confluence/Notion)
- Identify impacted objects, handlers, and integration points
- Surface related skills or scratchpad docs

Output: `context` object with file references, dependencies, related tickets.

### Phase 3: Research (step file: `steps/03-research.md`)

Deep-dive investigation when the task touches complex or unfamiliar areas:

- Trace execution paths through trigger handlers and services
- Review prior art (similar past tickets, PRs, Slack threads)
- Check Confluence for design docs or SOPs
- Assess risk and coupling

Output: `research` object with findings, risk assessment, recommendations.

### Phase 4: Ticket (step file: `steps/04-ticket.md`)

Create a structured ticket using the ticket template:

- Load template from `templates/ticket.md`
- Populate from intake + context + research outputs
- Create in Jira via `createJiraIssue` MCP tool
- Optionally create a Notion page for extended documentation

Output: `ticket` object with issue key, URL, and content.

### Phase 5: Sizing (step file: `steps/05-sizing.md`)

Estimate effort using the configured scale:

- Present sizing options from config
- Factor in research complexity, dependencies, test requirements
- Record estimate rationale

Output: `sizing` object with estimate, rationale, and confidence level.

### Phase 6: Prioritize (step file: `steps/06-prioritize.md`)

Assess priority using configured factors:

- Business impact, urgency, dependencies, risk
- Compare against current sprint/backlog if available
- Assign priority label

Output: `priority` object with level, factor scores, justification.

### Phase 7: Schedule (step file: `steps/07-schedule.md`)

Assign to a time slot:

- Suggest sprint or milestone based on sizing + priority
- Check for blocking dependencies
- Update Jira ticket with sprint/milestone if created

Output: `schedule` object with target sprint, blockers, dependencies.

### Phase 8: Announce (step file: `steps/08-announce.md`)

Notify stakeholders via Slack:

- Load announcement template from `templates/announcement.md`
- Populate with intake summary, ticket link, sizing, priority
- Post to configured announce channels (or draft if `draftMode: true`)
- Cross-post to additional channels from config
- Use `slack_send_message_draft` for review before sending, or `slack_send_message` for immediate post

Output: `announce` object with message links and channels notified.

### Phase 9: Summary

Produce a final summary of all artifacts:

- Intake summary
- Ticket link(s)
- Size estimate
- Priority level
- Schedule assignment
- Announcement link(s)
- Open questions or follow-ups

## MCP Integration Reference

MCPs handle all authentication. The wizard just calls tools — no credentials or cloud IDs in config.

| MCP Server                       | Tools Used                                                                     | Purpose                               |
| -------------------------------- | ------------------------------------------------------------------------------ | ------------------------------------- |
| `user-jira-confluencegusto`      | `createJiraIssue`, `editJiraIssue`, `searchJiraIssuesUsingJql`, `getJiraIssue` | Ticket creation, search for prior art |
| `user-jira-confluencegusto`      | `searchConfluenceUsingCql`, `getConfluencePage`, `createConfluencePage`        | Design doc lookup, documentation      |
| `user-slackgustoofficial`        | `slack_send_message`, `slack_send_message_draft`, `slack_search_channels`      | Announcements, channel discovery      |
| `plugin-notion-workspace-notion` | `notion-create-pages`, `notion-search`, `notion-fetch`                         | Task tracking, documentation pages    |

### MCP Discovery Pattern

When a step needs a value the config doesn't provide (e.g., Jira project key, Slack channel), use MCPs to discover options and let the user choose:

1. **Jira project** — call `getVisibleJiraProjects` to list available projects, present to user
2. **Jira cloud ID** — call `getAccessibleAtlassianResources` to resolve automatically
3. **Slack channels** — call `slack_search_channels` with keywords from the intake, present matches
4. **Confluence space** — call `getConfluenceSpaces` to list available spaces
5. **Notion database** — call `notion-search` with a keyword to find relevant databases

Always read the MCP tool schema before calling. Schemas live at:
`~/.cursor/projects/Users-jonathan-boice-Documents-GitHub-sfdc/mcps/<server>/tools/<tool>.json`

## Extending This Skill

See [`steps/README.md`](steps/README.md) for instructions on:

- Adding new steps
- Modifying the wizard flow
- Creating custom templates
- Overriding default config per-team

## Related Skills

- `codebase-researcher` — deep codebase exploration during context/research phases
- `sfdc-architecture` — architecture decisions surfaced during research
- `git-commit-pr-craftsman` — after implementation, for clean commits
- `test-gap-analyzer` — identify test requirements during sizing
