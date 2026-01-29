<!-- DO NOT TOUCH THIS SECTION#1: START -->
<h1 align="center">
   <img src="./.github/assets/logo/repo-template-icon.svg" width="100px" />
   <br>
      template-opencode | Claude Code Components Template
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
         <a href="https://docs.opencode.ai">
            <img src="https://img.shields.io/badge/Claude-Code-blue.svg?style=for-the-badge&labelColor=282828&logo=anthropic&logoColor=458588&color=458588">
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

**template-opencode** is a comprehensive template repository for Claude Code projects, providing a battle-tested collection of specialized agents, slash commands, skills, and MCP server integrations. This template serves as a foundation for building AI-assisted development environments with pre-configured components that enhance productivity across multiple technology stacks.

Whether you're building Next.js applications, Go backends, Spring Boot services, or working with DevOps infrastructure, this template includes the tools and configurations to accelerate your development workflow with Claude Code.

<br/>

## 📚 Project Structure

- [`.opencode/`](./.opencode/) - Core Claude Code components directory
  - [`agents/`](./.opencode/agents/) - Specialized domain expert agents (25+ agents)
  - [`commands/`](./.opencode/commands/) - Slash commands for systematic workflows
  - [`skills/`](./.opencode/skills/) - Bundled resources with helper scripts
  - [`mcp-servers/`](./.opencode/mcp-servers/) - Model Context Protocol server integrations
  - [`settings/`](./.opencode/settings/) - Environment and performance configurations
- [`.github/`](./.github/) - GitHub templates, rulesets, and assets
- [`docs/`](./docs/) - Documentation templates and guides
- [`AGENTS.md`](./AGENTS.md) - Quick reference for available agents, commands, and skills

<br/>

## 📓 Project Components

| Component | Responsibility |
| --------------------------- | :---------------------------------------------------------------------------------- |
| **Specialized Agents** | Domain experts for full-stack development (Next.js, Go, Java/Kotlin, React, Svelte, etc.) |
| **DevOps & Infrastructure** | Agents for Kubernetes, Terraform, CI/CD pipelines, and cloud platforms |
| **Code Quality Agents** | Architecture review, code review, error detection, and security analysis |
| **Slash Commands** | Systematic workflows for reflection, diagnosis, implementation, and refactoring |
| **Document Skills** | Create and manipulate DOCX, XLSX, PPTX, and PDF files programmatically |
| **MCP Integrations** | Discord webhooks, artifact builders, theme factory, and custom MCP servers |
| **Git Flow Manager** | Automated Git Flow workflows with branch management and PR creation |

<br/>

# 📐 Architecture

```mermaid
graph TB
    User[Developer] -->|Invokes| Commands[Slash Commands]
    User -->|Requests| Agents[Specialized Agents]
    
    Commands --> Reflection[/structured-reflection]
    Commands --> Diagnosis[/systematic-diagnosis]
    Commands --> Implementation[/systematic-implementation]
    Commands --> Architecture[/create-architecture]
    Commands --> Refactor[/refactor-code]
    Commands --> UltraThink[/ultrathink]
    
    Agents --> Frontend[Frontend Agents]
    Agents --> Backend[Backend Agents]
    Agents --> DevOps[DevOps Agents]
    Agents --> Quality[Quality Agents]
    Agents --> Specialized[Specialized Agents]
    
    Frontend --> NextJS[nextjs-fullstack]
    Frontend --> React[react-typescript]
    Frontend --> Svelte[sveltekit-fullstack]
    
    Backend --> Go[golang-backend-api]
    Backend --> Java[java-kotlin-backend]
    Backend --> API[API Services]
    
    DevOps --> K8s[devops-infrastructure]
    DevOps --> NixOS[nixos]
    DevOps --> GitFlow[git-flow-manager]
    
    Quality --> CodeReview[code-review]
    Quality --> ArchReview[architecture-review]
    Quality --> Security[security-engineer]
    Quality --> ErrorDetect[error-detective]
    
    Specialized --> MLOps[mlops-engineer]
    Specialized --> Prompt[prompt-engineering]
    Specialized --> MCP[mcp-server]
    Specialized --> AgentCreate[agent-creation]
    
    Skills[Skills System] --> Documents[Document Skills]
    Skills --> Artifacts[artifacts-builder]
    Skills --> Themes[theme-factory]
    Skills --> MCPBuilder[mcp-builder]
    
    Documents --> DOCX[DOCX Creation]
    Documents --> XLSX[XLSX Analysis]
    Documents --> PDF[PDF Manipulation]
    Documents --> PPTX[PPTX Generation]
    
    MCP[MCP Servers] --> Discord[Discord Integration]
    MCP --> Custom[Custom Servers]
    
    Settings[Configuration] --> Environment[Environment Settings]
    Settings --> Performance[Performance Optimization]
    Settings --> Privacy[Privacy Controls]
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

Use this repository as a template for your new Claude Code project:

```bash
# Create a new repository from this template on GitHub, then clone it
git clone https://github.com/YourOrg/your-project.git
cd your-project
```

> [!NOTE]
> This template is designed for use with:
> - Claude Code CLI (latest version)
> - Projects using Git for version control
> - Development environments with bash/zsh shells
> - Optional: Docker, Kubernetes, and cloud platform CLIs

<br/>

## 2. **Configure Your Environment**

Review and customize the configuration files:

```bash
# Review the main agents documentation
cat AGENTS.md

# Customize settings for your environment
# Edit .opencode/settings.json for global settings
# Edit .opencode/settings/environment/ for specific configurations
```

<br/>

## 3. **Using the Components**

> [!TIP]
> To get the most value from this template, familiarize yourself with the available agents and commands before starting development.

### Available Slash Commands

- `/structured-reflection` - Expert-guided reflection techniques
- `/structured-contemplation` - Problem-solving and contemplation workflows  
- `/create-architecture` - Generate architecture documentation with diagrams
- `/systematic-diagnosis` - Root cause analysis and issue diagnosis
- `/systematic-implementation` - Validation-driven feature development
- `/ultrathink` - Deep analysis and problem-solving mode
- `/refactor-code` - Systematic code refactoring assistance

### Working with Specialized Agents

The template includes 25+ specialized agents. Key examples:

- **Full-Stack Development**: `nextjs-fullstack`, `sveltekit-fullstack`
- **Backend Services**: `golang-backend-api`, `java-kotlin-backend`
- **Frontend**: `react-typescript`, `sveltekit-frontend`
- **DevOps**: `devops-infrastructure`, `nixos`, `git-flow-manager`
- **Code Quality**: `architecture-review`, `code-review`, `error-detective`, `security-engineer`
- **Specialized**: `mlops-engineer`, `prompt-engineering`, `mcp-server`

### Using Skills

Skills bundle specialized knowledge with helper scripts:

```bash
# Document manipulation skills
- docx: Create and edit Word documents with tracked changes
- xlsx: Spreadsheet creation and formula calculations  
- pdf: PDF manipulation and form filling
- pptx: Presentation creation and editing

# Development skills
- artifacts-builder: Build complex React/Tailwind artifacts
- mcp-builder: Create MCP servers for external integrations
- theme-factory: Apply professional themes (10 presets available)
- skill-creator: Create your own custom skills
```

<br/>

# 📝 Customization

<details>
<summary>
Adding Your Own Agents
</summary>

Create new specialized agents in `.opencode/agents/`:

1. Use the `agent-creation` agent to scaffold new agents
2. Follow the existing agent structure and naming conventions
3. Document the agent's purpose, use cases, and examples
4. Update `AGENTS.md` with the new agent information

</details>

<details>
<summary>
Creating Custom Slash Commands
</summary>

Add new commands in `.opencode/commands/`:

1. Use the `command-creation` agent for guidance
2. Commands are markdown files with structured workflows
3. Use kebab-case for filenames (e.g., `my-command.md`)
4. Commands are invoked as `/my-command` (without extension)

</details>

<details>
<summary>
Configuring MCP Servers
</summary>

MCP servers enable Claude Code to interact with external services:

1. Review existing integrations in `.opencode/mcp-servers/`
2. Use the `mcp-builder` skill to create new servers
3. Configure server settings in `.opencode/settings.json`
4. Test integrations before deploying to production

</details>

<br/>

# 🖼️ Gallery

<p align="center">
   <i>Add screenshots of your Claude Code setup and workflows here</i><br>
   <!-- <img src="./.github/assets/screenshots/example.png" style="margin-bottom: 15px;"/> <br> -->
   <!-- Screenshots last updated <b>2025-01-29</b> -->
</p>

<br/>

# 👥 Credits

Resources and inspirations:

  - [Claude Code Documentation](https://docs.opencode.ai): Official Claude Code documentation
  - [Model Context Protocol](https://modelcontextprotocol.io): MCP specification and guides
  - [FastMCP](https://github.com/jlowin/fastmcp): Python framework for building MCP servers
  - [MCP TypeScript SDK](https://github.com/modelcontextprotocol/typescript-sdk): Official TypeScript SDK for MCP
  - [Anthropic](https://anthropic.com): Claude AI and tooling

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
[Claude Code Documentation]: https://docs.opencode.ai
[Model Context Protocol]: https://modelcontextprotocol.io
[FastMCP]: https://github.com/jlowin/fastmcp
[MCP TypeScript SDK]: https://github.com/modelcontextprotocol/typescript-sdk
[Anthropic]: https://anthropic.com
