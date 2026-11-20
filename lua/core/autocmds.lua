-- Lua buffers: use the smallest indent seen in the file (replaces vim-sleuth for lua)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function(ev)
    local width
    for _, line in ipairs(vim.api.nvim_buf_get_lines(ev.buf, 0, 200, false)) do
      local indent = line:match("^ +%S")
      if indent then
        local n = #indent - 1
        if not width or n < width then width = n end
      end
    end
    if width then
      vim.bo[ev.buf].shiftwidth = width
      vim.bo[ev.buf].tabstop = width
      vim.bo[ev.buf].softtabstop = width
    end
  end,
})
