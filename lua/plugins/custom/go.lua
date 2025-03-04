vim.api.nvim_set_hl(0, "GoComment", { fg = "LightGray", bold = true })
vim.api.nvim_set_hl(0, "GoNoLint", { fg = "NvimLightYellow" })
vim.api.nvim_set_hl(0, "GoDeprecated", { fg = "NvimLightYellow" })
vim.api.nvim_set_hl(0, "GoImplements", { fg = "Gray", bold = true })

local M = {}

local comment_query = function()
  return vim.treesitter.query.parse("go", [[
    (comment) @comment
  ]])
end

local get_type_names = function(root, bufnr)
  local query = vim.treesitter.query.parse("go", [[
    (type_spec
        name: (type_identifier) @name )

    (method_declaration
        name: (field_identifier) @name )

    (function_declaration
        name: (identifier) @name )

    (field_declaration
        name: (field_identifier) @name)

    (const_declaration
      (const_spec
        name: (identifier) @name))
    ]])
  local names = {}
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    local ts_name = query.captures[id]
    if ts_name == "name" then
      names[vim.treesitter.get_node_text(node, bufnr)] = true
    end
  end

  return names
end

local get_root = function(bufnr)
  return vim.treesitter.get_parser(bufnr, "go", {}):parse()[1]:root()
end

local get_start_end = function(node, text, word)
  local line, start_col, _, _ = node:range()
  local word_start_col = string.find(text, word) - 1
  local word_end_col = word_start_col + #word
  return line, start_col + word_start_col, start_col + word_end_col
end

local highlight_godirectives = function(changes, bufnr, node)
  local text = vim.treesitter.get_node_text(node, bufnr)
  local text_split = vim.split(text, " ")
  if #text_split > 0 then
    if string.sub(text_split[1], 1, 5) == "//go:" then
      local line, col_start, col_end = get_start_end(node, text, string.sub(text_split[1], 3))
      table.insert(changes, {
        hl_group = "GoComment",
        line = line,
        col_start = col_start,
        col_end = col_end,
      })
    end

    if string.sub(text_split[1], 1, 9) == "//nolint:" then
      local line, col_start, col_end = get_start_end(node, text, string.sub(text_split[1], 3))
      table.insert(changes, {
        hl_group = "GoNoLint",
        line = line,
        col_start = col_start,
        col_end = col_end,
      })
    end
  end
end

local highlight_godeprecated = function(changes, bufnr, node)
  local text = vim.treesitter.get_node_text(node, bufnr)
  local text_split = vim.split(text, " ")
  if #text_split > 0 then
    if string.sub(text, 1, 14) == "// Deprecated:" then
      local line, _, _, _ = node:range()
      table.insert(changes, {
        hl_group = "GoDeprecated",
        line = line,
        col_start = 0,
        col_end = -1,
      })
    end
  end
end

M.highlight_go_comments = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if vim.bo[bufnr].filetype ~= "go" then
    vim.notify "can only be used in go"
    return
  end

  local root = get_root(bufnr)

  local changes = {}
  local type_names = get_type_names(root, bufnr)
  local comment = comment_query()
  -- for each comment in the file
  for id, node in comment:iter_captures(root, bufnr, 0, -1) do
    local ts_name = comment.captures[id]
    if ts_name == "comment" then
      highlight_godirectives(changes, bufnr, node)
      highlight_godeprecated(changes, bufnr, node)

      local text = vim.treesitter.get_node_text(node, bufnr)
      for word in vim.gsplit(text, " ") do
        if type_names[word] then
          local line, col_start, col_end = get_start_end(node, text, word)
          table.insert(changes, {
            hl_group = "GoComment",
            line = line,
            col_start = col_start,
            col_end = col_end,
          })
        end
      end
    end
  end

  for _, change in ipairs(changes) do
    vim.api.nvim_buf_add_highlight(bufnr, 0, change.hl_group, change.line, change.col_start, change.col_end)
  end
end


return M
