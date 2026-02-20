# GitHub MCP Server
[Official Repository](https://github.com/modelcontextprotocol/servers-archived/tree/main/src/github)

Provides tools to interact with the GitHub platform, including issue management, pull requests, and repository searches.

## Installation

### Claude Desktop
Add to yours `claude_desktop_config.json`:
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
      }
    }
  }
}
```

## Capabilities
- Create/Update/Search Issues.
- Manage Pull Requests.
- Browse Code and Commits.
