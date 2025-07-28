# Neovim Dotfiles

A modern, feature-rich Neovim configuration built on [LazyVim](https://github.com/LazyVim/LazyVim) with extensive language support for Go, Python, C/C++, TypeScript, and Scala development.

## ✨ Features

### 🎨 UI & Experience
- **Tokyo Night** colorscheme with moon variant
- **LazyVim** as the foundation for a modern Neovim experience
- **Todo Comments** highlighting for better task management
- **Mini Icons** for enhanced file type recognition

### 🔧 Language Support

#### Go Development
- **gopls** LSP with comprehensive Go tooling
- **Go-specific debugging** with delve integration
- **Code formatting** with goimports and gofumpt
- **Test integration** with neotest-golang
- **Code generation** with impl and gomodifytags

#### Python Development
- **Pyright** LSP for type checking and IntelliSense
- **Ruff** for fast linting and formatting
- **Debugging** support with debugpy
- **Test integration** with neotest-python

#### C/C++ Development
- **clangd** LSP with clangd-extensions
- **CMake Tools** for build system integration
- **Header/Source switching** with alternate-toggler
- **Code formatting** with .clang-format support
- **Debugging** with codelldb

#### TypeScript/JavaScript
- **tsserver** LSP with typescript.nvim integration
- **JavaScript debugging** with VSCode JS Debugger
- **File organization** and refactoring tools

#### Scala Development
- **Metals** LSP for Scala and Java
- **SBT** build tool integration
- **Advanced Scala features** with implicit highlighting

### 🐛 Debugging
- **nvim-dap** for multi-language debugging
- **Go debugging** with delve integration
- **Python debugging** with debugpy
- **JavaScript/TypeScript debugging** with VSCode JS Debugger
- **DAP UI** for enhanced debugging experience

### 🤖 AI Integration
- **Avante.nvim** for AI-powered coding assistance
- **Ollama integration** with qwen2.5-coder model
- **Image pasting** support with img-clip.nvim
- **Markdown rendering** for AI responses

### 🛠️ Development Tools
- **Mason** for LSP/DAP installation and management
- **Treesitter** for syntax highlighting and code analysis
- **Telescope** for fuzzy finding
- **Conform.nvim** for code formatting
- **Trouble** for diagnostics and quickfix

## 🚀 Quick Start

### Prerequisites

1. **Neovim 0.9+** (nightly recommended)
2. **Git** for plugin management
3. **Node.js** for TypeScript/JavaScript support
4. **Python** for Python development
5. **Go** for Go development
6. **Rust** for some tools (optional)

### Installation

#### Quick Installation (Recommended)
```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/.config/nvim
cd ~/.config/nvim

# Run the installation script
./install.sh
```

#### Manual Installation
1. **Backup your existing Neovim config:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository:**
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.config/nvim
   cd ~/.config/nvim
   ```

3. **Start Neovim:**
   ```bash
   nvim
   ```

4. **Wait for LazyVim to install plugins** (first startup may take a few minutes)

#### Verify Installation
After installation, you can run a health check to verify everything is working:
```bash
nvim --headless -l health_check.lua
```

### Language-Specific Setup

#### Go
```bash
# Install Go tools
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/josharian/impl@latest
```

#### Python
```bash
# Install Python tools
pip install ruff
pip install debugpy
```

#### C/C++
```bash
# Install clangd (Arch Linux)
sudo pacman -S clangd

# Or via Mason (recommended)
# Will be installed automatically when you open a C/C++ file
```

#### TypeScript/JavaScript
```bash
# Install Node.js and npm/yarn
# LSP tools will be installed automatically via Mason
```

#### Scala
```bash
# Install Coursier and Metals
curl -fL https://github.com/coursier/coursier/releases/latest/download/cs-x86_64-apple-darwin.gz | gzip -d > cs
chmod +x cs
./cs setup
```

## 🎯 Key Mappings

### General
- `<leader>` = `<space>` (default)
- `<leader>e` = File explorer
- `<leader>ff` = Find files
- `<leader>fg` = Live grep
- `<leader>fb` = Buffer list
- `<leader>fh` = Help tags

### LSP
- `gd` = Go to definition
- `gr` = Go to references
- `K` = Hover documentation
- `<leader>ca` = Code actions
- `<leader>rn` = Rename symbol
- `<leader>co` = Organize imports

### Go-specific
- `<leader>ch` = Switch source/header (C/C++)
- `<leader>ci` = Toggle inlay hints (C/C++)

### Debugging
- `<leader>dd` = Start/continue debugging
- `<leader>db` = Toggle breakpoint
- `<leader>dr` = Restart debugging
- `<leader>ds` = Stop debugging

### AI (Avante)
- `<leader>aa` = Open Avante chat
- `<leader>ac` = Code completion
- `<leader>ar` = Code review

## 🔧 Configuration

### Custom Keymaps
Edit `lua/config/keymaps.lua` to add your custom keymaps.

### Plugin Configuration
- **LSP**: `lua/plugins/me.lua`
- **Debugging**: `lua/plugins/debugging.lua`
- **UI**: `lua/plugins/ui.lua`
- **AI**: `lua/plugins/avante.lua`

### Language-Specific Settings
- **Go**: Configured in `lua/plugins/me.lua`
- **Python**: Uses pyright + ruff
- **C/C++**: Uses clangd with extensions
- **TypeScript**: Uses tsserver with typescript.nvim

## 🐛 Troubleshooting

### Common Issues

1. **Plugins not loading:**
   ```bash
   :Lazy sync
   ```

2. **LSP not working:**
   ```bash
   :Mason
   # Install required LSP servers
   ```

3. **Debugging not working:**
   - Ensure delve is installed for Go debugging
   - Check debugpy installation for Python
   - Verify VSCode JS Debugger path for JavaScript

4. **AI features not working:**
   - Ensure Ollama is running: `ollama serve`
   - Check model availability: `ollama list`

### Logs
- **LazyVim logs**: `:Lazy log`
- **LSP logs**: `:LspInfo`
- **DAP logs**: Check `/tmp/dap_vscode_js.log` for JS debugging

## 🎨 Customization

### Colorscheme
The configuration uses Tokyo Night with the moon variant. To change:

```lua
-- In lua/plugins/ui.lua
opts = { style = "storm" } -- or "day", "night", "moon"
```

### Adding New Languages
1. Create a new file in `lua/plugins/`
2. Add LSP configuration
3. Configure Mason to install required tools
4. Add Treesitter parsers if needed

### Adding New Plugins
1. Create a new file in `lua/plugins/`
2. Follow the LazyVim plugin specification
3. Use `:Lazy sync` to install

## 📁 Project Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── lazy-lock.json          # Plugin lock file
├── lazyvim.json           # LazyVim configuration
├── stylua.toml            # Lua formatting rules
└── lua/
    ├── config/            # Core configuration
    │   ├── autocmds.lua   # Auto commands
    │   ├── dap.lua        # Debug configuration
    │   ├── keymaps.lua    # Key mappings
    │   ├── lazy.lua       # Plugin manager setup
    │   └── options.lua    # Neovim options
    ├── plugins/           # Plugin configurations
    │   ├── avante.lua     # AI integration
    │   ├── debugging.lua  # Debugging tools
    │   ├── example.lua    # Example configurations
    │   ├── lsp.lua        # LSP configuration
    │   ├── me.lua         # Main LSP setup
    │   ├── scala.lua      # Scala support
    │   └── ui.lua         # UI plugins
    └── user/              # User-specific configs
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [LazyVim](https://github.com/LazyVim/LazyVim) for the excellent foundation
- [Folke](https://github.com/folke) for Tokyo Night and other amazing plugins
- All plugin authors for their contributions to the Neovim ecosystem

## 📞 Support

If you encounter any issues:

1. Check the [troubleshooting section](#-troubleshooting)
2. Search existing [issues](../../issues)
3. Create a new issue with detailed information

---

**Happy coding! 🚀** 