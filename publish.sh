#!/bin/bash

# Script to publish updates to the Indent PR Review Action

set -e

echo "🚀 Publishing Indent PR Review Action..."

# Make sure we're on main branch
if [ "$(git branch --show-current)" != "main" ]; then
    echo "❌ Please switch to main branch first"
    exit 1
fi

# Make sure working directory is clean
if [ -n "$(git status --porcelain)" ]; then
    echo "❌ Working directory is not clean. Please commit your changes first."
    exit 1
fi

# Pull latest changes
echo "📥 Pulling latest changes..."
git pull origin main

# Update beta tag
echo "🏷️  Updating beta tag..."
git tag -d beta 2>/dev/null || true
git push origin :refs/tags/beta 2>/dev/null || true
git tag beta
git push origin beta

echo "✅ Successfully published action to @beta tag"
echo "🔗 Action can now be used with: exponent-run/pr-review-action@beta"
