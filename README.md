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

Provisions a cloud workstation (omp, docker, cloudflared, tailscale, fzf, websocat, uv, bun):

`bash workstation/install.sh`

Shell: `cp workstation/.zshrc ~/.zshrc`
