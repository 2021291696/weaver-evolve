# .tidy-rules.yaml 规则格式参考（v2）

## 核心理念

v2 中，规则文件从"整理引擎"降级为"辅助配置"。AI 通过结构感知判断文件归属，规则文件只在以下场景补漏：
1. 告诉 AI 你的目录命名习惯（别名）
2. 告诉 AI 哪些绝对不能碰（安全区）
3. 告诉 AI 哪些必须留在原位（keep_at_root）
4. 定义垃圾文件清理规则（junk）

无 `.tidy-rules.yaml` 时，AI 纯靠结构感知工作。

## 完整结构

```yaml
# 所有字段均为可选

# 一、目录别名 — 帮 AI 理解你的命名习惯
directories:
  "子目录路径/": ["中文别名1", "英文别名2", "关键词3"]

# 二、安全区 — 绝对不碰的目录或文件模式（支持通配符 *）
safe_zones:
  - ".git"
  - "node_modules"
  - "*.exe"

# 三、必须留在根目录的文件
keep_at_root:
  - "package.json"
  - "main.py"

# 四、临时/垃圾文件清理（pattern 匹配）
junk:
  - pattern: "*.tmp|*.bak"
    reason: "编辑器备份"
  - pattern: "*.pyc|__pycache__"
    reason: "编译缓存"
```

## 字段说明

### directories — 目录别名

帮助 AI 理解目录名的语义含义。当文件内容包含别名关键词时，增加该目录的匹配权重。

```yaml
directories:
  "outputs/movie/": ["电影", "影视", "视频素材", "movie"]
  "financial-services/": ["金融", "理财", "利息"]
```

- 键：目录路径（相对于项目根目录）
- 值：关键词列表，中英文均可
- 用途：AI 在评分维度一（文件名→目录名匹配）中，通过别名关键词增加匹配分数

### safe_zones — 安全区

这些目录/文件模式中的内容绝对不碰。AI 会将 glob 模式转为正则表达式来匹配路径。

```yaml
safe_zones:
  - ".git"
  - "node_modules"
  - ".claude"
  - ".venv"
  - "*.exe"
  - "*.dll"
  - "apache-*"
```

- 支持通配符 `*`（匹配任意字符）和 `?`（匹配单个字符）
- 同时匹配目录名和文件名
- `.` 开头匹配隐藏目录和文件

### keep_at_root — 保留在原位

这些文件必须留在项目根目录，不参与归位判断。

```yaml
keep_at_root:
  - "package.json"
  - "pyproject.toml"
  - "CLAUDE.md"
  - ".gitignore"
  - ".env"
```

- 支持精确文件名匹配
- 不参与评分，直接列入"未归类"并标注 keep_at_root

### junk — 垃圾清理

pattern 匹配文件名，匹配到的标记为"建议删除"（永远不自动执行）。

```yaml
junk:
  - pattern: "*.tmp|*.bak|*~|*.swp"
    reason: "编辑器备份或临时文件"
  - pattern: "*.pyc|__pycache__|*.class"
    reason: "编译产物，可从源码重新生成"
  - pattern: "Thumbs.db|.DS_Store"
    reason: "系统生成的文件缩略图缓存"
```

- `pattern`：文件名匹配模式（PowerShell 通配符，`*` `?`，管道符 `|` 分隔）
- `reason`：展示给用户看的删除原因
- 删除绝对不自动执行，必须用户确认

## v1 → v2 迁移

| v1 概念 | v2 对应 |
|---------|--------|
| `targets[].pattern: "*.py"` → `target: "scripts/"` | **删除** — 不再按扩展名归类 |
| `targets[].action: delete` | → `junk` |
| `targets[].action: ignore` | → `safe_zones` |
| `targets[].priority` | **删除** — 不再用规则匹配 |
| `options.max_depth` | 由 AI 根据项目规模自行判断 |
| `options.exclude` | → `safe_zones` |
