#!/bin/bash
# Memory Health Check - 记忆健康度检查
# 灵感来源: dependency-auditor 的指标体系

set -e

WORKSPACE="${1:-~/.openclaw/workspace}"
MEMORY_DIR="$WORKSPACE/memory"

echo "🧠 Memory Health Check"
echo "Workspace: $WORKSPACE"
echo ""

# 检查记忆文件是否存在
if [ ! -d "$MEMORY_DIR" ]; then
    echo "❌ Memory directory not found: $MEMORY_DIR"
    exit 1
fi

# 1. 记忆新鲜度（最近更新时间）
echo "## 📅 Memory Freshness"
LATEST_UPDATE=$(find "$MEMORY_DIR" -type f -name "*.md" -exec stat -f "%m %N" {} \; 2>/dev/null | sort -rn | head -1 | awk '{print $1}')
if [ -n "$LATEST_UPDATE" ]; then
    DAYS_AGO=$(( ($(date +%s) - $LATEST_UPDATE) / 86400 ))
    if [ $DAYS_AGO -lt 7 ]; then
        echo "✅ Last updated: $DAYS_AGO days ago (Fresh)"
    elif [ $DAYS_AGO -lt 30 ]; then
        echo "⚠️  Last updated: $DAYS_AGO days ago (Aging)"
    else
        echo "❌ Last updated: $DAYS_AGO days ago (Stale)"
    fi
else
    echo "❌ No memory files found"
fi

# 2. 记忆密度（信息量/文件大小）
echo ""
echo "## 📊 Memory Density"
TOTAL_SIZE=$(find "$MEMORY_DIR" -type f -name "*.md" -exec stat -f "%z" {} \; 2>/dev/null | awk '{s+=$1} END {print s}')
FILE_COUNT=$(find "$MEMORY_DIR" -type f -name "*.md" | wc -l | tr -d ' ')
if [ $FILE_COUNT -gt 0 ]; then
    AVG_SIZE=$((TOTAL_SIZE / FILE_COUNT))
    echo "Total size: $(numfmt --to=iec $TOTAL_SIZE 2>/dev/null || echo "${TOTAL_SIZE} bytes")"
    echo "Files: $FILE_COUNT"
    echo "Average: $(numfmt --to=iec $AVG_SIZE 2>/dev/null || echo "${AVG_SIZE} bytes")/file"
else
    echo "❌ No memory files found"
fi

# 3. 记忆分类覆盖
echo ""
echo "## 📁 Memory Categories"
for category in identity knowledge tasks daily logs; do
    if [ -d "$MEMORY_DIR/$category" ]; then
        count=$(find "$MEMORY_DIR/$category" -type f -name "*.md" | wc -l | tr -d ' ')
        echo "✅ $category/: $count files"
    else
        echo "⚠️  $category/: not found"
    fi
done

# 4. 记忆冗余度（检查重复内容）
echo ""
echo "## 🔄 Memory Redundancy"
DUPLICATE_LINES=$(find "$MEMORY_DIR" -type f -name "*.md" -exec cat {} \; | sort | uniq -d | wc -l | tr -d ' ')
TOTAL_LINES=$(find "$MEMORY_DIR" -type f -name "*.md" -exec cat {} \; | wc -l | tr -d ' ')
if [ $TOTAL_LINES -gt 0 ]; then
    REDUNDANCY=$((DUPLICATE_LINES * 100 / TOTAL_LINES))
    if [ $REDUNDANCY -lt 10 ]; then
        echo "✅ Redundancy: ${REDUNDANCY}% (Low)"
    elif [ $REDUNDANCY -lt 30 ]; then
        echo "⚠️  Redundancy: ${REDUNDANCY}% (Medium)"
    else
        echo "❌ Redundancy: ${REDUNDANCY}% (High)"
    fi
else
    echo "❌ No content to analyze"
fi

# 5. 健康评分
echo ""
echo "## 🎯 Health Score"
SCORE=100

# 扣分规则
[ $DAYS_AGO -gt 30 ] && SCORE=$((SCORE - 20))
[ $DAYS_AGO -gt 7 ] && SCORE=$((SCORE - 10))
[ $REDUNDANCY -gt 30 ] && SCORE=$((SCORE - 20))
[ $REDUNDANCY -gt 10 ] && SCORE=$((SCORE - 10))
[ ! -d "$MEMORY_DIR/identity" ] && SCORE=$((SCORE - 10))
[ ! -d "$MEMORY_DIR/knowledge" ] && SCORE=$((SCORE - 10))

if [ $SCORE -ge 80 ]; then
    echo "✅ Score: $SCORE/100 (Excellent)"
elif [ $SCORE -ge 60 ]; then
    echo "⚠️  Score: $SCORE/100 (Good)"
else
    echo "❌ Score: $SCORE/100 (Needs Attention)"
fi

echo ""
echo "---"
echo "Recommendations:"
echo "  - Run memory cleanup monthly"
echo "  - Update memory files weekly"
echo "  - Review and consolidate redundant content"
echo "  - Maintain category structure"
