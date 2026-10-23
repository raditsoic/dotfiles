# dotfiles

## **quickstart**

Required for both local and workstation. Installs the shell (zsh), stow, go, rust, fd, zoxide, eza, and dust.

`bash quickstart/install.sh -s zsh`

## **zsh** — local (WSL)

Local shell config only — the workstation uses its own lean zshrc.

Stow the zsh directory with `stow zsh`

`source $HOME/.zshrc`

`p10k configure`

## **workstation** — cloud

Installs user-level tools on the cloud workstation (fzf, websocat, uv, bun, omp). System packages — apt essentials, Docker, Cloudflared, Tailscale, zsh/stow — come from the Ansible playbook in the cloud-ws repo:

`bash workstation/install.sh`

Shell: `cp workstation/.zshrc ~/.zshrc`
