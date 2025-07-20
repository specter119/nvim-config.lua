-- Keymap namespace rules
-- Core rules for keymap management to avoid conflicts

local M = {}

-- Namespace allocation (strictly enforced)
M.namespaces = {
  -- Primary functional areas (lowercase letters)
  a = 'Agentic/AI', -- AI features (Claude Code, Copilot, etc.)
  f = 'Find/Files', -- Search and file operations
  g = 'Git', -- Git-related operations
  c = 'Code/LSP', -- Code and LSP operations
  d = 'Debug/Diagnostics', -- Debugging and diagnostics
  t = 'Toggle', -- Toggle options
  w = 'Window', -- Window operations
  b = 'Buffer', -- Buffer operations
  h = 'Help', -- Help and documentation

  -- Special features (uppercase letters, reserved for expansion)
  T = 'Terminal', -- Terminal operations
  S = 'Session', -- Session management
}

-- Reserved single keys (do not use namespace)
M.reserved_keys = {
  ['<leader>e'] = 'File Explorer',
  ['<leader>u'] = 'Undo Tree',
  ['<leader>q'] = 'Quit',
  ['<leader>Q'] = 'Quit All',
}

-- Validate if keymap follows namespace rules
function M.validate_key(key)
  -- Check if it's a reserved key
  if M.reserved_keys[key] then
    return true, 'Reserved key'
  end

  -- Check namespace format
  local prefix = key:match '^<leader>([a-zA-Z])'
  if not prefix then
    return true, 'Non-namespaced key'
  end

  -- Check if it's a valid namespace
  if not M.namespaces[prefix] then
    return false, 'Invalid namespace: ' .. prefix
  end

  return true, 'Valid namespace: ' .. M.namespaces[prefix]
end

-- Get recommended keymaps
function M.suggest_key(description)
  local suggestions = {}

  -- Recommend namespace based on description
  local desc_lower = description:lower()

  if desc_lower:match 'find' or desc_lower:match 'search' or desc_lower:match 'file' then
    table.insert(suggestions, '<leader>f')
  end

  if desc_lower:match 'git' or desc_lower:match 'hunk' or desc_lower:match 'commit' then
    table.insert(suggestions, '<leader>g')
  end

  if desc_lower:match 'code' or desc_lower:match 'lsp' or desc_lower:match 'action' then
    table.insert(suggestions, '<leader>c')
  end

  if desc_lower:match 'debug' or desc_lower:match 'diagnostic' or desc_lower:match 'trouble' then
    table.insert(suggestions, '<leader>d')
  end

  if desc_lower:match 'toggle' or desc_lower:match 'switch' then
    table.insert(suggestions, '<leader>t')
  end

  if desc_lower:match 'window' or desc_lower:match 'split' then
    table.insert(suggestions, '<leader>w')
  end

  if desc_lower:match 'buffer' then
    table.insert(suggestions, '<leader>b')
  end

  if desc_lower:match 'help' or desc_lower:match 'doc' then
    table.insert(suggestions, '<leader>h')
  end

  if desc_lower:match 'claude' then
    table.insert(suggestions, '<leader>a')
  end

  return suggestions
end

-- Show namespace rules
function M.show_rules()
  local lines = { '=== Keymap Namespace Rules ===' }

  for prefix, desc in pairs(M.namespaces) do
    table.insert(lines, string.format('<leader>%s* → %s', prefix, desc))
  end

  table.insert(lines, '')
  table.insert(lines, '=== Reserved Keys ===')
  for key, desc in pairs(M.reserved_keys) do
    table.insert(lines, string.format('%s → %s', key, desc))
  end

  vim.api.nvim_echo(
    vim.tbl_map(function(line)
      return { line, 'Normal' }
    end, lines),
    true,
    {}
  )
end

-- Create user command
vim.api.nvim_create_user_command('ShowKeymapRules', M.show_rules, { desc = 'Show keymap namespace rules' })

return M
