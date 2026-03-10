#!/bin/bash
# Validate memory structure
set -e

WORKSPACE="${WORKSPACE_DIR:-$HOME/.openclaw/workspace}"
TODAY=$(date +%Y-%m-%d)

echo "🔍 Validating memory structure..."
echo ""

ERRORS=0

# Check MEMORY.md
if [[ -f "$WORKSPACE/MEMORY.md" ]]; then
  echo "✅ MEMORY.md exists"
else
  echo "❌ MEMORY.md not found"
  ((ERRORS++))
fi

# Check directories
REQUIRED_DIRS=(
  "memory"
  "memory/knowledge"
  "memory/tasks"
  "memory/daily"
  "memory/logs"
)

for dir in "${REQUIRED_DIRS[@]}"; do
  if [[ -d "$WORKSPACE/$dir" ]]; then
    echo "✅ $dir/ exists"
  else
    echo "❌ $dir/ not found"
    ((ERRORS++))
  fi
done

# Check today's daily log
DAILY_LOG="$WORKSPACE/memory/$TODAY.md"
if [[ -f "$DAILY_LOG" ]]; then
  echo "✅ Today's daily log exists: $TODAY.md"
else
  echo "⚠️  Today's daily log not found: $TODAY.md"
  echo "   Run init-memory.sh to create it"
fi

# Check file permissions
if [[ -r "$WORKSPACE/MEMORY.md" && -w "$WORKSPACE/MEMORY.md" ]]; then
  echo "✅ MEMORY.md is readable and writable"
else
  echo "❌ MEMORY.md permission issue"
  ((ERRORS++))
fi

echo ""
if [[ $ERRORS -eq 0 ]]; then
  echo "✅ Memory structure is valid!"
  exit 0
else
  echo "❌ Found $ERRORS error(s)"
  echo "   Run init-memory.sh to fix"
  exit 1
fi
