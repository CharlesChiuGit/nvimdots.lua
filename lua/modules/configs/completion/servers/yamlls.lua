-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/yamlls.lua
return {
	single_file_support = true,
	debounce_text_changes = 150,
	settings = {
		-- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
		redhat = { telemetry = { enabled = false } },
		yaml = {
			validate = true,
			format = { enable = false },
			hover = true,
			schemaDownload = { enable = true },
			schemaStore = {
				-- You must disable built-in schemaStore support if you want to use
				-- SchemaStore.nvim and its advanced options like `ignore`.
				enable = false,
				-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
				url = "",
			},
			schemas = require("schemastore").yaml.schemas({
				extra = {
					{
						name = "azure-piplines",
						description = "azure-piplines YAML schema",
						fileMatch = { "azure-pipelines.{yml,yaml}" },
						url = "https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json",
					},
					{
						name = "docker-compose",
						description = "docker-compose YAML schema",
						fileMatch = { "docker-compose*.{yml,yaml}", "compose*.{yml,yaml}" },
						url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
					},
					{
						name = "github-action",
						description = "github-action YAML schema",
						fileMatch = { "*/.github/workflows/*.{yml,yaml}" },
						url = "https://json.schemastore.org/github-workflow.json",
					},
					{
						name = "gh-dash config",
						description = "gh-dash config YAML schema",
						fileMatch = "*/gh-dash/config.yml",
						url = "https://dlvdhr.github.io/gh-dash/configuration/gh-dash/schema.json",
					},
				},
			}),
			-- trace = { server = "debug" },
		},
	},
}
