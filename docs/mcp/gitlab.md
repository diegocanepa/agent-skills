# GitLab MCP Server
[Official Repository](https://github.com/modelcontextprotocol/servers-archived/tree/main/src/gitlab)

Provides tools to interact with GitLab instances.

## Installation

### Claude Desktop
Add to yours `claude_desktop_config.json`:
```json
{
  "mcpServers": {
    "gitlab": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-gitlab"
      ],
      "env": {
        "GITLAB_PERSONAL_ACCESS_TOKEN": "your_token_here",
        "GITLAB_API_URL": "https://gitlab.com/api/v4"
      }
    }
  }
}
```

## Capabilities
- Manage Project Issues.
- Create/Update Merge Requests.
- Search Projects and Repository content.
