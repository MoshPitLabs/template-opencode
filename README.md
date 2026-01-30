<!-- DO NOT TOUCH THIS SECTION#1: START -->
<h1 align="center">
   <img src="./.github/assets/logo/repo-template-icon.svg" width="100px" />
   <br>
      template-opencode | OpenCode Components Template
   <br>
      <img src="./.github/assets/pallet/pallet-0.png" width="800px" /> <br>

   <div align="center">
      <p></p>
      <div align="center">
         <a href="https://github.com/MoshPitLabs/template-opencode/stargazers">
            <img src="https://img.shields.io/github/stars/MoshPitLabs/template-opencode?color=FABD2F&labelColor=282828&style=for-the-badge&logo=starship&logoColor=FABD2F">
         </a>
         <a href="https://github.com/MoshPitLabs/template-opencode/">
            <img src="https://img.shields.io/github/repo-size/MoshPitLabs/template-opencode?color=B16286&labelColor=282828&style=for-the-badge&logo=github&logoColor=B16286">
         </a>
         <a href="https://opencode.ai">
            <img src="https://img.shields.io/badge/Open-Code-blue.svg?style=for-the-badge&labelColor=282828&logo=anthropic&logoColor=458588&color=458588">
         </a>
         <a href="https://github.com/MoshPitLabs/template-opencode/blob/main/LICENSE">
            <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&colorA=282828&colorB=98971A&logo=unlicense&logoColor=98971A&"/>
         </a>
      </div>
      <br>
   </div>
</h1>

<br/>
<!-- DO NOT TOUCH THIS SECTION#1: END -->

# 🗃️ Overview

**template-opencode** is a production-ready template repository for OpenCode projects, providing a curated collection of specialized agents, slash commands, skills, and MCP server integrations. This template serves as a foundation for building AI-assisted development environments with battle-tested components that enhance productivity across multiple technology stacks.

Whether you're building Next.js applications, Go backends, Spring Boot services, game mods, or working with DevOps infrastructure, this template includes the tools and configurations to accelerate your development workflow with OpenCode.

<br/>

## 📚 Project Structure

- [`.opencode/`](./.opencode/) - Core OpenCode components directory
  - [`agents/`](./.opencode/agents/) - 23 specialized domain expert agents
  - [`commands/`](./.opencode/commands/) - 6 slash commands for systematic workflows
  - [`skills/`](./.opencode/skills/) - 8 bundled resource skills with helper scripts
  - [`mcp-servers/`](./.opencode/mcp-servers/) - Model Context Protocol server integrations
  - [`settings/`](./.opencode/settings/) - Environment and performance configurations
  - [`plans/`](./.opencode/plans/) - Implementation plans and design documents
  - [`notes/`](./.opencode/notes/) - Session notes and observations
- [`.github/`](./.github/) - GitHub templates, rulesets, and assets
- [`AGENTS.md`](./AGENTS.md) - Quick reference guide for all components

<br/>

## 📓 Component Inventory

| Component | Count | Description |
| --------------------------- | :---: | :---------------------------------------------------------------------------------- |
| **Specialized Agents** | 23 | Domain experts for full-stack, backend, frontend, game development, and infrastructure |
| **Slash Commands** | 6 | Systematic workflows for reflection, diagnosis, implementation, and architecture |
| **Skills** | 8 | Document manipulation (DOCX/XLSX/PDF/PPTX), artifact building, theming, MCP creation |
| **MCP Integrations** | - | Discord webhooks and custom server templates |

<br/>

# 📐 Architecture

```mermaid
graph TB
    User[Developer] -->|Invokes| Commands[Slash Commands]
    User -->|Requests| Agents[Specialized Agents]
    
    Commands --> Reflection[/structured-reflection]
    Commands --> Diagnosis[/systematic-diagnosis]
    Commands --> Implementation[/systematic-implementation]
    Commands --> Architecture[/create-architecture-docs]
    Commands --> Refactor[/refactor-code]
    Commands --> UltraThink[/ultrathink]
    
    Agents --> Frontend[Frontend Stack]
    Agents --> Backend[Backend Stack]
    Agents --> DevOps[DevOps & Infra]
    Agents --> Quality[Code Quality]
    Agents --> Specialized[Specialized Domains]
    
    Frontend --> NextJS[nextjs-fullstack]
    Frontend --> React[react-typescript]
    Frontend --> Svelte[sveltekit-fullstack<br/>sveltekit-frontend]
    
    Backend --> Go[golang-backend-api<br/>golang-tui-bubbletea]
    Backend --> Java[java-kotlin-backend<br/>-gpt52/-opus45]
    
    DevOps --> Infra[devops-infrastructure]
    DevOps --> NixOS[nixos]
    DevOps --> GitFlow[git-flow-manager]
    
    Quality --> CodeReview[code-review]
    Quality --> ArchReview[architecture-review]
    Quality --> Security[security-engineer]
    Quality --> ErrorDetect[error-detective]
    
    Specialized --> MLOps[mlops-engineer]
    Specialized --> Prompt[prompt-engineering]
    Specialized --> MCP[mcp-server]
    Specialized --> Game[hytale-modding<br/>rpg-mmo-systems-designer]
    Specialized --> Markdown[markdown-formatter]
    Specialized --> AgentCreate[agent-creation<br/>command-creation]
    
    Skills[Skills System] --> Documents[Document Skills]
    Skills --> Builders[Builders & Tools]
    
    Documents --> DOCX[docx]
    Documents --> XLSX[xlsx]
    Documents --> PDF[pdf]
    Documents --> PPTX[pptx]
    
    Builders --> Artifacts[artifacts-builder]
    Builders --> Themes[theme-factory]
    Builders --> MCPBuilder[mcp-builder]
    Builders --> SkillCreate[skill-creator]
    
    MCP[MCP Servers] --> Discord[Discord Integration]
    MCP --> Custom[Custom Servers]
    
    Settings[Configuration] --> Environment[.opencode/settings.json]
    Settings --> EnvSettings[settings/environment/]
```

<br/>

# 🚀 **Getting Started**

> [!CAUTION]
> This template includes pre-configured agents and commands that interact with your codebase. While these components have been tested, they may behave differently depending on your specific project structure and requirements.
> **Always review the code and configurations before using them in production environments.**

> [!WARNING]
> You **must** examine the agent definitions, slash commands, and MCP server configurations to ensure they align with your project requirements and coding standards.

<br/>

## 1. **Clone the Template**

Use this repository as a template for your new OpenCode project:

```bash
# Create a new repository from this template on GitHub, then clone it
git clone https://github.com/YourOrg/your-project.git
cd your-project
```

> [!NOTE]
> This template is designed for use with:
> - OpenCode
> - Projects using Git for version control
> - Development environments with bash/zsh shells
> - Optional: Docker, Kubernetes, and cloud platform CLIs

<br/>

## 2. **Configure Your Environment**

Review and customize the configuration files:

```bash
# Review the main agents and components documentation
cat AGENTS.md

# Customize settings for your environment
cat .opencode/settings.json

# Review available agents
ls .opencode/agents/

# Review available commands
ls .opencode/commands/
```

<br/>

## 3. **Using the Components**

> [!TIP]
> To get the most value from this template, familiarize yourself with the available agents and commands by reviewing `AGENTS.md` before starting development.

### Available Slash Commands (6)

| Command | Purpose |
|---------|---------|
| `/structured-reflection` | Expert-guided reflection and learning techniques |
| `/structured-contemplation` | Deep problem-solving and contemplation workflows |
| `/create-architecture-docs` | Generate architecture documentation with Mermaid diagrams |
| `/systematic-diagnosis` | Root cause analysis and systematic issue diagnosis |
| `/systematic-implementation` | Validation-driven feature development workflow |
| `/ultrathink` | Deep analysis mode for complex problem-solving |
| `/refactor-code` | Systematic code refactoring with quality checks |

### Specialized Agents (23)

<details>
<summary><b>Full-Stack Development (3)</b></summary>

- `nextjs-fullstack` - Next.js 16+ App Router with React, TypeScript, PostgreSQL, Tailwind, Shadcn UI
- `sveltekit-fullstack` - Svelte 5 + SvelteKit with TypeScript, PostgreSQL, Tailwind CSS
- `sveltekit-frontend` - Svelte 5 + SvelteKit frontend-focused development

</details>

<details>
<summary><b>Backend Development (5)</b></summary>

- `golang-backend-api` - Go 1.25+ backend APIs and microservices
- `golang-tui-bubbletea` - Go TUI applications with Bubbletea v2
- `java-kotlin-backend-gpt52` - Java/Kotlin Spring backend (GPT-5.2 model)
- `java-kotlin-backend-opus45` - Java/Kotlin Spring backend (Opus 4.5 model)
- `react-typescript` - React + TypeScript frontend development

</details>

<details>
<summary><b>Game Development & Systems (2)</b></summary>

- `hytale-modding` - Hytale server mods with Java 25+, Kotlin 2.3.0, Gradle 9.3.0, Worldgen v2
- `rpg-mmo-systems-designer` - RPG/MMO game systems (progression, economy, crafting, combat)

</details>

<details>
<summary><b>DevOps & Infrastructure (3)</b></summary>

- `devops-infrastructure` - Kubernetes, Docker, Terraform, OpenTofu, Pulumi, CI/CD (Azure/GitHub Actions)
- `nixos` - NixOS, Nix Flakes, Home Manager for reproducible environments
- `git-flow-manager` - Git Flow workflows, branching, PR creation

</details>

<details>
<summary><b>Code Quality & Security (4)</b></summary>

- `architecture-review` - Review code for architectural consistency and best practices
- `code-review` - Code review for quality, security, and maintainability
- `security-engineer` - Security infrastructure and compliance specialist
- `error-detective` - Log analysis and error pattern detection

</details>

<details>
<summary><b>AI/ML & Specialized Tools (6)</b></summary>

- `mlops-engineer` - ML pipelines, experiment tracking, model registries
- `prompt-engineering` - LLM prompt optimization expert
- `mcp-server` - Model Context Protocol integration specialist
- `agent-creation` - Create specialized OpenCode agents
- `command-creation` - Create slash commands
- `markdown-formatter` - Markdown formatting and syntax expert

</details>

### Skills (8)

Skills bundle specialized knowledge with helper scripts and reference documentation:

<details>
<summary><b>Document Manipulation (4)</b></summary>

- **docx** - Create and edit Word documents with tracked changes, comments, formatting
- **xlsx** - Spreadsheet creation, formula calculations, data analysis
- **pdf** - PDF manipulation, form filling, text extraction
- **pptx** - Presentation creation and editing with layouts and themes

</details>

<details>
<summary><b>Development Tools (4)</b></summary>

- **artifacts-builder** - Build complex React/Tailwind HTML artifacts
- **mcp-builder** - Create MCP servers for external service integrations (Python/TypeScript)
- **theme-factory** - Apply professional themes to artifacts (10 presets available)
- **skill-creator** - Create custom skills for OpenCode

</details>

<br/>

# 📝 Customization

<details>
<summary>
<b>Adding Your Own Agents</b>
</summary>

Create new specialized agents in `.opencode/agents/`:

1. Use the `agent-creation` agent to scaffold new agents with proper structure
2. Follow the frontmatter pattern: `name`, `description`, `type`, `model`, `tools`, `permission`
3. Use kebab-case for filenames (e.g., `my-new-agent.md`)
4. Document the agent's purpose, persona, principles, and code examples
5. Update `AGENTS.md` with the new agent information
6. Agents are specialized subagents that OpenCode can delegate tasks to

**Example frontmatter:**
```yaml
---
name: my-agent
description: Use this agent when...
type: subagent
model: anthropic/claude-sonnet-4-5
tools:
  write: true
  edit: true
permission:
  bash:
    "*": ask
    "npm test*": allow
---
```

</details>

<details>
<summary>
<b>Creating Custom Slash Commands</b>
</summary>

Add new commands in `.opencode/commands/`:

1. Use the `command-creation` agent for guidance and scaffolding
2. Commands are markdown files with structured workflows
3. Use kebab-case for filenames (e.g., `my-command.md`)
4. Commands are invoked as `/my-command` (without `.md` extension)
5. Document the command's purpose, workflow steps, and expected outcomes
6. Update `AGENTS.md` to list the new command

</details>

<details>
<summary>
<b>Configuring MCP Servers</b>
</summary>

MCP servers enable OpenCode to interact with external services:

1. Review existing integrations in `.opencode/mcp-servers/`
2. Use the `mcp-builder` skill to create new servers (Python FastMCP or TypeScript SDK)
3. Configure server settings in `.opencode/settings.json`
4. Test integrations thoroughly before deploying to production
5. Document server capabilities and tool interfaces

**Example Discord MCP:**
- Send messages, announcements, teasers to Discord channels
- Manage webhooks with friendly names
- Rich embed formatting for release notes

</details>

<details>
<summary>
<b>Project-Specific Customization</b>
</summary>

Adapt the template to your project:

1. **Remove unused agents** - Delete agents for tech stacks you don't use
2. **Customize AGENTS.md** - Update the quick reference with your project's conventions
3. **Configure settings** - Adjust `.opencode/settings.json` for your environment
4. **Add project docs** - Create plans in `.opencode/plans/` for your features
5. **Update README** - Replace this README with project-specific information

</details>

<br/>

# 🖼️ Gallery

<p align="center">
   <i>Add screenshots of your OpenCode setup and workflows here</i><br>
   <!-- <img src="./.github/assets/screenshots/example.png" style="margin-bottom: 15px;"/> <br> -->
   <!-- Screenshots last updated <b>2025-01-30</b> -->
</p>

<br/>

# 👥 Credits

Resources and inspirations:

  - [OpenCode](https://opencode.ai): OpenCode platform and documentation
  - [Model Context Protocol](https://modelcontextprotocol.io): MCP specification and guides
  - [FastMCP](https://github.com/jlowin/fastmcp): Python framework for building MCP servers
  - [MCP TypeScript SDK](https://github.com/modelcontextprotocol/typescript-sdk): Official TypeScript SDK for MCP
  - [Anthropic](https://anthropic.com): Model provider (LLM)

<br/>

<!-- DO NOT TOUCH THIS SECTION#2: START -->
<!-- # ✨ Stars History -->

<br/>

<p align="center"><img src="https://api.star-history.com/svg?repos=MoshPitLabs/template-opencode&type=Timeline&theme=dark" /></p>

<br/>

<p align="center"><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" /></p>

<!-- end of page, send back to the top -->

<div align="right">
  <a href="#readme">Back to the Top</a>
</div>
<!-- DO NOT TOUCH THIS SECTION#2: END -->

<!-- Links -->
[OpenCode]: https://opencode.ai
[Model Context Protocol]: https://modelcontextprotocol.io
[FastMCP]: https://github.com/jlowin/fastmcp
[MCP TypeScript SDK]: https://github.com/modelcontextprotocol/typescript-sdk
[Anthropic]: https://anthropic.com
