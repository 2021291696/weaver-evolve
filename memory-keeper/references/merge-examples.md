# 融入实操示例

## 正例

### 更新用户画像（原处修改）

旧 `user-profile.md`:
```markdown
## 本地开发环境
- JDK 21 (Eclipse Adoptium)
- Maven 3.9
```

新信息：*"记住：JDK 升级到 24 了"*

✅ 正确：
```markdown
## 本地开发环境
- JDK 24 (Eclipse Adoptium)
- Maven 3.9
```

❌ 错误：
```markdown
## 本地开发环境
- JDK 21 (Eclipse Adoptium)
- Maven 3.9

## 更新（2026-05-17）
- JDK 已升级到 24
```

### 互补信息建立链接

已有 `reference-dev-credentials.md` 记录 MySQL 凭据。

新信息：*"记住：MySQL 连接池用 HikariCP，最大 20 连接"*

✅ 正确：创建新文件 `mysql-connection-pool.md`，文中引用 `[[reference-dev-credentials.md]]`
❌ 错误：把连接池配置塞进 `reference-dev-credentials.md`（混淆了凭据和配置两个不同概念）

### 删除后整理

`MEMORY.md`:
```markdown
- [MySQL 端口](mysql-port.md) — 开发环境端口
- [JDK 配置](jdk-setup.md) — JDK 路径
- [HikariCP 配置](hikari-config.md) — 连接池
```

用户说：*"忘掉：MySQL 端口那个记忆"*

✅ 正确：
1. 删除 `mysql-port.md`
2. 更新 `MEMORY.md` 移除对应行
3. 检查：还剩 2 条，不孤立，不需合并

如果 `hikari-config.md` 也被删了，只剩 `jdk-setup.md`：
→ 建议用户："只剩一条 JDK 配置了，要不要合并到 user-profile.md？"

## 反例

### 盲目追加

三次"记住"后，`user-profile.md` 末尾积压：
```markdown
- JDK 21
...
- 对了 JDK 升到 22 了
- 现在用 JDK 23
- 最终：JDK 24
```
→ 读者看到四个版本号，不知道该信哪个。

### 不搜就写

用户说"记住：项目用 MySQL"，agent 直接新建 `mysql-info.md`。
但实际上 `dev-env.md` 里已经写了 MySQL 版本和端口。
→ 同一个信息的两个碎片，后续 agent 可能看到一半。

### 删了内容忘了索引

删了 `mysql-port.md` 但 MEMORY.md 里还留着链接。
→ 下次 agent 点过去 404。
