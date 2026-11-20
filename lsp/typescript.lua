return {
    cmd = { "tsc", "--lsp", "--stdio" },
    root_markers = { "tsconfig.json", "package.json", ".tsconfig", ".git" },
    filetypes = { "typescript", "javascript" }
}
