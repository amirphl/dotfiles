#!/bin/bash

# Neovim Dotfiles Installation Script
# This script will install the Neovim configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Neovim is installed
check_neovim() {
    if ! command -v nvim &> /dev/null; then
        print_error "Neovim is not installed. Please install Neovim first."
        echo "Visit: https://neovim.io/doc/user/install.html"
        exit 1
    fi
    
    # Check Neovim version
    NVIM_VERSION=$(nvim --version | head -n1 | cut -d' ' -f2)
    print_status "Found Neovim version: $NVIM_VERSION"
    
    # Check if version is 0.9 or higher
    if [[ "$NVIM_VERSION" < "0.9" ]]; then
        print_warning "Neovim version $NVIM_VERSION detected. Version 0.9+ is recommended for best experience."
    fi
}

# Backup existing configuration
backup_config() {
    local nvim_dir="$HOME/.config/nvim"
    
    if [[ -d "$nvim_dir" ]]; then
        local backup_dir="${nvim_dir}.backup.$(date +%Y%m%d_%H%M%S)"
        print_status "Backing up existing Neovim configuration to: $backup_dir"
        mv "$nvim_dir" "$backup_dir"
        print_success "Backup completed"
    fi
}

# Install configuration
install_config() {
    local current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local nvim_dir="$HOME/.config/nvim"
    
    print_status "Installing Neovim configuration..."
    
    # Create nvim directory
    mkdir -p "$nvim_dir"
    
    # Copy configuration files
    cp -r "$current_dir"/* "$nvim_dir/"
    
    # Remove installation script from nvim directory
    rm -f "$nvim_dir/install.sh"
    
    print_success "Configuration installed to: $nvim_dir"
}

# Install language-specific tools
install_tools() {
    print_status "Checking for language-specific tools..."
    
    # Go tools
    if command -v go &> /dev/null; then
        print_status "Installing Go tools..."
        go install golang.org/x/tools/gopls@latest
        go install github.com/go-delve/delve/cmd/dlv@latest
        go install mvdan.cc/gofumpt@latest
        go install golang.org/x/tools/cmd/goimports@latest
        go install github.com/fatih/gomodifytags@latest
        go install github.com/josharian/impl@latest
        print_success "Go tools installed"
    else
        print_warning "Go not found. Go tools will be installed via Mason when needed."
    fi
    
    # Python tools
    if command -v python3 &> /dev/null; then
        print_status "Installing Python tools..."
        python3 -m pip install --user ruff debugpy
        print_success "Python tools installed"
    else
        print_warning "Python3 not found. Python tools will be installed via Mason when needed."
    fi
    
    # Node.js tools
    if command -v node &> /dev/null; then
        print_status "Node.js found. TypeScript/JavaScript tools will be installed via Mason."
    else
        print_warning "Node.js not found. Install Node.js for TypeScript/JavaScript support."
    fi
}

# Main installation
main() {
    echo "🚀 Neovim Dotfiles Installation"
    echo "================================"
    echo
    
    check_neovim
    backup_config
    install_config
    install_tools
    
    echo
    print_success "Installation completed!"
    echo
    echo "Next steps:"
    echo "1. Start Neovim: nvim"
    echo "2. Wait for LazyVim to install plugins (first startup may take a few minutes)"
    echo "3. Check the README.md for detailed usage instructions"
    echo
    echo "For troubleshooting, see the README.md file or run: nvim --headless -c 'Lazy log'"
}

# Run main function
main "$@" 