#!/bin/bash
# Initialize memory structure for AI agents
set -e

WORKSPACE="${WORKSPACE_DIR:-$HOME/.openclaw/workspace}"
TODAY=$(date +%Y-%m-%d)

echo "🚀 Initializing memory structure..."

# Create directories
mkdir -p "$WORKSPACE/memory/knowledge"
mkdir -p "$WORKSPACE/memory/tasks"
mkdir -p "$WORKSPACE/memory/daily/archives"
mkdir -p "$WORKSPACE/memory/logs"

# Create MEMORY.md if not exists
if [[ ! -f "$WORKSPACE/MEMORY.md" ]]; then
  cat > "$WORKSPACE/MEMORY.md" <<'EOF'
# MEMORY.md

## User
- Name: 
- Timezone: 
- Language: 

## Preferences
- 

## Projects
- 

## Important Context
- 
EOF
  echo "✅ Created MEMORY.md"
else
  echo "ℹ️  MEMORY.md already exists"
fi

# Create today's daily log if not exists
DAILY_LOG="$WORKSPACE/memory/$TODAY.md"
if [[ ! -f "$DAILY_LOG" ]]; then
  cat > "$DAILY_LOG" <<EOF
# $TODAY

## Morning
- 

## Afternoon
- 

## Evening
- 
EOF
  echo "✅ Created daily log: $TODAY.md"
else
  echo "ℹ️  Daily log already exists: $TODAY.md"
fi

# Create initialization log
INIT_LOG="$WORKSPACE/memory/logs/initialization.md"
if [[ ! -f "$INIT_LOG" ]]; then
  cat > "$INIT_LOG" <<EOF
# Initialization Log

## $(date '+%Y-%m-%d %H:%M:%S')
- Memory structure initialized
- Created directories: knowledge, tasks, daily, logs
- Created MEMORY.md
- Created daily log: $TODAY.md
EOF
  echo "✅ Created initialization log"
else
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Memory structure validated" >> "$INIT_LOG"
fi

echo ""
echo "✅ Memory structure ready!"
echo ""
echo "Structure:"
echo "  $WORKSPACE/"
echo "  ├── MEMORY.md"
echo "  └── memory/"
echo "      ├── $TODAY.md"
echo "      ├── knowledge/"
echo "      ├── tasks/"
echo "      ├── daily/"
echo "      │   └── archives/"
echo "      └── logs/"
echo ""
