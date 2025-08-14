#!/bin/bash

# Script to publish updates to the Indent PR Review Action

set -e

# Check if a tag argument was provided
TAG="${1:-beta}"

echo "🚀 Publishing Indent PR Review Action to @$TAG..."

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

# Update the specified tag
echo "🏷️  Updating $TAG tag..."
git tag -d "$TAG" 2>/dev/null || true
git push origin ":refs/tags/$TAG" 2>/dev/null || true
git tag "$TAG"
git push origin "$TAG"

echo "✅ Successfully published action to @$TAG tag"
echo "🔗 Action can now be used with: indent-com/pr-review-action@$TAG"
