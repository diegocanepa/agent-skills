# Context7 MCP Server
[Official Repository](https://github.com/upstash/context7#installation)

Used by `backend-coder` to fetch updated documentation, best practices, and idiomatic patterns for various programming languages and frameworks.

## Installation

### Claude Desktop
```json
{
  "mcpServers": {
    "context7": {
      "serverUrl": "https://mcp.context7.com/mcp",
      "headers": {
        "CONTEXT7_API_KEY": "YOUR_API_KEY"
      }
    }
  }
}
```

## Usage in Skills
This server is the primary source of truth for:
- Language-specific best practices (Python, Go, JS, etc.)
- Framework documentation.
- Modern coding standards.
