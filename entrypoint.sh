#!/bin/bash

echo "=================================================="
echo " Welcome to Hermes Agent on Render.com!           "
echo " Preconfigured with OpenCode Big Pickle           "
echo "=================================================="
echo ""

# Ensure .hermes directory exists
mkdir -p /home/user/.hermes

# Pre-configure OpenCode Big Pickle model
API_KEY="${OPENCODE_API_KEY:-$OPENAI_API_KEY}"
if [ -z "$API_KEY" ]; then
    API_KEY="opencode-zen-key"
fi

cat <<EOF > /home/user/.hermes/config.yaml
model:
  provider: custom
  name: big-pickle
  base_url: https://opencode.ai/zen/v1
  api_key: ${API_KEY}
EOF

cat <<EOF > /home/user/.hermes/auth.json
{
  "custom": {
    "api_key": "${API_KEY}",
    "base_url": "https://opencode.ai/zen/v1"
  }
}
EOF

# Use Render PORT environment variable or default to 10000
PORT_NUM="${PORT:-10000}"

# Start web console service
exec /usr/local/bin/webconsole -p ${PORT_NUM} -W bash
