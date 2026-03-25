# Presenter Notes

## Day 1: Build Something Real

### Slide 1: Title

- Welcome everyone to Day 1 of the Claude Code workshop

### Slide 2: Opening — "This isn't foundations"

**Key Points:**

- We're skipping the basics — they've done that already
- Today is hands-on building, not theory

**Question to ask:**
> "Quick show of hands — who has already built something with Claude beyond a simple prompt?"

---

### Slide 3: Level 1 — Manual Prompt

**Key Points:**

- This is how most people start — it works, but it's fragile
- Hardcoded paths break when someone else runs it
- Manual file exports = friction every time
- No reusability — retype everything next run

**Demo command (optional):**

```bash
claude "Look at the sfdc codebase and summarize this JIRA ticket — are there dependencies from BENOPS?"
```

**Question to ask:**
> "Who has a prompt saved in their notes or clipboard that they paste repeatedly?"

---

### Slide 4: MCPs Available

**Key Points:**

- MCPs = Model Context Protocol — Claude's way of connecting to external systems
- These are already available: JIRA, Workbench, Datadog, Slack, GitHub, Playwright, Glean, DX, Notion

**Commands to demo:**

```bash
/plugins        # Browse the marketplace
/mcp            # See connected MCPs
```

**Question to ask:**
> "Which of these would save you the most time if Claude could access it directly?"

---

### Slide 5: Level 2 — MCP Context

**Key Points:**

- Same task, but no file exports, no paths
- Claude fetches the ticket directly via JIRA MCP

**Demo command:**

```bash
claude "Summarize this JIRA ticket USPRTE-924 and are there dependencies we need to know about from BENOPS."
```

---

### Slide 6: Level 3 — Skills

**Key Points:**

- v1: Just save the prompt — output varies each time
- v2: Structured workflow — consistent output with tables, scores, formats

**Demo commands:**

```bash
/day01-jira-analyzer-01 USPRTE-924           # v1: basic saved prompt
/day01-jira-analyzer-02 USPRTE-924 CARE      # v2: structured workflow
```

**Question to ask:**
> "What's a task you do repeatedly that would benefit from a consistent output format?"

---

### Slide 7: The Scaffold

**Key Points:**

- Clone the scaffold, structure is ready
- Just add your logic to skills/, hooks/, commands/

**Commands:**

```bash
git clone https://github.com/Gusto/claude-plugin-scaffold
cd claude-plugin-scaffold
# Edit skills/, hooks/, commands/
```

---

### Slide 8: Your Exercise

**Key Points:**

- 50 minutes to build something REAL
- Best option: your own repetitive task to SKILLIFY
- Fallback ideas: Summarizer, Team Health, Fuzzy to Clear

**Question to ask:**
> "What's a task you do every week that takes 15+ minutes and could be automated?"

---

### Slide 9: Getting Started

**Commands to walk through:**

```bash
# Step 1: Clone & Open
git clone git@github.com:Gusto/claude-plugin-scaffold.git
cd claude-plugin-scaffold
claude --plugin-dir .

# Step 2: Talk to Claude
"Build my plugin"
"Create a skill for X"
"Validate my plugin"

# Step 3: Share (later)
/plugin marketplace add YourOrg/your-plugin
```

**Key Points:**

- Facilitators are circulating — ask questions!
- Don't overthink — start simple

---

### Slide 10: BUILD

- Start the timer: 50 minutes
- Circulate and help

---

### Slide 11: Demo Showcase

**Questions for volunteers:**
> "What did you build?"
> "What will it save you?"

- Get 4-5 volunteers, 2 minutes each

---

### Slide 12: Bonus — Plugins + Superpowers

**Key Points:**

- Fluency Plugin: Pre-built skills for common PE workflows
- Superpowers Brainstorm: Turn ideas into structured designs

**Commands (if demoing):**

```bash
/plugins                    # Browse available plugins
/superpowers:brainstorm     # Start brainstorming session
```

---

### Slide 13: Close

**Key Quote:**

> "If you do it more than once, automate it."

**Takeaway:**

- Find repetitive work. SKILLIFY it.

---

## Day 2: Plugin Deep Dive

### Slide 1: Title

- Day 2 — Plugin Deep Dive session

### Slide 2: Opening — "Yesterday: Skills"

**Key Points:**

- Reference what they built yesterday
- Today goes deeper: full plugin system

**Question to ask:**
> "Who got their skill working yesterday? Any surprises?"

---

### Slide 3: Plugin Architecture

**Key Points:**

- Show the full structure: skills, hooks, agents, commands
- manifest.json is the plugin metadata
- Each component type has its own folder

**Demo (optional):**

```bash
tree .claude/
```

---

### Slide 4: Hooks — Event-Driven Automation

**Key Points:**

- Hooks trigger on events: pre-commit, post-tool-use, session-start, notification
- They run shell commands or scripts
- Great for validation, logging, notifications

**Question to ask:**
> "What would you want to happen automatically before every commit?"

---

### Slide 5: Agents — Specialized Sub-Agents

**Key Points:**

- Agents are focused helpers with their own system prompts
- Can have different models, tool access
- Use for research, code review, orchestration

**Question to ask:**
> "What task would benefit from a dedicated expert agent?"

---

### Slide 6: Getting Started

**Commands:**

```bash
cd workshop/my-plugin-day-02
./init.sh    # or: make setup
```

**What init.sh does:**

1. Checks dependencies (gh, claude CLI)
2. Clones plugin scaffold into .claude/
3. Asks for plugin name
4. Starts Claude Code

**Then talk to Claude:**

```
"Build my plugin"
"Create a skill for X"
"Add a pre-commit hook"
"Validate my plugin"
```

---

### Slide 7: Available MCPs

**Key Points:**

- Reminder of what MCPs are available
- Skills can specify allowed-tools in frontmatter
- Use `mcp__*` to allow all MCP tools

---

### Slide 8: Your Exercise

**Key Points:**

- 45 minutes to build a full plugin
- Build on yesterday's skill OR start fresh
- Must add at least one hook or agent

**Ideas:**

- Pre-commit hook: validate PR descriptions, check for TODOs
- Research agent: deep dive tickets, find related code
- Session-start hook: load team context, check calendar

---

### Slide 9: BUILD

- Start the timer: 45 minutes
- Circulate and help
- Encourage trying hooks/agents, not just more skills

---

### Slide 10: Demo Showcase

**Questions for volunteers:**
> "What did you build?"
> "What hook or agent did you add?"
> "How will your team use this?"

- Get 3-4 volunteers, 3 minutes each

---

### Slide 11: Sharing Your Plugin

**Commands:**

```bash
# Push to GitHub
"Set up GitHub remote"
# or manually:
git remote add origin git@github.com:Gusto/your-plugin.git
git push -u origin main

# Add to marketplace
/plugin marketplace add Gusto/your-plugin-name

# Teammates install via
/plugins
```

---

### Slide 12: What's Next — Round Table

**Key Points:**

- Transition to discussion format
- Three topics: Adoption, Guardrails, Strategy
- Bring questions from building

---

### Slide 13: Close

**Key Quote:**
> "Automate the automation."

**Takeaway:**

- Skills are just the start. Build the whole system.

---

## Day 2: Round Table (after Plugin Deep Dive)

### Slide 1: Title

- Transition from build session to discussion
- "From Build to Team Strategy"

### Slide 2: What You Built

**Questions to ask:**
> "What skill, hook, or agent did you create?"
> "What will it save you next week?"
> "What would make it useful for your team?"

**Key Points:**

- Give them 2 minutes to jot down answers
- This grounds the discussion in their actual work

---

### Slide 3: Now What?

**Key Points:**

- They built something — now the question is adoption
- Three discussions coming up

---

### Slide 4: Block 1 — Getting Your Team On Board (20 min)

**Questions to ask:**
> "Your plugin is ready. Who needs to use it?"
> "Who on your team is all-in on Claude? Who's hesitant?"
> "What would get the hesitant folks to try it?"
> "Who could be a Claude champion for your squad?"

**Key Points:**

- Identify champions
- Understand barriers to adoption

---

### Slide 5: Block 2 — Where NOT to Use Claude (20 min)

**Questions to ask:**
> "Let's build the list: where should we NOT use Claude?"
> "Business rules, compliance, PII — where's the line?"
> "What's your tolerance for wrong output if you can revert quickly?"
> "Should your plugin have guardrails built in?"

**Key Points (capture on whiteboard):**

- Build the "don't use" list collaboratively
- Discuss risk tolerance and reversibility

---

### Slide 6: Block 3 — Team Strategy (20 min)

**Questions to ask:**
> "What would 'alignment across USP PE' actually look like?"
> "If a new PE joins next month, how do you onboard them to Claude?"
> "Should we have a shared plugin for the team?"
> "What's worked that we can share right now?"

**Key Points:**

- Think about documentation and onboarding
- Consider a team-wide shared plugin

---

### Slide 7: Capture — Don't/Do

**Key Points:**

- Two columns on whiteboard or shared doc
- Capture the discussion outcomes
- This becomes team documentation

---

### Slide 8: Your Commitment

**Key Points:**

- Checkboxes make it concrete:
  - Ship plugin to someone
  - Help someone get started
  - Add something to workflow

**Action:**
> "Write it down. Tell a partner. 30 seconds each."

---

### Slide 9: Share Your Plugin

**Commands:**

```bash
"Set up GitHub remote"
/plugin marketplace add Gusto/your-plugin
```

**Key Points:**

- Don't let it sit on your laptop
- Push, publish, tell your team

---

### Slide 10: Next Steps

**Key Points:**

- **This Week:** Ship to GitHub (even if rough)
- **This Month:** Get 2 teammates using it
- **Ongoing:** Office hours available

---

### Slide 11: Close

**Key Quote:**
> "Now is a time to figure out how to automate and be lazy."

**Takeaway:**

- You built tools today. Now ship them.

---

## Quick Reference Commands

```bash
# Day 1 setup (simple)
mkdir -p my-skill/.claude/skills/my-skill
touch .claude/skills/my-skill/SKILL.md
claude

# Day 2 setup (full scaffold)
cd workshop/my-plugin-day-02
./init.sh                   # or: make setup

# Plugin basics
/plugins                    # Browse marketplace
/mcp                        # See connected MCPs

# Building (talk to Claude)
"Build my plugin"           # Start the plugin wizard
"Create a skill for X"      # Create a new skill
"Add a pre-commit hook"     # Create a hook
"Create an agent for Y"     # Create an agent
"Validate my plugin"        # Check plugin structure
"Set up GitHub remote"      # Push to GitHub

# Day 1 demos
/day01-jira-analyzer-01 USPRTE-924
/day01-jira-analyzer-02 USPRTE-924 CARE

# Sharing
git push -u origin main
/plugin marketplace add Gusto/your-plugin
```
