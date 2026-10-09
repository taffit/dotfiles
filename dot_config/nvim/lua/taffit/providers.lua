local data = vim.fn.stdpath("data")
local sep = package.config:sub(1, 1)

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local python3_host = table.concat({ data, "python3-provider", "bin", "python" }, sep)

if vim.fn.has("win32") == 1 then
  python3_host = table.concat({ data, "python3-provider", "Scripts", "python.exe" }, sep)
end

local node_host = table.concat({ data, "node-host", "cli.js" }, sep)
if vim.fn.filereadable(node_host) ~= 1 and vim.fn.executable("npm") == 1 then
  local npm_prefix = vim.fn.systemlist({ "npm", "config", "get", "prefix" })[1]
  if vim.v.shell_error == 0 and npm_prefix and npm_prefix ~= "" then
    local candidates = {
      table.concat({ npm_prefix, "lib", "node_modules", "neovim", "bin", "cli.js" }, sep),
      table.concat({ npm_prefix, "node_modules", "neovim", "bin", "cli.js" }, sep),
    }
    for _, candidate in ipairs(candidates) do
      if vim.fn.filereadable(candidate) == 1 then
        node_host = candidate
        break
      end
    end
  end
end

if vim.fn.executable(python3_host) == 1 then
  vim.g.python3_host_prog = python3_host
end

if node_host ~= "" and vim.fn.filereadable(node_host) == 1 then
  vim.g.node_host_prog = node_host
end
