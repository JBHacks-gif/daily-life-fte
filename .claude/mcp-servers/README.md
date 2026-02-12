# MCP Server Configuration Guide

This document provides complete instructions for setting up all MCP servers required for the Daily Life Productivity Digital FTE project.

## Overview

The project integrates 8 external services through MCP (Model Context Protocol):
- Gmail (Email management)
- Google Drive (Document storage)
- Google Calendar (Schedule management)
- Notion (Knowledge base)
- Slack (Notifications)
- Brave Search (Web research)
- Weather API (Weather data)
- News API (Industry news)

## Quick Setup Steps

### 1. Initial Configuration
```bash
# Navigate to MCP servers directory
cd .claude/mcp-servers/

# Make setup script executable
chmod +x setup.sh

# Run setup script
./setup.sh
```

### 2. API Key Configuration
Edit the main configuration file:
```bash
nano ../config.json
```

### 3. Service Setup
Follow the detailed setup instructions for each service below.

---

## Detailed Service Setup

### 1. Google Services (Gmail, Drive, Calendar)

#### Prerequisites
- Google Cloud Console account
- Project created in Google Cloud

#### Setup Steps

**1. Enable APIs**
- Go to [Google Cloud Console](https://console.cloud.google.com/)
- Select your project
- Enable these APIs:
  - Gmail API
  - Google Drive API
  - Google Calendar API

**2. Create OAuth 2.0 Credentials**
- Go to "APIs & Services" → "Credentials"
- Click "Create Credentials" → "OAuth 2.0 Client ID"
- Select "Web application"
- Add Authorized redirect URIs: `http://localhost:3000/oauth2callback`
- Download the credentials.json file

**3. Update Configuration**
Edit `../config.json`:
```json
{
  "google": {
    "client_id": "YOUR_CLIENT_ID.apps.googleusercontent.com",
    "client_secret": "YOUR_CLIENT_SECRET",
    "redirect_uri": "http://localhost:3000/oauth2callback"
  }
}
```

**4. Complete OAuth Flow**
```bash
python3 -m google_auth_oauthlib.flow --config ../config.json
```

#### Required Scopes
- Gmail: `https://mail.google.com/`, `https://www.googleapis.com/auth/gmail.modify`
- Drive: `https://www.googleapis.com/auth/drive.file`, `https://www.googleapis.com/auth/drive.readonly`
- Calendar: `https://www.googleapis.com/auth/calendar`, `https://www.googleapis.com/auth/calendar.events`

---

### 2. Notion Integration

#### Prerequisites
- Notion account
- Notion workspace

#### Setup Steps

**1. Create Integration**
- Go to [Notion Integrations](https://www.notion.so/my-integrations)
- Click "+ New integration"
- Give it a name (e.g., "Daily Life FTE")
- Select your workspace
- Click "Submit"

**2. Copy API Key**
- Copy the Internal Integration Token
- Share the integration with your workspace

**3. Get Workspace ID**
- In Notion, right-click any page in your workspace
- Copy the link
- The workspace ID is the part after `https://www.notion.so/`

**4. Update Configuration**
Edit `../config.json`:
```json
{
  "notion": {
    "api_key": "YOUR_NOTION_API_KEY",
    "workspace_id": "YOUR_WORKSPACE_ID"
  }
}
```

---

### 3. Slack Integration

#### Prerequisites
- Slack workspace
- Admin or app management permissions

#### Setup Steps

**1. Create Slack App**
- Go to [Slack API](https://api.slack.com/apps)
- Click "Create New App"
- Select "From scratch"
- Give it a name (e.g., "Daily Life FTE")
- Select your workspace

**2. Configure Bot Token Scopes**
- Go to "OAuth & Permissions"
- Add these scopes under "Bot Token Scopes":
  - `chat:write`
  - `chat:read`
  - `users:read`

**3. Install App**
- Click "Install to Workspace"
- Approve permissions
- Copy the Bot User OAuth Token

**4. Get Verification Token**
- In the same OAuth & Permissions page
- Copy the "Verification Token"

**5. Get Signing Secret**
- Go to "Basic Information"
- Under "App Credentials", copy the "Signing Secret"

**6. Update Configuration**
Edit `../config.json`:
```json
{
  "slack": {
    "bot_token": "xoxb-YOUR_BOT_TOKEN",
    "verification_token": "YOUR_VERIFICATION_TOKEN",
    "signing_secret": "YOUR_SIGNING_SECRET"
  }
}
```

---

### 4. Brave Search Integration

#### Prerequisites
- Brave Search API account

#### Setup Steps

**1. Sign Up**
- Go to [Brave Search API](https://api.brave.com/)
- Sign up for API access
- Choose appropriate plan

**2. Get API Key**
- Copy your API key from the dashboard

**3. Update Configuration**
Edit `../config.json`:
```json
{
  "brave_search": {
    "api_key": "YOUR_BRAVE_SEARCH_API_KEY"
  }
}
```

---

### 5. Weather API Integration

#### Prerequisites
- OpenWeatherMap account

#### Setup Steps

**1. Sign Up**
- Go to [OpenWeatherMap](https://openweathermap.org/)
- Create a free account
- Choose appropriate plan (Free tier supports 1000 calls/day)

**2. Get API Key**
- Copy your API key from the dashboard

**3. Update Configuration**
Edit `../config.json`:
```json
{
  "weather": {
    "api_key": "YOUR_OPENWEATHERMAP_API_KEY"
  }
}
```

---

### 6. News API Integration

#### Prerequisites
- NewsAPI.org account

#### Setup Steps

**1. Sign Up**
- Go to [NewsAPI.org](https://newsapi.org/)
- Create a free account
- Choose appropriate plan (Free tier supports 500 calls/day)

**2. Get API Key**
- Copy your API key from the dashboard

**3. Update Configuration**
Edit `../config.json`:
```json
{
  "news_api": {
    "api_key": "YOUR_NEWS_API_KEY"
  }
}
```

---

## Testing MCP Connections

After configuration, test each MCP server:

```bash
# Test individual connections
claude mcp test gmail
claude mcp test google-drive
claude mcp test google-calendar
claude mcp test notion
claude mcp test slack
claude mcp test brave-search
claude mcp test weather
claude mcp test news-api

# Test all connections
claude mcp test all
```

## Troubleshooting

### Common Issues

**1. Authentication Errors**
- Check that API keys are correctly entered
- Verify scopes are properly configured
- Ensure OAuth tokens are valid

**2. Rate Limit Errors**
- Check API usage limits
- Implement proper backoff strategies
- Consider upgrading to higher-tier plans if needed

**3. Network Errors**
- Verify internet connectivity
- Check firewall settings
- Ensure correct base URLs

**4. Permission Errors**
- Verify OAuth scopes
- Check workspace permissions (Notion/Slack)
- Ensure proper admin access

### Debug Mode
Enable debug logging to troubleshoot issues:

```bash
export DEBUG=mcp:*
claude mcp test gmail
```

### Logs Location
MCP logs are stored in:
```
~/.claude/logs/mcp/
```

## Security Best Practices

1. **Never commit API keys** - Use environment variables or secret managers
2. **Use least privilege** - Only enable necessary scopes
3. **Regular rotation** - Rotate API keys periodically
4. **Audit access** - Regularly review who has access
5. **Monitor usage** - Track API usage and set up alerts

## Configuration File Structure

The main configuration file (`../config.json`) contains all credentials:

```json
{
  "google": {
    "client_id": "",
    "client_secret": "",
    "redirect_uri": ""
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
}
```

## File Organization

All MCP configurations are stored in:
```
.claude/mcp-servers/
├── gmail.json
├── google-drive.json
├── google-calendar.json
├── notion.json
├── slack.json
├── brave-search.json
├── weather.json
├── news-api.json
├── setup.sh
├── README.md
└── master-config.json
```

## Next Steps

1. Complete the setup steps for each service
2. Test all MCP connections
3. Verify data flow between services
4. Set up monitoring and alerts
5. Document any custom configurations

---

**Last Updated**: 2026-02-12
**Version**: 1.0
**Project**: Daily Life Productivity Digital FTE