# Day 1 Workshop: Build Your First Skill

Welcome to Day 1! Today you'll learn how Claude Code skills work by exploring an example and creating your own.

## What's in this folder

```bash
my-plugin-day-01/
├── .claude/
│   └── skills/
│       └── monkey-banana/
│           └── SKILL.md      # Example skill
└── README.md
```

## Getting Started

1. **Open this folder in Claude Code:**

   ```bash
   cd my-plugin-day-01
   claude
   ```

2. **Try the example skill:**

   ```bash
   /monkey-banana explain how the internet works
   ```

3. **Explore how it works:**
   - Open `.claude/skills/monkey-banana/SKILL.md`
   - Notice the frontmatter (name, description, arguments)
   - See how the instructions define Claude's behavior

## Exercise: Create Your Own Skill

Create a new skill in `.claude/skills/`. Some ideas:

- **code-reviewer** - Reviews code in a specific style
- **eli5** - Explains things like you're 5
- **haiku-response** - Responds only in haiku
- **pirate-translator** - Translates text to pirate speak
- **debug-buddy** - Helps debug with a systematic approach

### Skill Structure

```bash
.claude/skills/your-skill-name/
└── SKILL.md
```

### SKILL.md Template

```markdown
---
name: your-skill-name
description: What your skill does (shown in skill list)
arguments:
  - name: input
    description: What the user provides
    required: true
---

# Your Skill Name

## Usage

/your-skill-name <input>

## Behavior

Describe how Claude should behave when this skill is invoked.
Include examples, tone guidance, and output format.
```

## Tips

- Keep skills focused on one thing
- Be specific about the output format you want
- Include examples in your SKILL.md
- Test your skill and iterate on the instructions

## Next Steps

After creating your skill, try it out! If it doesn't behave as expected, refine the instructions in SKILL.md.

Tomorrow in Day 2, we'll explore hooks, agents, and the full plugin system.
