#!/bin/bash

echo "=================================================="
echo " Welcome to Hermes Agent on Render.com!           "
echo " Preconfigured with OpenCode Big Pickle           "
echo "=================================================="
echo ""

API_KEY="sk-dv2ZBxfmzW7Lp6J4MSSOOEAXC9ZkzRe5XK2d7H6jQv8YBiEZ4OF2wG24qnaueCEg"

# Force wipe and write config files
mkdir -p /home/user/.hermes

cat << 'EOF' > /home/user/.hermes/config.yaml
model:
  provider: custom
  name: big-pickle
  base_url: https://opencode.ai/zen/v1
  api_key: sk-dv2ZBxfmzW7Lp6J4MSSOOEAXC9ZkzRe5XK2d7H6jQv8YBiEZ4OF2wG24qnaueCEg
EOF

cat << 'EOF' > /home/user/.hermes/auth.json
{
  "custom": {
    "api_key": "sk-dv2ZBxfmzW7Lp6J4MSSOOEAXC9ZkzRe5XK2d7H6jQv8YBiEZ4OF2wG24qnaueCEg",
    "base_url": "https://opencode.ai/zen/v1"
  }
}
EOF

chown -R user:user /home/user/.hermes

# Use Render PORT environment variable or default to 10000
PORT_NUM="${PORT:-10000}"

# Start web console service
exec /usr/local/bin/webconsole -p ${PORT_NUM} -W bash
