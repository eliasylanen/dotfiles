#!/bin/bash

# Define colors for PS1
GREEN="\[\e[32m\]"
BLUE="\[\e[36m\]"
YELLOW="\[\e[33m\]"
RESET="\[\e[m\]"

function parse_git_branch() {
	# Get the current branch name or short SHA
	local branch
	if ! branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
		branch=$(git rev-parse --short HEAD 2>/dev/null)
	fi

	# If we are in a git repo (branch is not empty)
	if [ -n "$branch" ]; then
		local stat
		stat=$(parse_git_dirty)
		echo "[${branch}${stat}]"
	fi
}

function parse_git_dirty() {
	# Use --porcelain for stable, parsable output
	# -b includes branch info (ahead/behind)
	local status
	status=$(git status --porcelain -b 2>/dev/null)

	# If git command failed, return empty
	if [ $? -ne 0 ]; then return; fi

	local bits=""

	# Check status flags
	# Renamed
	if echo "$status" | grep -q "^R"; then
		bits=">${bits}"
	fi

	# Ahead (check the branch line starting with ##)
	if echo "$status" | grep -q "^## .*ahead"; then
		bits="*${bits}"
	fi

	# New file (Added to index)
	if echo "$status" | grep -q "^A"; then
		bits="+${bits}"
	fi

	# Untracked
	if echo "$status" | grep -q "^??"; then
		bits="?${bits}"
	fi

	# Deleted (in index or worktree)
	if echo "$status" | grep -qE "^(D.|.D)"; then
		bits="x${bits}"
	fi

	# Modified (in index or worktree)
	if echo "$status" | grep -qE "^(M.|.M)"; then
		bits="!${bits}"
	fi

	if [ -n "$bits" ]; then
		echo " ${bits}"
	fi
}

export PS1="${GREEN}\u${RESET}@${GREEN}\h${RESET}:${BLUE}\w${RESET} ${YELLOW}\$(parse_git_branch)${RESET}\\$ "
