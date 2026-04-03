-- jdtls requires Java 21 to run itself
vim.env.JAVA_HOME = "/usr/lib/jvm/java-21-openjdk"

local jdtls = require("jdtls")

-- Resolve project name for workspace directory
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

-- Path to mason-installed jdtls
local mason_jdtls = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

local config = {
    cmd = {
        vim.env.JAVA_HOME .. "/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob(mason_jdtls .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        mason_jdtls .. "/config_linux",
        "-data",
        workspace_dir,
    },

    root_dir = vim.fs.root(0, { ".git", "gradlew", "mvnw", "pom.xml", "build.gradle", "settings.gradle" }),

    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-11",
                        path = "/usr/lib/jvm/java-11-openjdk",
                    },
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk",
                    },
                    {
                        name = "JavaSE-21",
                        path = "/usr/lib/jvm/java-21-openjdk",
                    },
                },
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
            },
        },
        signatureHelp = {
            enabled = true,
        },
        completion = {
            favoriteStaticMembers = {
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*",
                "org.mockito.Mockito.*",
                "org.mockito.ArgumentMatchers.*",
                "org.mockito.BDDMockito.*",
            },
        },
        contentProvider = {
            preferred = "fernflower",
        },
        extendedClientCapabilities = {
            progressReportProvider = false,
            classFileContentsSupport = true,
            generateToStringPromptSupport = true,
            hashCodeEqualsPromptSupport = true,
            advancedIntroduceParameterRefactoringSupport = true,
            advancedExtractLocalSupport = true,
        },
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },

    init_options = {
        bundles = {},
    },
}


jdtls.start_or_attach(config)
