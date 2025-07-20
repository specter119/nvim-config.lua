-- 快捷键命名空间规则
-- 这是快捷键管理的核心规则，避免冲突的关键

local M = {}

-- 命名空间分配 (严格执行)
M.namespaces = {
  -- 主要功能区域 (小写字母)
  a = 'Agentic/AI', -- AI 功能 (Claude Code, Copilot 等)
  f = 'Find/Files', -- 查找、文件操作
  g = 'Git', -- Git 相关操作
  c = 'Code/LSP', -- 代码、LSP 操作
  d = 'Debug/Diagnostics', -- 调试、诊断
  t = 'Toggle', -- 切换选项
  w = 'Window', -- 窗口操作
  b = 'Buffer', -- 缓冲区操作
  h = 'Help', -- 帮助文档

  -- 特殊功能 (大写字母，预留扩展)
  T = 'Terminal', -- 终端操作
  S = 'Session', -- 会话管理
}

-- 预留的单个快捷键 (不使用命名空间)
M.reserved_keys = {
  ['<leader>e'] = 'File Explorer',
  ['<leader>u'] = 'Undo Tree',
  ['<leader>q'] = 'Quit',
  ['<leader>Q'] = 'Quit All',
}

-- 验证快捷键是否符合命名空间规则
function M.validate_key(key)
  -- 检查是否为预留快捷键
  if M.reserved_keys[key] then
    return true, 'Reserved key'
  end

  -- 检查命名空间格式
  local prefix = key:match '^<leader>([a-zA-Z])'
  if not prefix then
    return true, 'Non-namespaced key'
  end

  -- 检查是否为有效命名空间
  if not M.namespaces[prefix] then
    return false, 'Invalid namespace: ' .. prefix
  end

  return true, 'Valid namespace: ' .. M.namespaces[prefix]
end

-- 获取推荐的快捷键
function M.suggest_key(description)
  local suggestions = {}

  -- 基于描述推荐命名空间
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

-- 显示命名空间规则
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

-- 创建用户命令
vim.api.nvim_create_user_command('ShowKeymapRules', M.show_rules, { desc = 'Show keymap namespace rules' })

return M
