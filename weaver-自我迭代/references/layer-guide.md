# 分层决策详细指南

> 本文件为 weaver 技能集群共享版本。weaver-自我迭代 和 memory-keeper 共用。

## 核心原则

**不确定时，保守下沉一级。** 放错层比漏放更糟——全局污染影响所有项目，而项目遗漏只影响一个项目。

## 全局层的判定

以下信号表明信息属于全局（`~/.claude/CLAUDE.md` 或全局 MEMORY）：

- 用户说"以后都这样"、"我习惯"、"默认"
- 涉及多个项目都用的工具（如"Maven 用阿里云镜像"）
- 跨项目的开发风格偏好（如"commit message 用中文"）
- 环境配置（如"Node.js 已安装"、"Python 路径是..."）
- 涉及 `~/.claude/settings.json` 的配置

**全局 CLAUDE.md vs 全局 MEMORY：**
- CLAUDE.md：硬规则、命令速查、环境变量、禁止事项（下次 AI 必须看到）
- MEMORY：偏好、习惯、跨项目 reference（下次 AI 应该知道但不看也不会犯错）

## 项目层的判定

以下信号表明信息属于某个项目：

- 用户提到具体项目路径（如 `D:\MyAIWorkspace\school\lab3`）
- 用户说"这个项目里"、"当前项目"
- 技术选型只影响一个项目（如"lab3 用 MyBatis"）
- 项目的特定踩坑（如"lab3 的 MySQL 端口不是默认的"）

项目层写入位置：
- 项目 `CLAUDE.md`：项目级硬规则、路由清单、环境变量
- 项目 `memory/MEMORY.md`：项目上下文、偏好、决策记录

## 子项目层的判定

当用户在对话中明确提到子项目目录名时（如 `project1/复盘agent`、`school/lab3`），信息归子项目。

如果子项目有自己的 CLAUDE.md 或 memory 目录，写入那里。如果没有，写入主项目的 memory 并标注子项目名。

## 常见边界案例

| 场景 | 判定 | 理由 |
|------|------|------|
| 用户说"以后 Maven 都用阿里云镜像" | 全局 | "以后都"是全局信号 |
| 用户在 lab3 里说"Spring Boot 版本用 3.2" | 项目 lab3 | 只影响一个项目 |
| 用户说"所有 SSM 项目都用 PageHelper 分页" | 全局 | "所有"是全局信号，即使当前只在 lab3 里说 |
| 用户说"这个 IDE 的快捷键记住" | 全局 | IDE 偏好跨项目 |
| 不确定 | 项目级 | 保守下沉 |

## Obsidian 层（个人知识库）

当信息是通用知识而非操作偏好时，写入 Obsidian 个人知识库：

| 信号 | 去向 |
|------|------|
| 概念、规律、方法论 | `D:\MyAIWorkspace\个人知识库\wiki\概念\<概念名>.md` |
| 外部资料消化、踩坑经历 | `D:\MyAIWorkspace\个人知识库\wiki\来源\<来源名>.md` |
| 用户哲学、性格、命理等自我认知 | `wiki/概念/` 或 `wiki/来源/` |

**写入规范：** 遵循 `个人知识库/CLAUDE.md` 的笔记格式。新建后更新 `wiki/index.md` + `wiki/log.md`。
**合并优先：** 读 `wiki/index.md` 检查已有笔记，有则更新不新建。
**详细规则：** 见 `~/.claude/rules/memory-routing.md`。
