-- =========================================================
--  Vue (vue_ls) + vtsls 终极配置
-- =========================================================
require('lspconfig')

-- 1. 定义路径
local mason_path = vim.fn.stdpath("data") .. "/mason"
local mason_packages = mason_path .. "/packages"
local mason_bin = mason_path .. "/bin"

-- Vue 插件位置 (给 vtsls 用)
local vue_plugin_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"
-- Vue 可执行文件位置 (给 vue_ls 用，解决"跑不了"的问题)
local vue_language_server_cmd = mason_bin .. "/vue-language-server"

-- =========================================================
-- 配置 vtsls (TypeScript 宿主)
-- =========================================================
local vtsls_config = vim.lsp.config.vtsls or {}

vtsls_config.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

-- 注入 Vue 插件
vtsls_config.settings = {
    vtsls = {
        tsserver = {
            globalPlugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vue_plugin_path,
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                },
            },
        },
    },
}

vim.lsp.config.vtsls = vtsls_config
vim.lsp.enable("vtsls")

-- =========================================================
-- 配置 vue_ls (原 volar)
-- =========================================================
-- 这里我们使用新的名字 "vue_ls" 来消除警告
local vue_config = vim.lsp.config.vue_ls or {}

-- 核心修复：显式指定 cmd，防止 lspconfig 找不到 Mason 安装的 binary
vue_config.cmd = { vue_language_server_cmd, "--stdio" }

vue_config.init_options = {
    vue = {
        hybridMode = true, -- 必须开启，配合 vtsls
    },
}

-- 重新赋值给 vue_ls
vim.lsp.config.vue_ls = vue_config
-- 启动 vue_ls
vim.lsp.enable("vue_ls")


-- =========================================================
-- 其他
-- =========================================================
vim.lsp.enable("tailwindcss")
vim.lsp.enable("emmet_language_server")
