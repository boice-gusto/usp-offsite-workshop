#!/bin/bash
# Day 2 Workshop Initialization Script
# Checks dependencies, pulls claude-scaffolding, and gets you started

set -e

SCAFFOLDING_REPO="Gusto/claude-plugin-scaffold"
CLONE_DIR="claude-plugin-scaffold"
TARGET_DIR=".claude"

echo "🚀 Day 2 Workshop Setup"
echo "======================="
echo ""

# Check for Homebrew (needed for installing deps on macOS)
check_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "⚠️  Homebrew not found."
        read -p "Install Homebrew? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        else
            echo "❌ Homebrew required for installing dependencies. Exiting."
            exit 1
        fi
    fi
}

# Check for GitHub CLI
check_gh() {
    echo -n "Checking for GitHub CLI (gh)... "
    if command -v gh &> /dev/null; then
        echo "✅ $(gh --version | head -1)"
    else
        echo "❌ Not found"
        check_homebrew
        read -p "Install GitHub CLI? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            brew install gh
            echo "✅ GitHub CLI installed"
        else
            echo "⚠️  Skipping gh install. Some features may not work."
        fi
    fi
}

# Check for Claude CLI
check_claude() {
    echo -n "Checking for Claude CLI... "
    if command -v claude &> /dev/null; then
        echo "✅ $(claude --version 2>/dev/null || echo 'installed')"
    else
        echo "❌ Not found"
        read -p "Install Claude CLI via npm? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if command -v npm &> /dev/null; then
                npm install -g @anthropic-ai/claude-code
                echo "✅ Claude CLI installed"
            else
                echo "❌ npm not found. Please install Node.js first."
                echo "   Run: brew install node"
                exit 1
            fi
        else
            echo "❌ Claude CLI required. Exiting."
            exit 1
        fi
    fi
}

# Check gh authentication
check_gh_auth() {
    echo -n "Checking GitHub authentication... "
    if gh auth status &> /dev/null; then
        echo "✅ Authenticated"
    else
        echo "❌ Not authenticated"
        read -p "Login to GitHub? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            gh auth login
        else
            echo "⚠️  Skipping auth. You may need to authenticate later."
        fi
    fi
}

# Pull claude-scaffolding
pull_scaffolding() {
    echo ""
    echo "📦 Setting up claude-scaffolding..."

    if [ -d "$TARGET_DIR" ]; then
        echo "⚠️  Directory '$TARGET_DIR' already exists."
        read -p "Remove and re-clone? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$TARGET_DIR"
        else
            echo "Skipping clone. Using existing directory."
            return
        fi
    fi

    # Clean up any leftover clone dir
    rm -rf "$CLONE_DIR" 2>/dev/null

    # Try gh first, fall back to git
    if command -v gh &> /dev/null && gh auth status &> /dev/null; then
        echo "Cloning via GitHub CLI..."
        gh repo clone "$SCAFFOLDING_REPO" 2>/dev/null || {
            echo "⚠️  Repository not found or private. Using template structure..."
            create_template
            return
        }
    else
        echo "Cloning via git..."
        git clone "https://github.com/$SCAFFOLDING_REPO.git" 2>/dev/null || {
            echo "⚠️  Repository not found. Using template structure..."
            create_template
            return
        }
    fi

    # Rename cloned repo to .claude
    if [ -d "$CLONE_DIR" ]; then
        mv "$CLONE_DIR" "$TARGET_DIR"
        echo "✅ Plugin scaffolding ready in .claude/"
    fi
}

# Create a basic template if scaffolding repo isn't available
create_template() {
    echo "Creating plugin template structure..."
    mkdir -p "$TARGET_DIR/.claude-plugin"
    mkdir -p "$TARGET_DIR/skills"
    mkdir -p "$TARGET_DIR/hooks"
    mkdir -p "$TARGET_DIR/agents"

    # Create manifest
    cat > "$TARGET_DIR/.claude-plugin/manifest.json" << 'EOF'
{
  "name": "my-plugin",
  "version": "0.1.0",
  "description": "My Claude Code plugin",
  "author": "",
  "skills": ["skills"],
  "hooks": ["hooks"],
  "agents": ["agents"]
}
EOF

    # Create CLAUDE.md
    cat > "$TARGET_DIR/CLAUDE.md" << 'EOF'
# My Plugin

This is a Claude Code plugin created with the Day 2 workshop template.

## Skills

Add your custom skills in `skills/`.

## Hooks

Add your hooks in `hooks/`.

## Getting Started

1. Edit the manifest in `.claude-plugin/manifest.json`
2. Create your first skill
3. Test with `claude` in the parent directory
EOF

    echo "✅ Template created"
}

# Ask for package name and update manifest
name_plugin() {
    echo ""
    echo "📝 Name your plugin"
    read -p "What do you want to call your plugin? [my-plugin]: " PLUGIN_NAME
    PLUGIN_NAME="${PLUGIN_NAME:-my-plugin}"

    # Update manifest.json if it exists
    if [ -f "$TARGET_DIR/.claude-plugin/manifest.json" ]; then
        sed -i '' "s/\"name\": \"my-plugin\"/\"name\": \"$PLUGIN_NAME\"/" "$TARGET_DIR/.claude-plugin/manifest.json" 2>/dev/null || \
        sed -i "s/\"name\": \"my-plugin\"/\"name\": \"$PLUGIN_NAME\"/" "$TARGET_DIR/.claude-plugin/manifest.json"
        echo "✅ Plugin named '$PLUGIN_NAME'"
    fi
}

# Offer to start Claude
start_claude() {
    echo ""
    echo "🎉 Setup complete!"
    echo "   Plugin created in: .claude/"
    echo ""
    read -p "Start Claude Code? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo ""
        echo "Starting Claude Code..."
        echo "========================"
        claude
    else
        echo ""
        echo "To get started manually:"
        echo "  claude"
    fi
}

# Main
main() {
    check_gh
    check_claude
    check_gh_auth
    pull_scaffolding
    name_plugin
    start_claude
}

main
