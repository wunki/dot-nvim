local function lsp_restart(bufnr)
  local api, lsp = vim.api, vim.lsp
  bufnr = bufnr or api.nvim_get_current_buf()
  local clients = lsp.get_clients { bufnr = bufnr }

  if #clients == 0 then
    vim.cmd 'edit'
    return
  end

  for _, c in ipairs(clients) do
    local attached_buffers = vim.tbl_keys(c.attached_buffers or {})
    local cfg = c.config
    lsp.stop_client(c.id, true)
    vim.defer_fn(function()
      local new_id
      for i, b in ipairs(attached_buffers) do
        if i == 1 then
          new_id = lsp.start(cfg, { bufnr = b })
        elseif new_id then
          lsp.buf_attach_client(b, new_id)
        end
      end
      if new_id then
        vim.notify(string.format("LSP '%s' restarted", cfg.name or c.name))
      else
        vim.notify(string.format("Failed to restart LSP '%s'", cfg.name or c.name), vim.log.levels.ERROR)
      end
    end, 300)
  end
end

vim.keymap.set('n', '<leader>lr', function()
  lsp_restart(0)
end, { desc = 'LSP: Restart clients' })
