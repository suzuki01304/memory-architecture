#!/bin/bash
# Memory Cleanup - 清理过时和冗余的记忆
# 灵感来源: dependency-auditor 的清理系统

set -e

WORKSPACE="${1:-~/.openclaw/workspace}"
MEMORY_DIR="$WORKSPACE/memory"
DRY_RUN="${2:-false}"

echo "🧹 Memory Cleanup"
echo "Workspace: $WORKSPACE"
echo "Dry run: $DRY_RUN"
echo ""

if [ ! -d "$MEMORY_DIR" ]; then
    echo "❌ Memory directory not found: $MEMORY_DIR"
    exit 1
fi

# 1. 清理空文件
echo "## Cleaning Empty Files"
EMPTY_FILES=$(find "$MEMORY_DIR" -type f -name "*.md" -empty)
if [ -n "$EMPTY_FILES" ]; then
    echo "$EMPTY_FILES" | while read -r file; do
        if [ "$DRY_RUN" = "true" ]; then
            echo "Would delete: $file"
        else
            echo "Deleting: $file"
            rm "$file"
        fi
    done
else
    echo "✅ No empty files found"
fi

# 2. 清理旧的日志文件（>90天）
echo ""
echo "## Cleaning Old Logs (>90 days)"
OLD_LOGS=$(find "$MEMORY_DIR/logs" -type f -name "*.md" -mtime +90 2>/dev/null || true)
if [ -n "$OLD_LOGS" ]; then
    echo "$OLD_LOGS" | while read -r file; do
        if [ "$DRY_RUN" = "true" ]; then
            echo "Would archive: $file"
        else
            echo "Archiving: $file"
            mkdir -p "$MEMORY_DIR/archive/logs"
            mv "$file" "$MEMORY_DIR/archive/logs/"
        fi
    done
else
    echo "✅ No old logs found"
fi

# 3. 清理重复内容
echo ""
echo "## Detecting Duplicate Content"
TEMP_FILE="/tmp/memory-duplicates.txt"
find "$MEMORY_DIR" -type f -name "*.md" -exec cat {} \; | sort | uniq -d > "$TEMP_FILE"
DUPLICATE_COUNT=$(wc -l < "$TEMP_FILE" | tr -d ' ')
if [ "$DUPLICATE_COUNT" -gt 0 ]; then
    echo "⚠️  Found $DUPLICATE_COUNT duplicate lines"
    echo "Review: $TEMP_FILE"
else
    echo "✅ No significant duplicates found"
    rm "$TEMP_FILE"
fi

# 4. 优化建议
echo ""
echo "## Optimization Recommendations"
TOTAL_SIZE=$(find "$MEMORY_DIR" -type f -name "*.md" -exec stat -f "%z" {} \; 2>/dev/null | awk '{s+=$1} END {print s}')
FILE_COUNT=$(find "$MEMORY_DIR" -type f -name "*.md" | wc -l | tr -d ' ')

if [ $TOTAL_SIZE -gt 10485760 ]; then  # >10MB
    echo "⚠️  Memory size is large ($(numfmt --to=iec $TOTAL_SIZE 2>/dev/null || echo "${TOTAL_SIZE} bytes"))"
    echo "   Consider archiving old content"
fi

if [ $FILE_COUNT -gt 100 ]; then
    echo "⚠️  Many memory files ($FILE_COUNT)"
    echo "   Consider consolidating related content"
fi

echo ""
echo "---"
if [ "$DRY_RUN" = "true" ]; then
    echo "ℹ️  Dry run complete. Run without --dry-run to apply changes."
else
    echo "✅ Cleanup complete"
fi
