# git-repos-cli

A simple bash utility to list and filter local git repositories with status info.

## Features

- List all git repos in current directory
- Show branch name and dirty/clean status
- Show PUBLIC/PRIVATE visibility for GitHub repos (requires `gh` CLI)
- Filter repos by pattern (e.g., by username or host)
- Color-coded output for quick scanning

## Installation

```bash
git clone https://github.com/Ruashots/git-repos-cli.git
cd git-repos-cli
./install.sh your-github-username
source ~/.bashrc  # or ~/.zshrc
```

Or run the installer without arguments to be prompted for your username:

```bash
./install.sh
```

## Usage

```bash
# List all git repos in current directory
repos

# Filter repos by pattern
repos "github.com"
repos "your-username"

# List only your own repos (uses REPOS_USER)
myrepos
```

## Example Output

```
my-project/                  (main)    CLEAN  PUBLIC   https://github.com/user/my-project.git
another-repo/                (develop) DIRTY  PRIVATE  https://github.com/user/another-repo.git
forked-lib/                  (master)  CLEAN  PUBLIC   https://github.com/other/forked-lib.git
```

## Configuration

The `REPOS_USER` environment variable is set during installation. To change it:

```bash
export REPOS_USER="new-username"
```

Or edit your `~/.bashrc` / `~/.zshrc` directly.

## Uninstall

Remove these lines from your `~/.bashrc` or `~/.zshrc`:

```bash
# git-repos-cli
export REPOS_USER="..."
source "/path/to/git-repos-cli/repos.sh"
```

## License

MIT
