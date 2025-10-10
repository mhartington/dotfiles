local capabilities = require("mh.lsp")
local jdtls = require("jdtls")

local jdtls_path = vim.fn.expand("$MASON/packages/jdtls/")
local lombok_path = jdtls_path .. "lombok.jar"
local jdtls_jar = jdtls_path .. "plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar"
local config_path = jdtls_path .. "config_" .. "mac"
local workspace = vim.fn.expand("$HOME" .. "/code/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"))

local cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-javaagent:" .. lombok_path,
  "-Xmx4g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens",
  "java.base/java.util=ALL-UNNAMED",
  "--add-opens",
  "java.base/java.lang=ALL-UNNAMED",
  "-jar",
  jdtls_jar,
  "-configuration",
  config_path,
  "-data",
  workspace,
}

local settings = {
  java = {
    -- Enable code formatting
    format = {
      enabled = true,
      settings = {
        url = vim.fn.stdpath("config") .. "/lang_servers/intellij-java-google-style.xml",
        profile = "GoogleStyle",
      },
    },
    eclipse = { downloadSource = true },
    maven = { downloadSources = true },
    signatureHelp = { enabled = true },
    contentProvider = { preferred = "fernflower" },
    -- saveActions = { organizeImports = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      filteredTypes = { "com.sun.*", "io.micrometer.shaded.*", "java.awt.*", "jdk.*", "sun.*" },
      importOrder = { "java", "jakarta", "javax", "com", "org" },
    },
    sources = {
      organizeImports = { starThreshold = 9999, staticThreshold = 9999 },
    },
    codeGeneration = {
      toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
      hashCodeEquals = { useJava7Objects = true },
      useBlocks = true,
    },
    configuration = { updateBuildConfiguration = "interactive" },
    referencesCodeLens = { enabled = true },
    inlayHints = { parameterNames = { enabled = "all" } },
  },
}

jdtls.start_or_attach({
  cmd = cmd,
  root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  capabilities = capabilities,
  settings = settings,
  on_attach = function()
    vim.lsp.codelens.refresh()
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.java" },
      callback = function()
        local _, _ = pcall(vim.lsp.codelens.refresh)
      end,
    })
  end,
  handlers = {
    ["language/status"] = function() end,
  },
})
