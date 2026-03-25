# USP PE OffSite - Claude Code Workshop

Presentation materials for the Claude Code workshop at the USP PE OffSite.

## Sessions

| Day | Topic | File |
|-----|-------|------|
| Day 1 | Build Something Real | `day1-build-something-real.html` |
| Day 2 | Round Table | `day2-round-table.html` |

## Usage

Open the HTML files directly in a browser. No build step required - all CSS is embedded.

**Navigation:**

- Arrow keys or click to advance slides
- Progress bar at bottom shows position

## Included Skills

| Skill | Description |
|-------|-------------|
| `skill-creator` | Create and validate Claude Code skills |
| `day01-jira-analyzer-01` | Basic JIRA ticket summarizer |
| `day01-jira-analyzer-02` | Structured analysis with enforced output format |

### Using the Skills

```bash
# Create a new skill
/skill-creator my-new-skill

# Analyze JIRA tickets
/day01-jira-analyzer-02 USPRTE-924
/day01-jira-analyzer-02 USPRTE-924 CARE
```

## Structure

```bash
presentation/
├── day1-build-something-real.html  # Day 1 slides
├── day2-round-table.html           # Day 2 slides
├── .claude/
│   ├── settings.local.json         # Local permissions (gitignored)
│   └── skills/
│       ├── skill-creator/          # Skill authoring tool
│       ├── day01-jira-analyzer-01/ # Basic skill
│       └── day01-jira-analyzer-02/ # Enhanced skill
├── demo/
│   └── day01/                      # Demo artifacts
├── docs/
│   └── superpowers/                # Planning docs
└── assets/                         # Logos, images
```

## Prerequisites

- Claude Code CLI
- Atlassian MCP plugin (for JIRA integration)
