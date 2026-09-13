#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# Neovim Development Environment - Dependency Installer
# ============================================================

NVIM_INSTALL_DIR="/opt/nvim-linux-x86_64"
NODE_VERSION="24"

echo "=========================================="
echo " Neovim Development Environment Installer"
echo "=========================================="
echo

# ------------------------------------------------------------
# Helpers
# ------------------------------------------------------------

info() {
    echo
    echo "[*] $1"
}

success() {
    echo "[+] $1"
}

error() {
    echo "[!] $1"
}

# ------------------------------------------------------------
# Check OS
# ------------------------------------------------------------

if [[ ! -f /etc/debian_version ]]; then
    error "This installer currently targets Debian-based systems."
    exit 1
fi

# ------------------------------------------------------------
# Check sudo
# ------------------------------------------------------------

if ! command -v sudo >/dev/null 2>&1; then
    error "sudo is required."
    exit 1
fi

# ------------------------------------------------------------
# Basic system dependencies
# ------------------------------------------------------------

info "Installing system dependencies..."

sudo apt update

sudo apt install -y \
    curl \
    git \
    unzip \
    tar \
    gzip \
    build-essential \
    clang \
    clang-format \
    gcc \
    g++ \
    make \
    python3 \
    python3-pip

success "System dependencies installed."

# ------------------------------------------------------------
# Neovim
# ------------------------------------------------------------

info "Installing Neovim..."

if command -v nvim >/dev/null 2>&1; then
    CURRENT_NVIM="$(nvim --version | head -n 1)"
    echo "Existing Neovim detected: $CURRENT_NVIM"
fi

cd /tmp

rm -f nvim-linux-x86_64.tar.gz

curl -LO \
    https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

sudo rm -rf "$NVIM_INSTALL_DIR"

sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

success "Neovim installed to $NVIM_INSTALL_DIR"

# ------------------------------------------------------------
# Add Neovim to PATH
# ------------------------------------------------------------

info "Configuring Neovim PATH..."

BASHRC="$HOME/.bashrc"

NVIM_PATH_LINE='export PATH="/opt/nvim-linux-x86_64/bin:$PATH"'

if ! grep -Fxq "$NVIM_PATH_LINE" "$BASHRC" 2>/dev/null; then
    echo
    echo "$NVIM_PATH_LINE" >> "$BASHRC"
    success "Added Neovim to ~/.bashrc"
else
    echo "Neovim PATH already present."
fi

export PATH="/opt/nvim-linux-x86_64/bin:$PATH"

# ------------------------------------------------------------
# nvm
# ------------------------------------------------------------

info "Installing nvm..."

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
    curl -o- \
        https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.7/install.sh \
        | bash
else
    echo "nvm already installed."
fi

# Load nvm into this script
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    # shellcheck disable=SC1090
    source "$NVM_DIR/nvm.sh"
else
    error "Could not load nvm."
    exit 1
fi

success "nvm ready."

# ------------------------------------------------------------
# Node.js
# ------------------------------------------------------------

info "Installing Node.js $NODE_VERSION..."

if ! nvm ls "$NODE_VERSION" >/dev/null 2>&1; then
    nvm install "$NODE_VERSION"
else
    echo "Node.js $NODE_VERSION already installed."
fi

nvm alias default "$NODE_VERSION"
nvm use "$NODE_VERSION"

success "Node.js $(node --version)"
success "npm $(npm --version)"

# ------------------------------------------------------------
# Ruff
# ------------------------------------------------------------

info "Installing Ruff..."

if command -v ruff >/dev/null 2>&1; then
    echo "Ruff already installed:"
    ruff --version
else
    curl -LsSf https://astral.sh/ruff/install.sh | sh
fi

# Ruff normally installs into ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

if command -v ruff >/dev/null 2>&1; then
    success "Ruff $(ruff --version)"
else
    error "Ruff installation completed but 'ruff' is not currently in PATH."
    echo "Add ~/.local/bin to your PATH if necessary."
fi

# ------------------------------------------------------------
# JavaScript / TypeScript formatter
# ------------------------------------------------------------

info "Installing Prettier..."

if npm list -g prettier >/dev/null 2>&1; then
    echo "Prettier already installed."
else
    npm install -g prettier
fi

success "Prettier $(prettier --version)"

# ------------------------------------------------------------
# Lua formatter
# ------------------------------------------------------------

info "Installing Stylua..."

if command -v stylua >/dev/null 2>&1; then
    echo "Stylua already installed:"
    stylua --version
else
    # Try Debian first.
    if apt-cache show stylua >/dev/null 2>&1; then
        sudo apt install -y stylua
    else
        echo "Stylua is not available from the configured apt repositories."
        echo "It can instead be installed through Mason:"
        echo
        echo "    :MasonInstall stylua"
        echo
    fi
fi

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------

echo
echo "=========================================="
echo " Installation complete"
echo "=========================================="
echo

echo "Neovim:"
nvim --version | head -n 1

echo
echo "Node:"
node --version

echo
echo "npm:"
npm --version

echo
echo "Ruff:"
ruff --version

echo
echo "Prettier:"
prettier --version

echo
echo "Clang:"
clang --version | head -n 1

echo
echo "Clang-format:"
clang-format --version

echo
echo "Git:"
git --version

echo
echo "=========================================="
echo " Next steps"
echo "=========================================="
echo
echo "1. Restart your shell:"
echo
echo "       exec bash"
echo
echo "2. Start Neovim:"
echo
echo "       nvim"
echo
echo "3. Let lazy.nvim install your plugins."
echo
echo "4. Open Mason:"
echo
echo "       :Mason"
echo
echo "5. Install any missing LSP/formatter packages."
echo

