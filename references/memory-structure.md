# Memory Structure Reference

Complete reference for the layered memory architecture.

## Directory Structure

```
workspace/
├── MEMORY.md                    # Long-term curated memory
└── memory/
    ├── YYYY-MM-DD.md           # Daily logs (today, yesterday, etc.)
    ├── knowledge/              # Domain-specific documentation
    │   ├── api-docs.md
    │   ├── deployment/
    │   └── troubleshooting/
    ├── tasks/                  # Task tracking
    │   ├── active.md
    │   ├── completed/
    │   └── backlog.md
    ├── daily/                  # Daily log archives
    │   └── archives/
    │       ├── 2026-02/
    │       └── 2026-01/
    └── logs/                   # System logs
        ├── initialization.md
        └── maintenance.md
```

## File Naming Conventions

### Daily Logs
- Format: `YYYY-MM-DD.md`
- Example: `2026-03-10.md`
- Location: `memory/` (root level)

### Knowledge Base
- Use descriptive names
- Group by domain in subdirectories
- Examples:
  - `api-docs.md`
  - `deployment/aws-guide.md`
  - `troubleshooting/common-errors.md`

### Task Files
- `active.md` - Current tasks
- `backlog.md` - Future tasks
- `completed/YYYY-MM.md` - Completed tasks by month

## Content Guidelines

### MEMORY.md Structure

```markdown
# MEMORY.md

## User
- Name: 
- Timezone: 
- Language: 

## Preferences
- 

## Projects
### Project Name
- Status: 
- Started: 
- Key decisions: 

## Important Context
- 

## Lessons Learned
- 
```

### Daily Log Structure

```markdown
# YYYY-MM-DD

## Morning
- Task completed
- Decision made
- Problem encountered

## Afternoon
- 

## Evening
- 

## Notes
- 
```

### Knowledge Base Structure

```markdown
# Topic Name

## Overview
Brief description

## Details
Detailed information

## Examples
Code examples or use cases

## References
- Link 1
- Link 2
```

## Memory Lifecycle

### Creation
1. Daily logs created automatically each day
2. Knowledge base files created as needed
3. Task files created when first task added

### Maintenance
1. **Daily**: Update today's log
2. **Weekly**: Review and archive old logs
3. **Monthly**: Update MEMORY.md with insights
4. **Quarterly**: Clean up knowledge base

### Archival
1. Move logs older than 30 days to `daily/archives/YYYY-MM/`
2. Compress completed tasks to monthly summaries
3. Remove outdated knowledge base entries

## Search Patterns

### Find Recent Events
```bash
grep -r "keyword" memory/2026-03-*.md
```

### Search Knowledge Base
```bash
grep -r "topic" memory/knowledge/
```

### Find Tasks
```bash
grep -r "TODO\|DONE" memory/tasks/
```

## Integration Examples

### With Git
```bash
# Daily commit
cd memory/
git add .
git commit -m "Memory update $(date +%Y-%m-%d)"
git push
```

### With Backup
```bash
# Backup to external drive
rsync -av memory/ /Volumes/Backup/memory/
```

### With Search Tools
```bash
# Use ripgrep for fast search
rg "pattern" memory/
```

## Best Practices

1. **Consistency**: Use the same structure across all files
2. **Clarity**: Write for future-you who forgot the context
3. **Completeness**: Include dates, names, and decisions
4. **Conciseness**: Keep entries focused and relevant
5. **Security**: Never store credentials in memory files

## Common Patterns

### Project Tracking
```markdown
## Projects
### E-commerce Platform
- Status: In development
- Started: 2026-01-15
- Tech stack: React, Node.js, PostgreSQL
- Key decisions:
  - Chose PostgreSQL over MongoDB for data consistency
  - Using Stripe for payments
- Next steps:
  - Implement checkout flow
  - Add payment gateway
```

### Decision Log
```markdown
## 2026-03-10

### Decision: Use TypeScript
- Context: Team debated JS vs TS
- Decision: Migrate to TypeScript
- Rationale: Better type safety, easier refactoring
- Impact: 2-week migration timeline
```

### Problem Tracking
```markdown
## 2026-03-10

### Problem: Slow API Response
- Symptom: /api/users taking 5s
- Investigation: Database query missing index
- Solution: Added index on user_id
- Result: Response time reduced to 200ms
```

---

**Version:** 2.0.0  
**Last Updated:** 2026-03-10
