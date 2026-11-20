return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", "lazy-lock.json" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
                checkThirdParty = false,
            },
            telemetry = { enable = false },
            completion = {
                callSnippet = "Replace"
            }
        }
    }
}
