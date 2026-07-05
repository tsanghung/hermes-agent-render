#!/bin/bash

echo "=================================================="
echo " Welcome to Hermes Agent on Render.com!           "
echo " Preconfigured with NVIDIA NIM GLM-5.2            "
echo "=================================================="
echo ""

# Ensure .hermes directory exists
mkdir -p /home/user/.hermes

# Pre-configure NVIDIA NIM GLM-5.2
API_KEY="${NVIDIA_API_KEY:-$OPENAI_API_KEY}"
if [ -n "$API_KEY" ]; then
    cat <<EOF > /home/user/.hermes/config.yaml
model:
  provider: custom
  name: z-ai/glm-5.2
  base_url: https://integrate.api.nvidia.com/v1
  api_key: ${API_KEY}
EOF

    cat <<EOF > /home/user/.hermes/auth.json
{
  "custom": {
    "api_key": "${API_KEY}",
    "base_url": "https://integrate.api.nvidia.com/v1"
  }
}
EOF
fi

# Use Render PORT environment variable or default to 10000
PORT_NUM="${PORT:-10000}"

# Start web console service
exec /usr/local/bin/webconsole -p ${PORT_NUM} -W bash
