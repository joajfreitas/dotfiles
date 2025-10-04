local M = {}

local function string_contains_prefix(str, prefix)
  return string.sub(str, 0, #prefix) == prefix
end

M.string_remove_prefix = function(str, prefix)
  return string_contains_prefix(str, prefix) and string.sub(str, #prefix + 1) or str
end

M.copy_active_buffer_path = function(register)
  local current_file = M.string_remove_prefix(vim.fn.getreg '%', vim.fn.getcwd() .. '/')

  vim.fn.setreg(register ~= nil and register or '', current_file)
  vim.notify('Copied ' .. current_file, vim.log.levels.INFO)
end

M.copy_active_buffer_abs_path = function(register)
  local abs_path = vim.fn.getreg '%'

  if string_contains_prefix(abs_path, '/') == false then
    abs_path = vim.fn.getcwd() .. '/' .. vim.fn.getreg '%'
  end

  vim.fn.setreg(register ~= nil and register or '', abs_path)
  vim.notify('Copied ' .. abs_path, vim.log.levels.INFO)
end

return M
