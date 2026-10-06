#!/bin/bash

# Install apt essentials
sudo apt-get update
sudo apt-get install -y git gh build-essential jq htop tree git-lfs zip unzip lsof rsync vim byobu dnsutils iputils-ping

# Install fzf (needed by zsh fzf-tab)
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

# Install Docker
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /usr/share/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /usr/share/keyrings/docker.gpg >/dev/null
sudo chmod a+r /usr/share/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

# Install Cloudflared
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflared.list
sudo apt-get update
sudo apt-get install cloudflared

# Install Tailscale
curl -fsSL https://tailscale.com/install.sh | sh
