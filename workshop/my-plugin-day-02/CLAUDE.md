# Day 2 Workshop: Round Table + Plugin Deep Dive

Building on Day 1, today we explore the full plugin system.

## Setup

Run the init script to get started:

```bash
make setup

# or 

./init.sh

```

This will:

1. Check your dependencies (gh, claude CLI)
2. Clone the plugin scaffold into `.claude/`
3. Ask you to name your plugin
4. Start Claude Code

## Plugin Structure

After setup, your `.claude/` folder contains:

```bash
.claude/
├── .claude-plugin/
│   └── manifest.json    # Plugin metadata
├── skills/              # Reusable prompts
├── hooks/               # Event-triggered actions
└── agents/              # Specialized sub-agents
```

## What's New in Day 2

### Skills (from Day 1)

Reusable prompts invoked with `/skill-name`.

### Hooks

Trigger actions on events:

- `pre-commit` — run before commits
- `post-tool-use` — run after tool calls
- `session-start` — run when Claude starts

### Agents

Specialized sub-agents for specific tasks (research, code review, etc.)

## Available MCPs

- **JIRA** — tickets, sprints, team context
- **Workbench** — components, patterns, design system
- **Datadog** — logs, metrics, traces
- **Slack** — channels, threads, search
- **GitHub** — PRs, issues, code search

## Today's Focus

From the survey:

- **67%** want help with fuzzy → specs
- **58%** want clearer comms
- **42%** want business rules → logic

Build skills that address these needs.

## Commitment

Pick ONE thing to SKILLIFY this week and share it with your team.
