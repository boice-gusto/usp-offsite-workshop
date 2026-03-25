# Day 1 Workshop: Build Something Real

This is a hands-on exercise to build your first Claude Code skill.

## Goal

Take a repetitive task and **SKILLIFY** it — turn it into a reusable skill.

## Available MCPs

You have access to these integrations:

- **JIRA** — tickets, sprints, team context
- **Workbench** — components, patterns, design system
- **Datadog** — logs, metrics, traces
- **Slack** — channels, threads, search
- **GitHub** — PRs, issues, code search

Use `/mcp` to see connected MCPs.

## Skill Structure

Skills live in `.claude/skills/<skill-name>/SKILL.md`:

```markdown
---
name: skill-name
description: What it does
arguments:
  - name: input
    description: What the user provides
    required: true
---

# Skill Name

## Usage
/skill-name <input>

## Behavior
Instructions for Claude...
```

## Example Skill

See `.claude/skills/monkey-banana/SKILL.md` for a working example.

## Exercise Ideas

- **Summarizer** — Slack, tickets, docs → action items
- **Team Health** — capacity planning, status synthesis
- **Fuzzy to Clear** — vague request → actionable spec
- **JIRA Analyzer** — ticket analysis with complexity scoring

Or build something for YOUR repetitive tasks.

## Try the Example

```bash
/monkey-banana explain how databases work
```

## Create Your Own

Ask Claude to help you build a skill:

- "Help me create a skill that summarizes Slack threads"
- "I want a skill that analyzes JIRA tickets"
