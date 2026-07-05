FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    nodejs \
    npm \
    ffmpeg \
    ripgrep \
    procps \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install webconsole
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then TTYD_ARCH="x86_64"; \
    elif [ "$ARCH" = "aarch64" ]; then TTYD_ARCH="aarch64"; \
    else TTYD_ARCH="x86_64"; fi && \
    curl -fsSL "https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.${TTYD_ARCH}" -o /usr/local/bin/webconsole && \
    chmod +x /usr/local/bin/webconsole

# Create user with UID 1000
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user
ENV PATH="/home/user/.local/bin:${PATH}"
WORKDIR /home/user

# Install Hermes Agent via official install script
RUN curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash || true

# Entrypoint script
COPY --chown=user:user entrypoint.sh /home/user/entrypoint.sh
RUN chmod +x /home/user/entrypoint.sh

EXPOSE 10000

CMD ["/home/user/entrypoint.sh"]
