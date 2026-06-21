<!-- BADGE BAR -->
[![License](https://img.shields.io/badge/license-MIT-blue)](./LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Skill-orange)](https://claude.ai)

# weaver-evolve

> **编织者·自我迭代。** 跨项目记忆分层归位、全局配置审查、经验模式识别、自我进化。当 Skill 多了之后，需要"整理 Skill 的 Skill"。

[English](#english)

---

## 为什么需要 weaver-evolve？

- **Skill 多了之后会互相打架。** 配置冲突、触发词重叠、记忆分散——没人做全局视角的整理。
- **该沉淀的经验没沉淀。** 今天的踩坑教训如果只停在这段对话里，明天在另一个项目还会踩。
- **知识需要分层。** 不是所有信息都该进 CLAUDE.md，不是所有习惯都该变规则。weaver 把信息路由到正确的层级。

## 核心能力

- 🗂️ **分层归位** — 把信息路由到 Obsidian wiki / memory / CLAUDE.md / rules / agents，每层有明确的受众和职责
- 🔍 **全局配置审查** — 扫描 settings.json 权限白名单，移除过期、合并重复
- 🧠 **经验模式识别** — 从历史对话中识别可复用的模式
- 📊 **自我进化** — 建议新规则、新 Skill、新 Agent
- 🔗 **调用子 Skill** — 自动调度 file-tidy（文件归位）和 memory-keeper（记忆整理）

## 工作流

```
全局扫描
  ├─ 权限白名单审查 → 移除过期 / 合并重复
  ├─ 配置一致性检查 → 全局 vs 项目 settings.json 冲突
  ├─ 记忆分层归位 → memory ↔ Obsidian wiki 双向同步
  ├─ 历史对话提炼 → 识别重复模式 → 建议沉淀
  └─ 子 Skill 调度 → file-tidy + memory-keeper
```

## 快速开始

### 触发

| 你说 | 它做什么 |
|------|---------|
| `编织一下` / `全局整理` | 启动全局知识整理 |
| `整理知识网络` / `同步记忆` | 同上 |
| `/weaver` / `/global-tidy` | 同上 |

## 设计哲学

**定期使用，不是每次对话。** 全局整理的价值在于"拉开距离看"——如果每次都跑，看到的只是局部波动。隔一段时间跑一次，才能看到模式和趋势。

**路由比存储更重要。** 一条信息的价值不在于"记下来了"，而在于"下次用到的时候能被找到"。weaver 的核心工作不是写更多东西，是把已经写的东西放到对的地方。

**自我迭代是终局。** 体系的终极目标是能自我改进——识别自己的漏洞、建议新的规则、甚至建议创建新的 Skill。weaver 是让 Agent 协作体系从"被管理"走向"自管理"的那一步。

## 相关项目

本项目属于 [weaver-evolve 技能集群](https://github.com/2021291696/weaver-evolve)。以下 Skill 同在一个集群中：

| 项目 | 关系 |
|------|------|
| [file-tidy](../file-tidy/) | 子 Skill — 文件归位 |
| [memory-keeper](../memory-keeper/) | 子 Skill — 记忆整理 |
| [debug-architect](../debug-architect/) | 子 Skill — 错误复盘 |
| [skill-optimizer](../skill-optimizer/) | 兄弟 — Skill 级优化 |

独立仓库链接（如单独使用）：[file-tidy](https://github.com/2021291696/file-tidy) · [memory-keeper](https://github.com/2021291696/memory-keeper) · [debug-architect](https://github.com/2021291696/debug-architect) · [skill-optimizer](https://github.com/2021291696/skill-optimizer)

## License

MIT

---

## English

# weaver-evolve

> **The Weaver · Self-Evolution.** Cross-project knowledge routing, global config audit, pattern recognition, and self-improvement. The skill that tidies all skills.

### Why?

When skills multiply, they conflict. Configs clash, triggers overlap, memories scatter. weaver provides the global perspective — routing information to the right layer and identifying patterns worth preserving.

### Design Philosophy

**Periodic, not per-conversation.** Global tidying needs distance. Run it too often and you see noise; run it periodically and you see patterns.

**Routing over storage.** Value isn't in "saving it" — it's in "finding it when needed." weaver's core job is putting existing knowledge in the right place, not writing more.

**Self-evolution is the endgame.** A system that identifies its own gaps, suggests new rules, and even proposes new skills — that's the step from "managed" to "self-managing."
