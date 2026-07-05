#!/bin/bash

echo "=================================================="
echo " Welcome to Hermes Agent on Render.com!           "
echo " Preconfigured with OpenCode Big Pickle           "
echo "=================================================="
echo ""

# Ensure .hermes directory exists
mkdir -p /home/user/.hermes

# Explicitly override with OpenCode Big Pickle model
API_KEY="${OPENCODE_API_KEY:-sk-dv2ZBxfmzW7Lp6J4MSSOOEAXC9ZkzRe5XK2d7H6jQv8YBiEZ4OF2wG24qnaueCEg}"

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
