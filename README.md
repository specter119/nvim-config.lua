[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/specter119/nvim-config.lua/main.svg)](https://results.pre-commit.ci/latest/github/specter119/nvim-config.lua/main)

# Neovim Configuration for Data Science Development

A modern, performance-focused Neovim configuration specifically designed for data science workflows. Built with lazy.nvim plugin manager and featuring a structured namespace-based keymap system.

## Features

### 🎯 Core Architecture

- **Lazy Loading**: Optimized startup with lazy.nvim plugin management
- **Structured Keymaps**: Namespace-based keymap organization prevents conflicts
- **Data Science Focus**: Pre-configured for Python, Lua, and data analysis workflows
- **Performance Optimized**: Arch Linux tree-sitter integration and efficient loading

### 🔧 Development Tools

- **LSP Support**: Python (pyright), Lua (lua_ls), and extensible language support
- **Testing Framework**: Integrated neotest with pytest adapter
- **Debugging**: nvim-dap with Python debugpy support
- **Task Management**: overseer for project task automation
- **Git Integration**: Advanced git operations with gitsigns

### 🎨 User Experience

- **Theme**: Rose Pine color scheme with modern aesthetics
- **File Explorer**: Enhanced nvim-tree with intuitive navigation
- **Fuzzy Finding**: Telescope integration for powerful search capabilities
- **Auto-completion**: nvim-cmp with comprehensive completion sources
- **Code Quality**: Pre-commit hooks with StyLua formatting

## Quick Start

### Prerequisites

- Neovim >= 0.9.0
- Git
- Python 3.8+ (for data science features)
- Node.js (for certain LSP servers)

### Installation

1. **Backup existing configuration**:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone and setup**:

   ```bash
   git clone https://github.com/specter119/nvim-config.lua.git ~/.config/nvim
   ```

3. **Start Neovim and install plugins**:

   ```bash
   nvim
   ```

   Plugins will auto-install on first launch.

## Configuration Structure

```
nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua         # Neovim settings
│   │   ├── lazy.lua           # Plugin manager setup
│   │   └── keymaps/           # Structured keymap system
│   │       ├── init.lua       # Keymap entry point
│   │       ├── core.lua       # Core keymaps
│   │       └── rules.lua      # Namespace rules
│   └── plugins/               # Plugin configurations
│       ├── lsp.lua           # Language server setup
│       ├── telescope.lua     # Fuzzy finder
│       ├── nvim-cmp.lua      # Completion engine
│       ├── neotest.lua       # Testing framework
│       ├── nvim-dap.lua      # Debugging
│       └── ...
```

## Keymap System

This configuration implements a strict namespace-based keymap system to prevent conflicts and maintain consistency:

### Namespace Rules

- `<leader>a*` - AI/Agentic features (Claude Code, etc.)
- `<leader>f*` - Find/Files operations
- `<leader>g*` - Git operations
- `<leader>c*` - Code/LSP operations
- `<leader>d*` - Debug/Diagnostics
- `<leader>t*` - Toggle operations
- `<leader>w*` - Window operations
- `<leader>b*` - Buffer operations
- `<leader>h*` - Help/Documentation

### Reserved Keys

- `<leader>e` - File Explorer (nvim-tree)
- `<leader>u` - Undo Tree
- `<leader>q` - Quit
- `<leader>Q` - Quit All

### Validation

Use `:ValidateKeymaps` to check for keymap conflicts and `:ShowKeymapRules` to display the namespace system.

## Development Workflow

### Code Formatting

```bash
# Format Lua code
stylua nvim/

# Run all pre-commit hooks
pre-commit run --all-files
```

### Plugin Management

```vim
:Lazy update          " Update all plugins
:Lazy sync            " Clean + update plugins
:Lazy                 " Open plugin manager
```

### Language Support

#### Python Development

- **LSP**: pyright for type checking and IntelliSense
- **Formatting**: Automatic formatting with conform.nvim
- **Testing**: pytest integration with neotest
- **Debugging**: debugpy support with nvim-dap

#### Lua Development

- **LSP**: lua_ls optimized for Neovim development
- **Formatting**: StyLua with project-specific configuration
- **Testing**: Built-in testing support

### Data Science Features

- **Markdown**: Enhanced editing with marksman LSP
- **Notebooks**: Planned Jupyter integration
- **Data Formats**: JSON, YAML, TOML support
- **Documentation**: Typst support with tinymist LSP

## Customization

### Adding Languages

1. Install LSP server via Mason: `:Mason`
2. Configure in `plugins/lsp.lua`
3. Add keymaps following namespace rules
4. Update formatting rules if needed

### Plugin Configuration

All plugins follow lazy.nvim best practices:

- Lazy loading with `event`, `keys`, or `cmd`
- Explicit dependency declarations
- Namespace-compliant keymaps

### Performance Tuning

- Tree-sitter parsers automatically detected on Arch Linux
- Lazy loading minimizes startup time
- Performance settings optimized in `config/options.lua`

## Contributing

1. Follow the namespace keymap system
2. Use StyLua for code formatting
3. Add appropriate lazy loading for new plugins
4. Validate keymaps with `:ValidateKeymaps`
5. Update documentation for new features

## License

MIT License - see [LICENSE](LICENSE) for details.
