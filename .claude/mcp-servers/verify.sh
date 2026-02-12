#!/bin/bash

# MCP Server Verification Script
# For Daily Life Productivity Digital FTE Project

echo "🔍 Verifying MCP Server Configurations..."
echo "=========================================="

# Check if all MCP config files exist
MCP_DIR=".claude/mcp-servers"
if [ ! -d "$MCP_DIR" ]; then
    echo "❌ MCP directory not found. Please create the project structure first."
    exit 1
fi

# List of MCP servers to verify
MCP_SERVERS=("gmail" "google-drive" "google-calendar" "notion" "slack" "brave-search" "weather" "news-api")

# Check configuration file
CONFIG_FILE="../config.json"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "⚠️  Configuration file not found: $CONFIG_FILE"
    echo "   Please run ./setup.sh first to create the configuration template."
    echo ""
else
    echo "✅ Configuration file found: $CONFIG_FILE"
    echo "   Please ensure all API keys are properly configured."
    echo ""
fi

# Verify each MCP server configuration
echo "📋 Checking MCP server configurations:"
echo "=========================================="

for server in "${MCP_SERVERS[@]}"; do
    CONFIG_FILE="$MCP_DIR/$server.json"

    if [ -f "$CONFIG_FILE" ]; then
        echo "✅ $server.json found"

        # Check if the file contains authentication section
        if grep -q '"authentication"' "$CONFIG_FILE"; then
            echo "   ✓ Authentication section exists"

            # Check for placeholder values
            if grep -q 'placeholder\|{USER_' "$CONFIG_FILE"; then
                echo "   ⚠️  Contains placeholder values - needs configuration"
            else
                echo "   ✓ Authentication configured"
            fi
        else
            echo "   ❌ Authentication section missing"
        fi

        echo ""
    else
        echo "❌ $server.json not found"
        echo ""
    fi
done

echo "🔍 Summary:"
echo "============"

# Check if master config exists
MASTER_CONFIG="$MCP_DIR/master-config.json"
if [ -f "$MASTER_CONFIG" ]; then
    echo "✅ Master configuration file exists"
else
    echo "⚠️  Master configuration file missing"
fi

# Check if setup script exists
SETUP_SCRIPT="$MCP_DIR/setup.sh"
if [ -f "$SETUP_SCRIPT" ]; then
    echo "✅ Setup script exists"
else
    echo "⚠️  Setup script missing"
fi

echo ""
echo "🎯 Next Steps:"
echo "==============="
echo "1. Configure all API keys in $CONFIG_FILE"
echo "2. Run the OAuth flow for Google services:"
echo "   python3 -m google_auth_oauthlib.flow --config $CONFIG_FILE"
echo "3. Test each MCP connection:"
echo "   claude mcp test gmail"
echo "   claude mcp test google-drive"
echo "   claude mcp test google-calendar"
echo "   claude mcp test notion"
echo "   claude mcp test slack"
echo "   claude mcp test brave-search"
echo "   claude mcp test weather"
echo "   claude mcp test news-api"
echo "4. Verify all services are working properly"
echo ""
echo "💡 Tips:"
echo "- Keep API keys secure - never commit them to version control"
echo "- Test each service individually before full integration"
echo "- Monitor API usage to avoid rate limit issues"
echo "- Implement proper error handling in your skills"
echo ""
echo "✅ Verification Complete! Ready for configuration."
