# OpenCode Configuration Template

This file provides context and instructions for AI assistants working in this repository.

---

## Table of Contents

- [General Instructions (Project-Independent)](#general-instructions-project-independent)
  - [OpenCode File Locations](#opencode-file-locations)
  - [Git Workflow](#git-workflow)
  - [Coding Standards](#coding-standards)
  - [Available Components](#available-components)
- [Project-Specific Context](#project-specific-context)
  - [Project Overview](#project-overview)
  - [Technology Stack](#technology-stack)
  - [Project Structure](#project-structure)
  - [Key Conventions](#key-conventions)

---

# General Instructions (Project-Independent)

## OpenCode File Locations

When creating OpenCode components, always use the correct directory:

| Component Type | Location | Purpose | Naming Convention |
|----------------|----------|---------|-------------------|
| **Plans** | `.opencode/plans/` | Implementation plans and design documents | `kebab-case.md` |
| **Notes** | `.opencode/notes/` | Session notes, research, and observations | `YYYY-MM-DD-topic.md` |
| **Commands** | `.opencode/commands/` | Slash commands (workflows, processes) | `kebab-case.md` |
| **Agents** | `.opencode/agents/` | Specialized domain expertise agents | `kebab-case.md` |
| **Skills** | `.opencode/skills/` | Bundled resources with scripts | `kebab-case/` |
| **Documentation** | `.opencode/docs/` | Guides and reference documentation | `kebab-case.md` |

**Important:**
- Never create plans, notes, or commands outside their designated directories
- Use kebab-case for all filenames (e.g., `my-new-command.md`)
- Commands are invoked as `/filename` (without `.md` extension)
- Agent names should not include model identifiers in the filename

---

## Git Workflow

### Git Flow Management

Git operations (branching, commits, PRs, releases) are managed by the `git-flow-manager` agent.

**Branch Types:**
- `main` - Production-ready code (protected)
- `develop` - Integration branch (if using Git Flow)
- `feature/*` - New features (e.g., `feature/user-authentication`)
- `bugfix/*` - Bug fixes (e.g., `bugfix/login-error`)
- `hotfix/*` - Emergency production fixes (e.g., `hotfix/security-patch`)
- `release/*` - Release preparation (e.g., `release/v1.2.0`)

**Commit Message Format:**
```
<type>: <subject>

<body>

<footer>
```

**Types:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, no logic change)
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks
- `perf:` - Performance improvements

**Reference:** See `.opencode/agents/git-flow-manager.md` for complete conventions.

---

## Coding Standards

### General Best Practices

1. **Code Quality**
   - Write clear, self-documenting code
   - Use meaningful variable and function names
   - Follow language-specific style guides
   - Handle errors and exceptions gracefully
   - Avoid code duplication (DRY principle)

2. **Documentation**
   - Document complex logic with comments
   - Maintain up-to-date README files
   - Write clear commit messages
   - Document API endpoints and interfaces

3. **Testing**
   - Write unit tests for new features
   - Maintain high test coverage (aim for 80%+)
   - Include integration tests for critical paths
   - Test edge cases and error conditions

4. **Version Control**
   - Commit frequently with clear messages
   - Keep commits atomic (one logical change per commit)
   - Review your own code before creating PR
   - Respond to review feedback promptly

---

## Available Components

### Slash Commands

Slash commands provide structured workflows and processes. Invoke with `/command-name`.

**Common Commands:**
- `/structured-thinking` - Reflection and problem-solving framework
- `/ultrathink` - Deep analysis and complex problem solving
- `/systematic-diagnosis` - Issue diagnosis and root cause analysis
- `/refactor-code` - Code refactoring assistance
- `/create-architecture-docs` - Generate architecture documentation

**Reference:** See `.opencode/AGENTS_INDEX.md` for complete command list.

### Specialized Agents

Agents provide domain-specific expertise. Reference the agent name when requesting specialized help.

**Agent Categories:**
- **Frontend**: React, Next.js, Svelte
- **Backend**: Go, Java/Kotlin, TypeScript
- **DevOps**: Kubernetes, Terraform, CI/CD
- **Quality**: Code review, architecture review, security
- **Meta**: Agent creation, command creation, prompt engineering

**Model Selection:**
- Agents use different AI models based on task complexity
- See `.opencode/docs/model-selection-guide.md` for rationale
- Haiku (fast), Sonnet (balanced), Opus (complex reasoning)

**Reference:** See `.opencode/AGENTS_INDEX.md` for complete agent catalog.

### Skills

Skills bundle resources, scripts, and guides for specific tasks.

**Available Skills:**
- `artifacts-builder` - Create complex React/Tailwind HTML artifacts
- `mcp-builder` - Build Model Context Protocol servers
- `skill-creator` - Create new OpenCode skills
- `theme-factory` - Apply professional themes to artifacts
- `docx`, `xlsx`, `pdf`, `pptx` - Document manipulation

**Usage:** Skills are loaded dynamically when needed for specific tasks.

**Reference:** See `.opencode/AGENTS_INDEX.md` for complete skill list.

---

# Project-Specific Context

## Project Overview

**Project Name:** OpenCode Components Template  
**Description:** Production-ready template repository for OpenCode projects with specialized agents, commands, and skills.

**Primary Purpose:**
This template provides a curated collection of OpenCode components for AI-assisted development across multiple technology stacks including Next.js, Go, Spring Boot, SvelteKit, and game development.

**Key Features:**
- 25+ specialized domain expert agents
- 5 slash commands for systematic workflows
- 8 bundled skills with helper scripts
- Comprehensive documentation and guides
- Model Context Protocol (MCP) server reference implementations (template only - not for active use)

---

## Technology Stack

### Core Technologies

**Languages:**
- TypeScript/JavaScript - Primary language for skills and MCP servers
- Markdown - Documentation and agent definitions
- YAML - Configuration and frontmatter

**OpenCode Components:**
- Agents: Markdown files with YAML frontmatter
- Skills: Markdown + bundled scripts/resources
- Commands: Markdown workflow definitions

### Development Tools

**Package Manager:** npm/pnpm  
**Version Control:** Git + GitHub  
**Issue Tracking:** Linear (OpenCode Components team)  
**AI Models:** Anthropic (Haiku 4.5, Sonnet 4.5, Opus 4.5), OpenAI (GPT-5.2)

---

## Project Structure

```
template-opencode/
├── .opencode/                   # OpenCode components directory
│   ├── agents/                  # 25 specialized agents
│   │   ├── frontend/            # (future: organized by category)
│   │   ├── backend/
│   │   └── *.md                 # Current: flat structure
│   ├── commands/                # 5 slash commands
│   │   ├── structured-thinking.md
│   │   ├── ultrathink.md
│   │   └── ...
│   ├── skills/                  # 8 bundled skills
│   │   ├── artifacts-builder/
│   │   ├── mcp-builder/
│   │   └── ...
│   ├── docs/                    # Documentation and guides
│   │   └── model-selection-guide.md
│   ├── plans/                   # Implementation plans
│   ├── notes/                   # Session notes
│   ├── mcp-servers/            # MCP server implementations
│   │   └── discord/
│   ├── settings/               # Environment configurations
│   ├── AGENTS_INDEX.md         # Complete component catalog
│   └── AGENTS.md               # This file (context for AI)
├── .github/                    # GitHub templates and workflows
├── README.md                   # Project documentation
└── package.json               # Node.js dependencies
```

**Key Files:**
- `.opencode/AGENTS_INDEX.md` - Complete catalog of all components
- `.opencode/docs/model-selection-guide.md` - Model tier selection guide
- `.opencode/agents/git-flow-manager.md` - Git workflow conventions

---

## Key Conventions

### Agent Naming

**Format:** `domain-technology.md` or `role-specialization.md`

**Examples:**
- `java-kotlin-backend.md` - Technology + scope
- `security-engineer.md` - Role + domain
- `git-flow-manager.md` - Tool + function

**Anti-patterns (avoid):**
- ❌ `java-kotlin-backend-opus45.md` - No model names in filename
- ❌ `JavaKotlinBackend.md` - Use kebab-case, not PascalCase
- ❌ `javabackend.md` - Include hyphen separators

### Agent Frontmatter Structure

```yaml
---
name: agent-name
description: Use this agent when [use case]. Specializes in [areas]. Examples - [example 1], [example 2]
type: subagent
model: anthropic/claude-opus-4-5
model_metadata:
  complexity: high
  reasoning_required: true
  code_generation: true
  cost_tier: premium
  description: "Brief explanation"
fallbacks:
  - openai/gpt-5.2
  - anthropic/claude-sonnet-4-5
tools:
  write: true
  edit: true
permission:
  bash:
    "*": ask
    "specific-command*": allow
---
```

**Required Fields:**
- `name` - Agent identifier (matches filename without `.md`)
- `description` - Clear use case with examples
- `type` - `primary` or `subagent`
- `model` - Primary AI model to use

**Recommended Fields:**
- `model_metadata` - Complexity, reasoning needs, cost tier
- `fallbacks` - Alternative models if primary unavailable
- `tools` - Which file operations are allowed
- `permission` - Granular bash command permissions

### Command Structure

```yaml
---
allowed-tools: Read, Write, Edit, Bash
argument-hint: [mode] | --option1 | --option2
description: Brief description of command purpose
---

Command content with workflow instructions...
```

### Skill Structure

```
skill-name/
├── SKILL.md              # Main skill file with YAML frontmatter
├── scripts/              # Executable scripts
│   ├── init.sh
│   └── validate.py
├── reference/            # Reference documentation
│   └── api-docs.md
├── assets/              # Static assets
│   └── template.json
└── LICENSE.txt          # License information
```

---

## Project-Specific Workflows

### Important Restrictions

**NEVER use Discord integrations in this project:**
- Do NOT post announcements, releases, or updates to Discord
- Do NOT use any Discord webhook tools or MCP servers
- Discord MCP server is present for reference/template purposes only
- This is a template repository - no active notification channels

### Adding a New Agent

1. **Research**: Study similar agents for structure and patterns
2. **Create**: Use `agent-creation` agent for scaffolding
3. **Test**: Validate agent works for intended use cases
4. **Document**: Add to `.opencode/AGENTS_INDEX.md`
5. **PR**: Submit pull request with clear description

**Reference:** See `.opencode/agents/agent-creation.md`

### Adding a New Skill

1. **Plan**: Define bundled resources and scripts needed
2. **Create**: Use `skill-creator` skill for scaffolding
3. **Bundle**: Include all necessary scripts and references
4. **Test**: Validate skill works end-to-end
5. **Document**: Add to `.opencode/AGENTS_INDEX.md`

**Reference:** See `.opencode/skills/skill-creator/`

### Model Selection for New Agents

Consult `.opencode/docs/model-selection-guide.md` to select appropriate model tier:

- **Haiku 4.5**: Deterministic workflows, simple transformations
- **Sonnet 4.5**: Code analysis, balanced complexity
- **Opus 4.5**: Complex architecture, deep reasoning

**Decision Framework:**
1. Assess task complexity (low/medium/high)
2. Determine reasoning requirements
3. Consider code generation scope
4. Evaluate domain expertise depth
5. Choose model tier accordingly

---

## Common Tasks

### Updating Component Documentation

When components change, update these files:
1. `.opencode/AGENTS_INDEX.md` - Main catalog
2. This file (`AGENTS.md`) - If conventions change
3. Individual component files - Keep descriptions current

### Managing Linear Issues

**Team:** OpenCode Components (OCC)  
**Issue Prefixes:** OCC-1, OCC-2, etc.

**Common Labels:**
- `model-selection` - Model tier changes
- `agent-enhancement` - Agent improvements
- `documentation` - Doc updates
- `p0`, `p1`, `p2` - Priority levels

### Creating Pull Requests

**Required in PR Description:**
- Summary of changes
- Impact analysis (discoverability, maintenance, etc.)
- Files changed breakdown
- Testing performed
- Linear issues closed

**PR Title Format:**
```
<type>: <concise description>
```

Examples:
- `feat: add database-specialist agent`
- `docs: update model selection guide`
- `refactor: consolidate duplicate agents`

---

## Resources

### Internal Documentation
- [Agent Index](.opencode/AGENTS_INDEX.md) - Complete component catalog
- [Model Selection Guide](.opencode/docs/model-selection-guide.md) - Model tier rationale
- [Git Flow Manager](.opencode/agents/git-flow-manager.md) - Git conventions

### External Resources
- [OpenCode Documentation](https://opencode.dev/docs) - Official docs
- [Linear Team](https://linear.app/moshpitcodes/team/OCC) - Issue tracking
- [GitHub Repository](https://github.com/MoshPitLabs/template-opencode) - Source code

---

## Customization Guide

### For Your Project

When using this template, customize the following sections:

1. **Project Overview** → Your project's name, description, purpose
2. **Technology Stack** → Your specific languages, frameworks, tools
3. **Project Structure** → Your actual directory structure
4. **Key Conventions** → Your project-specific naming and patterns
5. **Project-Specific Workflows** → Your team's processes
6. **Common Tasks** → Your team's frequent activities

### Keep From Template

Retain these general sections as-is:
- OpenCode File Locations
- Git Workflow (adjust branch strategy if needed)
- Coding Standards
- Available Components structure
- Agent/Skill/Command frontmatter formats

---

**Last Updated:** 2026-02-04  
**Template Version:** 1.0.0  
**Maintained By:** OpenCode Components Team
