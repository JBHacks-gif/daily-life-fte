#!/bin/bash

# MCP Server Configuration Setup Script
# For Daily Life Productivity Digital FTE Project

echo "🚀 Setting up MCP Server Configurations..."
echo "=========================================="

# Check if .claude directory exists
if [ ! -d ".claude" ]; then
    echo "❌ .claude directory not found. Please create the project structure first."
    exit 1
fi

# Check if config directory exists
CONFIG_DIR=".claude/config.json"
if [ ! -f "$CONFIG_DIR" ]; then
    echo "⚠️  Creating configuration directory..."
    mkdir -p ".claude/secrets"
    touch "$CONFIG_DIR"
    echo "{
  "google": {
    "client_id": "",
    "client_secret": "",
    "redirect_uri": "http://localhost:3000/oauth2callback"
  },
  "notion": {
    "api_key": "",
    "workspace_id": ""
  },
  "slack": {
    "bot_token": "",
    "verification_token": "",
    "signing_secret": ""
  },
  "brave_search": {
    "api_key": ""
  },
  "weather": {
    "api_key": ""
  },
  "news_api": {
    "api_key": ""
  }
}" > "$CONFIG_DIR"
    echo "✅ Configuration template created at $CONFIG_DIR"
else
    echo "✅ Configuration file already exists"
fi

echo ""
echo "📋 Configuration Summary:"
echo "========================"
echo "1. Google OAuth Setup:"
echo "   - Enable Gmail API in Google Cloud Console"
echo "   - Enable Google Drive API in Google Cloud Console"
echo "   - Enable Google Calendar API in Google Cloud Console"
echo "   - Create OAuth 2.0 credentials"
echo ""
echo "2. Notion API Setup:"
echo "   - Generate Notion integration token"
echo "   - Share integration with workspace"
echo ""
echo "3. Slack Setup:"
echo "   - Create Slack App"
echo "   - Enable bot token scopes: chat:write, chat:read, users:read"
echo "   - Install app to workspace"
echo ""
echo "4. Brave Search Setup:"
echo "   - Sign up for Brave Search API access"
echo ""
echo "5. Weather API Setup:"
echo "   - Sign up for OpenWeatherMap API"
echo ""
echo "6. News API Setup:"
echo "   - Sign up for NewsAPI.org"
echo ""
echo ""
echo "🔧 Next Steps:"
echo "=============="
echo "1. Fill in the configuration details in $CONFIG_DIR"
echo "2. Run the OAuth flow for Google services:"
echo "   python3 -m google_auth_oauthlib.flow --config $CONFIG_DIR"
echo "3. Test each MCP connection:"
echo "   claude mcp test gmail"
echo "   claude mcp test google-drive"
echo "   claude mcp test google-calendar"
echo "   claude mcp test notion"
echo "   claude mcp test slack"
echo "   claude mcp test brave-search"
echo "   claude mcp test weather"
echo "   claude mcp test news-api"
echo ""
echo "✅ Setup Complete! Please configure the API keys and credentials."