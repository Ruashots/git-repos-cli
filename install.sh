#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOS_SCRIPT="$SCRIPT_DIR/repos.sh"

# Detect shell config file
if [[ -n "$ZSH_VERSION" ]] || [[ "$SHELL" == */zsh ]]; then
  SHELL_RC="$HOME/.zshrc"
else
  SHELL_RC="$HOME/.bashrc"
fi

# Get username from argument or prompt
if [[ -n "$1" ]]; then
  USERNAME="$1"
else
  read -rp "Enter your GitHub/Git username (for myrepos filter): " USERNAME
fi

# Check if already installed
if grep -q "git-repos-cli" "$SHELL_RC" 2>/dev/null; then
  echo "git-repos-cli is already installed in $SHELL_RC"
  echo "To update REPOS_USER, edit $SHELL_RC manually."
  exit 0
fi

# Backup existing config
cp "$SHELL_RC" "$SHELL_RC.backup.$(date +%s)"

# Append to shell config
cat >> "$SHELL_RC" << EOF

# git-repos-cli
export REPOS_USER="$USERNAME"
source "$REPOS_SCRIPT"
EOF

echo "Installed to $SHELL_RC"
echo ""
echo "To activate now, run:"
echo "  source $SHELL_RC"
echo ""
echo "Commands available:"
echo "  repos        - List all git repos in current directory"
echo "  repos FILTER - List repos matching FILTER pattern"
echo "  myrepos      - List repos matching '$USERNAME'"
