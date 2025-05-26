#!/bin/bash
set -e

# Create release script for robosystems-app
# Creates a new release branch and commits version changes
# Usage: ./bin/create-release.sh [major|minor|patch]

# Default to patch if no argument provided
VERSION_TYPE=${1:-patch}

# Validate the version type
if [[ "$VERSION_TYPE" != "major" && "$VERSION_TYPE" != "minor" && "$VERSION_TYPE" != "patch" ]]; then
  echo "Invalid version type: $VERSION_TYPE. Use major, minor, or patch."
  exit 1
fi

# Path to package.json
PACKAGE_PATH="package.json"

# Check if package.json exists
if [ ! -f "$PACKAGE_PATH" ]; then
  echo "Error: $PACKAGE_PATH not found"
  exit 1
fi

# Extract current version using jq (if available) or a more robust awk/sed approach
if command -v jq &> /dev/null; then
  # If jq is available, use it
  CURRENT_VERSION=$(jq -r '.version' "$PACKAGE_PATH")
else
  # Fallback to awk/sed for parsing JSON
  CURRENT_VERSION=$(awk -F'"' '/"version":/ {print $4}' "$PACKAGE_PATH")
fi

if [ -z "$CURRENT_VERSION" ]; then
  echo "Could not find version in $PACKAGE_PATH"
  exit 1
fi

echo "Current version: $CURRENT_VERSION"

# Split version into major, minor, and patch
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# Increment appropriate version component
if [ "$VERSION_TYPE" = "major" ]; then
  MAJOR=$((MAJOR + 1))
  MINOR=0
  PATCH=0
elif [ "$VERSION_TYPE" = "minor" ]; then
  MINOR=$((MINOR + 1))
  PATCH=0
else # patch
  PATCH=$((PATCH + 1))
fi

NEW_VERSION="$MAJOR.$MINOR.$PATCH"

# Check if we're on a clean working tree
if ! git diff-index --quiet HEAD --; then
  echo "Error: Your working tree has uncommitted changes. Please commit or stash them before bumping the version."
  exit 1
fi

# Create and checkout new branch
BRANCH_NAME="release/$NEW_VERSION"
echo "Creating new branch: $BRANCH_NAME"
git checkout -b "$BRANCH_NAME"

# Update version in the file
if command -v jq &> /dev/null; then
  # Use jq to update the version properly
  jq ".version = \"$NEW_VERSION\"" "$PACKAGE_PATH" > "$PACKAGE_PATH.tmp" && mv "$PACKAGE_PATH.tmp" "$PACKAGE_PATH"
else
  # Fallback to sed
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS uses BSD sed which needs an empty string for -i
    sed -i '' "s/\"version\": \"$CURRENT_VERSION\"/\"version\": \"$NEW_VERSION\"/" "$PACKAGE_PATH"
  else
    # Linux uses GNU sed
    sed -i "s/\"version\": \"$CURRENT_VERSION\"/\"version\": \"$NEW_VERSION\"/" "$PACKAGE_PATH"
  fi
fi

# Update package-lock.json and reinstall dependencies
echo "Updating package-lock.json and dependencies..."
npm install

# Commit the changes
git add "$PACKAGE_PATH"
if [ -f "package-lock.json" ]; then
  git add "package-lock.json"
fi

git commit -m "Bump version from $CURRENT_VERSION to $NEW_VERSION"
git push origin "$BRANCH_NAME"

echo "Version bumped: $CURRENT_VERSION → $NEW_VERSION"
echo "Branch created: $BRANCH_NAME"
echo "Changes committed successfully"
exit 0