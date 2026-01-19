#!/usr/bin/env bash
# git-repos-cli - List and filter local git repositories
# https://github.com/Ruashots/git-repos-cli

REPOS_USER="${REPOS_USER:-}"

repos () {
  local filter="${1:-}"
  local d url branch state dirty status_output

  for d in */; do
    git -C "$d" rev-parse --is-inside-work-tree >/dev/null 2>&1 || continue

    url=$(git -C "$d" remote get-url origin 2>/dev/null)
    [[ -n "$filter" && ! "$url" =~ $filter ]] && continue

    status_output=$(git -C "$d" status --porcelain --branch 2>/dev/null)
    branch=$(head -1 <<< "$status_output" | sed 's/^## //; s/\.\.\..*//; s/No commits yet on //')
    [[ -z "$branch" || "$branch" == "HEAD (no branch)" ]] && branch="detached"

    dirty=$(tail -n +2 <<< "$status_output" | wc -l)
    if (( dirty > 0 )); then
      state=$'\e[33mDIRTY\e[0m'
    else
      state=$'\e[32mCLEAN\e[0m'
    fi

    printf "\e[1;32m%-28s\e[0m \e[36m(%s)\e[0m  %b  \e[2m%s\e[0m\n" \
      "$d" "$branch" "$state" "${url:-NO_ORIGIN}"
  done
}

myrepos () {
  if [[ -z "$REPOS_USER" ]]; then
    echo "REPOS_USER not set. Run: export REPOS_USER='yourusername'" >&2
    return 1
  fi
  repos "$REPOS_USER"
}
