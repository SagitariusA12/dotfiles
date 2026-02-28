-- lua/plugins/init.lua
-- Agrupa automaticamente todos os módulos em `lua/plugins/*.lua`
local plugins = {}

local config_path = vim.fn.stdpath("config") .. "/lua/plugins"
local files = vim.fn.globpath(config_path, "*.lua", false, true)

for _, f in ipairs(files) do
    local mod = f:match("/lua/(.+)%.lua$")
    if mod and mod ~= "plugins.init" then
        local ok, rv = pcall(require, mod:gsub("/", "."))
        if ok and rv ~= nil then
            if type(rv) == "table" then
                -- Se o módulo retornar uma lista de specs, mescla-a
                local is_list = false
                for i = 1, #rv do
                    if rv[i] ~= nil then
                        is_list = true
                        break
                    end
                end
                if is_list then
                    for _, v in ipairs(rv) do
                        table.insert(plugins, v)
                    end
                else
                    table.insert(plugins, rv)
                end
            end
        end
    end
end

return plugins
