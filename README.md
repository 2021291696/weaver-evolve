<!-- BADGE BAR -->
[![License](https://img.shields.io/badge/license-MIT-blue)](./LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Skill%20Cluster-orange)](https://claude.ai)

# weaver-evolve — 技能集群

> **编织者·自我迭代** + 四个子/兄弟 Skill，一键安装。跨项目知识管理的全部环节：整理、归位、记忆、复盘、优化。

[English](#english)

---

## 包含的 Skill

| 目录 | 类型 | 用途 |
|------|------|------|
| [`weaver-自我迭代/`](./weaver-自我迭代/) | 主 Skill | 全局知识整理：分层归位、配置审查、经验识别、自我进化 |
| [`file-tidy/`](./file-tidy/) | 子 Skill | 文件系统整理：结构感知归位 |
| [`memory-keeper/`](./memory-keeper/) | 子 Skill | 即时记忆管理："记住"/"忘掉"指令 |
| [`debug-architect/`](./debug-architect/) | 子 Skill | 错误复盘：扫描报错 → 根因分析 → 预防规则 |
| [`skill-optimizer/`](./skill-optimizer/) | 兄弟 Skill | Skill 级优化：分析对话识别改进空间 |

## 快速安装

```bash
git clone https://github.com/2021291696/weaver-evolve.git
cd weaver-evolve

# macOS / Linux
bash install.sh

# Windows
powershell -File install.ps1
```

| 选项 | 说明 |
|------|------|
| `--force` / `-Force` | 覆盖已安装的同名 skill |
| `--dry-run` / `-DryRun` | 只显示会安装什么 |

## 为什么是集群

这五个 Skill 彼此协作：

```
weaver-自我迭代（全局扫描）
  ├─ 调用 file-tidy（文件归位）
  ├─ 调用 debug-architect（错误复盘）
  └─ 互补 memory-keeper（记忆管理）
        └─ 参考 skill-optimizer（自我改进）
```

一个 `git clone` 得到全部。

## 设计哲学

**定期使用，不是每次对话。** 拉开距离看，才能看到模式和趋势，不是噪音。

**路由比存储更重要。** 价值在于"下次用到时能被找到"，不是"记下来了"。

**自我迭代是终局。** 体系能识别自己的漏洞、建议新规则、甚至建议创建新 Skill。

## License

MIT

---

## English

# weaver-evolve — Skill Cluster

> **The Weaver · Self-Evolution** bundled with 4 companion skills. One clone, full knowledge management.

### Included

| Directory | Role | Purpose |
|-----------|------|---------|
| `weaver-自我迭代/` | Core | Cross-project knowledge routing, config audit, pattern recognition |
| `file-tidy/` | Sub | Structure-aware file organization |
| `memory-keeper/` | Sub | Real-time "remember"/"forget" commands |
| `debug-architect/` | Sub | Post-project error analysis & prevention |
| `skill-optimizer/` | Sibling | Skill-level improvement suggestions |

### Quick Install

```bash
git clone https://github.com/2021291696/weaver-evolve.git
cd weaver-evolve && bash install.sh   # or: powershell -File install.ps1
```
