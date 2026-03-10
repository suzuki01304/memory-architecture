---
name: memory-architecture-v2
description: Layered memory architecture for AI agents. Use when designing or implementing persistent memory systems, understanding memory hierarchy (daily logs, long-term memory, knowledge base), or setting up memory workflows for AI assistants. Includes initialization scripts and validation tools.
---

# Memory Architecture

A layered memory system for AI agents that balances immediate context, daily logs, and long-term knowledge.

## Core Concept

**Memory is the key to a truly useful agent.** This architecture provides:
- Daily logs for raw events
- Long-term memory for curated insights
- Knowledge base for domain expertise
- Clear read/write boundaries

## Memory Layers

### 1. MEMORY.md (Long-Term Memory)
**Purpose:** Curated, distilled knowledge
**Update frequency:** Weekly or when significant events occur
**Content:**
- User preferences and context
- Important decisions and lessons
- Project summaries
- Persistent facts

**Example:**
```markdown
## User Preferences
- Timezone: Asia/Tokyo
- Language: English
- Work hours: 9-18 JST

## Projects
- Project X: E-commerce platform (started 2026-01)
```

### 2. memory/YYYY-MM-DD.md (Daily Logs)
**Purpose:** Raw event logs
**Update frequency:** Real-time during sessions
**Content:**
- Tasks completed
- Decisions made
- Problems encountered
- Conversations summary

**Example:**
```markdown
## 2026-03-10

### Morning
- Fixed bug in payment gateway
- User requested feature: dark mode

### Afternoon
- Deployed v2.1.0 to production
- Performance improved by 30%
```

### 3. memory/knowledge/ (Knowledge Base)
**Purpose:** Domain-specific documentation
**Update frequency:** As needed
**Content:**
- Technical documentation
- Process guides
- Reference materials
- Best practices

**Structure:**
```
memory/
├── knowledge/
│   ├── api-docs.md
│   ├── deployment-guide.md
│   └── troubleshooting.md
```

### 4. memory/tasks/ (Task Tracking)
**Purpose:** Active and completed tasks
**Update frequency:** Real-time
**Content:**
- TODO lists
- Task status
- Blockers
- Completed work

## Memory Workflow

### Daily Routine

1. **Session Start**
   - Read MEMORY.md (long-term context)
   - Read today's and yesterday's daily logs
   - Check active tasks

2. **During Session**
   - Log events to today's daily log
   - Update task status
   - Add to knowledge base as needed

3. **Session End**
   - Review today's log
   - Update MEMORY.md if significant events occurred
   - Archive completed tasks

### Weekly Maintenance

1. Review past week's daily logs
2. Extract significant insights
3. Update MEMORY.md with distilled learnings
4. Archive old daily logs
5. Clean up knowledge base

## Installation

### 1. Initialize Memory Structure

```bash
bash scripts/init-memory.sh
```

This creates:
```
memory/
├── YYYY-MM-DD.md (today's log)
├── knowledge/
├── tasks/
├── daily/
└── logs/
```

### 2. Validate Structure

```bash
bash scripts/validate-memory.sh
```

Checks:
- Required directories exist
- MEMORY.md is present
- Today's daily log exists
- File permissions are correct

## Best Practices

### DO ✅

1. **Write immediately** - Don't rely on "mental notes"
2. **Be specific** - Include dates, names, decisions
3. **Curate regularly** - Move important items to MEMORY.md
4. **Archive old logs** - Keep daily/ directory clean
5. **Use knowledge base** - Document processes and guides

### DON'T ❌

1. **Don't duplicate** - Same info shouldn't be in multiple places
2. **Don't store secrets** - Use separate private files
3. **Don't let logs pile up** - Archive monthly
4. **Don't skip validation** - Run checks regularly
5. **Don't forget context** - Always include "why" not just "what"

## Memory Boundaries

### What Goes in MEMORY.md
- User preferences
- Long-term project context
- Important decisions
- Persistent facts
- Lessons learned

### What Goes in Daily Logs
- Today's tasks
- Conversations
- Problems encountered
- Quick notes
- Temporary context

### What Goes in Knowledge Base
- Technical documentation
- Process guides
- Reference materials
- Best practices
- Domain expertise

### What Stays Private
- API keys and tokens
- Passwords
- Personal identifiable information
- Sensitive business data

## Integration with AI Agents

### Memory Recall

Before answering questions about:
- Prior work
- Decisions
- Dates
- People
- Preferences

**Always:**
1. Search MEMORY.md
2. Check recent daily logs
3. Query knowledge base if needed

### Memory Updates

After completing:
- Important tasks
- Making decisions
- Learning lessons
- Encountering problems

**Always:**
1. Log to today's daily log
2. Update MEMORY.md if significant
3. Add to knowledge base if reusable

## Troubleshooting

### Memory Not Loading
```bash
# Check file permissions
ls -la MEMORY.md memory/

# Validate structure
bash scripts/validate-memory.sh
```

### Daily Logs Missing
```bash
# Create today's log
bash scripts/init-memory.sh
```

### Knowledge Base Disorganized
```bash
# Review structure
tree memory/knowledge/

# Reorganize by domain
mkdir -p memory/knowledge/{api,deployment,troubleshooting}
```

## Advanced Usage

### Memory Search

Use semantic search to find relevant context:
```bash
# Search across all memory files
grep -r "keyword" memory/
```

### Memory Compression

Archive old daily logs:
```bash
# Move logs older than 30 days
find memory/daily/ -name "*.md" -mtime +30 -exec mv {} memory/daily/archives/ \;
```

### Memory Sync

Sync memory to remote backup:
```bash
# Git-based sync
cd memory/
git add .
git commit -m "Memory update $(date +%Y-%m-%d)"
git push
```

## Security Notes

- Never store credentials in memory files
- Use `.gitignore` for private directories
- Encrypt sensitive knowledge base files
- Regular security audits

## File Structure Reference

```
workspace/
├── MEMORY.md                    # Long-term memory
└── memory/
    ├── 2026-03-10.md           # Today's log
    ├── 2026-03-09.md           # Yesterday's log
    ├── knowledge/              # Knowledge base
    │   ├── api-docs.md
    │   └── guides/
    ├── tasks/                  # Task tracking
    │   ├── active.md
    │   └── completed/
    ├── daily/                  # Daily log archives
    │   └── archives/
    └── logs/                   # System logs
        └── initialization.md
```

---

**Version:** 2.0.0  
**License:** MIT  
**Inspired by:** Agent Vik's memory architecture
