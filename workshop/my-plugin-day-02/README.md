# Day 2: Claude Scaffolding & Roundtable

## Overview

Day 2 builds on the skills you learned in Day 1. Today we'll use **claude-scaffolding** to rapidly bootstrap a fully-featured Claude Code plugin, then wrap up with a roundtable discussion.

## Prerequisites

Before starting, ensure you have:

- Completed Day 1 (basic skills and hooks)
- GitHub CLI (`gh`) installed
- Claude Code CLI (`claude`) installed

Run the init script to verify:

```bash
make setup

#or
./init.sh
```

## Agenda

### Part 1: Claude Scaffolding (60 min)

The claude-scaffolding template gives you a production-ready plugin structure:

```bash
my-plugin/
├── .claude-plugin/
│   └── manifest.json       # Plugin metadata
├── .claude/
│   ├── skills/             # Your custom skills
│   ├── hooks/              # Pre/post tool hooks
│   └── agents/             # Custom agents
├── src/                    # MCP server (if needed)
└── CLAUDE.md               # Project instructions
```

**What you'll learn:**

1. Clone and configure the scaffolding
2. Customize the manifest for your use case
3. Add skills, hooks, and agents
4. Test locally before publishing

### Part 2: Hands-On Build (45 min)

Build a real plugin using the scaffolding:

- Pick a use case (productivity, dev workflow, etc.)
- Implement 2-3 skills
- Add at least one hook
- Test with `/your-skill` commands

### Part 3: Roundtable Discussion (30 min)

Open discussion topics:

- What plugins would be most useful for your workflow?
- Challenges you encountered and solutions
- Best practices for skill design
- Ideas for team-wide plugins
- Q&A

## Quick Start

### Option A: Use the init script (recommended)

The init script checks dependencies, installs what's missing, and sets everything up:

```bash
# Using make
make init

# Or directly
./init.sh
```

The script will:

1. Check for `gh` (GitHub CLI) and `claude` (Claude Code CLI)
2. Offer to install missing dependencies via Homebrew
3. Clone the claude-scaffolding template
4. Ask if you want to start Claude immediately

### Option B: Manual setup

If you prefer to set things up manually:

```bash
# 1. Install dependencies (if needed)
brew install gh
npm install -g @anthropic-ai/claude-code

# 2. Authenticate with GitHub
gh auth login

# 3. Clone the scaffolding
gh repo clone Gusto/claude-plugin-scaffold my-plugin

# 4. Start building
cd my-plugin
claude
```

## Resources

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Plugin Development Guide](https://docs.anthropic.com/claude-code/plugins)
- [Skills Reference](https://docs.anthropic.com/claude-code/skills)
- [Hooks Reference](https://docs.anthropic.com/claude-code/hooks)

## Next Steps

After today:

1. Publish your plugin to a marketplace (or keep it local)
2. Share with your team
3. Iterate based on feedback
