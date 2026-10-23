#!/bin/bash

# User-level tools only (installed into $HOME). System packages — apt
# essentials, Docker, Cloudflared, Tailscale, zsh/stow — are installed as
# root by ansible/site.yml in the cloud-ws repo. Needs git + curl first.

# Install fzf (needed by zsh fzf-tab); ~/.fzf/install writes ~/.fzf.zsh, which .zshrc sources
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install websocat
mkdir -p ~/.local/bin
curl -fsSL https://github.com/vi/websocat/releases/latest/download/websocat.x86_64-unknown-linux-musl -o ~/.local/bin/websocat
chmod +x ~/.local/bin/websocat

# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install bun
curl -fsSL https://bun.sh/install | bash

# Install omp
curl -fsSL https://omp.sh/install | sh
