# `.tidy-rules.yaml` 参考

该文件只补充项目语义；用户指令和适用的 `AGENTS.md` 始终优先。所有字段可选。

```yaml
directories:
  "outputs/movie/": ["电影", "视频", "movie"]
  "scripts/": ["脚本", "automation"]

safe_zones:
  - ".git/**"
  - ".codex/**"
  - ".agents/**"
  - "node_modules/**"
  - "*.key"

keep_at_root:
  - "AGENTS.md"
  - "package.json"
  - "pyproject.toml"

junk:
  - pattern: "*.tmp"
    reason: "临时文件"
  - pattern: "*.bak"
    reason: "编辑器备份"
```

## 字段

### `directories`

键是相对目标根的**已有目录**，值是帮助理解目录用途的关键词。不存在的目录不得因此被创建。

### `safe_zones`

匹配的路径不扫描内容、不移动、不删除。实现可使用 glob 库；不要用简单字符串替换拼出不安全的正则。无配置时至少保护：

- `.git/**`
- `.codex/**`
- `.agents/**`
- 常见依赖与构建目录
- 密钥、证书、凭据、数据库和大型二进制

### `keep_at_root`

无论评分多高都留在根目录。项目入口、manifest、锁文件、许可证和 `AGENTS.md` 通常应在这里。

### `junk`

只生成“建议删除”。`pattern` 使用 glob，不把多个模式塞进一个正则字符串；多模式写成多条规则。删除仍需用户明确确认。

## 校验

- YAML 必须可解析；未知字段只警告，不自行猜测。
- 所有目录路径必须在目标根内，拒绝 `..` 越界和绝对路径。
- 重复或冲突规则按更安全者处理：`safe_zones` / `keep_at_root` 优先于移动与垃圾规则。
