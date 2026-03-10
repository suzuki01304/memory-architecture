#!/bin/bash
# Memory Optimize - 优化记忆结构和性能
# 灵感来源: dependency-auditor 的优化系统

set -e

WORKSPACE="${1:-~/.openclaw/workspace}"
MEMORY_DIR="$WORKSPACE/memory"

echo "⚡ Memory Optimization"
echo "Workspace: $WORKSPACE"
echo ""

if [ ! -d "$MEMORY_DIR" ]; then
    echo "❌ Memory directory not found: $MEMORY_DIR"
    exit 1
fi

# 1. 检查目录结构
echo "## Directory Structure"
REQUIRED_DIRS=("identity" "knowledge" "tasks" "daily" "logs")
for dir in "${REQUIRED_DIRS[@]}"; do
    if [ ! -d "$MEMORY_DIR/$dir" ]; then
        echo "Creating: $MEMORY_DIR/$dir"
        mkdir -p "$MEMORY_DIR/$dir"
    else
        echo "✅ $dir/"
    fi
done

# 2. 整理未分类文件
echo ""
echo "## Organizing Uncategorized Files"
UNCATEGORIZED=$(find "$MEMORY_DIR" -maxdepth 1 -type f -name "*.md" ! -name "MEMORY.md" ! -name "SYSTEM.md")
if [ -n "$UNCATEGORIZED" ]; then
    echo "$UNCATEGORIZED" | while read -r file; do
        filename=$(basename "$file")
        # 根据文件名模式分类
        if [[ "$filename" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}\.md$ ]]; then
            echo "Moving to daily/: $filename"
            mv "$file" "$MEMORY_DIR/daily/"
        else
            echo "Moving to knowledge/: $filename"
            mv "$file" "$MEMORY_DIR/knowledge/"
        fi
    done
else
    echo "✅ All files are organized"
fi

# 3. 压缩旧的日志文件
echo ""
echo "## Compressing Old Logs"
OLD_LOGS=$(find "$MEMORY_DIR/logs" -type f -name "*.md" -mtime +30 2>/dev/null || true)
if [ -n "$OLD_LOGS" ]; then
    ARCHIVE_DIR="$MEMORY_DIR/archive/logs"
    mkdir -p "$ARCHIVE_DIR"
    tar -czf "$ARCHIVE_DIR/logs-$(date +%Y%m).tar.gz" $OLD_LOGS
    echo "✅ Archived old logs to $ARCHIVE_DIR/logs-$(date +%Y%m).tar.gz"
    echo "$OLD_LOGS" | while read -r file; do
        rm "$file"
    done
else
    echo "✅ No old logs to compress"
fi

# 4. 生成索引
echo ""
echo "## Generating Index"
INDEX_FILE="$MEMORY_DIR/INDEX.md"
cat > "$INDEX_FILE" << 'EOF'
# Memory Index

> Auto-generated: $(date)

## Structure

- `identity/` - Personal information and identity
- `knowledge/` - Long-term knowledge and references
- `tasks/` - Task tracking and project management
- `daily/` - Daily logs and notes
- `logs/` - System logs and initialization records
- `archive/` - Archived content

## Quick Links

EOF

# 添加最近更新的文件
echo "### Recently Updated" >> "$INDEX_FILE"
find "$MEMORY_DIR" -type f -name "*.md" ! -name "INDEX.md" -exec stat -f "%m %N" {} \; 2>/dev/null | sort -rn | head -10 | while read -r timestamp file; do
    relative_path=$(echo "$file" | sed "s|$MEMORY_DIR/||")
    echo "- [$relative_path]($relative_path)" >> "$INDEX_FILE"
done

echo "✅ Index generated: $INDEX_FILE"

# 5. 性能统计
echo ""
echo "## Performance Stats"
TOTAL_SIZE=$(find "$MEMORY_DIR" -type f -name "*.md" -exec stat -f "%z" {} \; 2>/dev/null | awk '{s+=$1} END {print s}')
FILE_COUNT=$(find "$MEMORY_DIR" -type f -name "*.md" | wc -l | tr -d ' ')
echo "Total size: $(numfmt --to=iec $TOTAL_SIZE 2>/dev/null || echo "${TOTAL_SIZE} bytes")"
echo "File count: $FILE_COUNT"
echo "Average size: $(numfmt --to=iec $((TOTAL_SIZE / FILE_COUNT)) 2>/dev/null || echo "$((TOTAL_SIZE / FILE_COUNT)) bytes")/file"

echo ""
echo "---"
echo "✅ Optimization complete"
