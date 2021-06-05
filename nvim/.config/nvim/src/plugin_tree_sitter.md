# Tree Sitter Setup

[Plugins](plugins.md)

[https://github.com/nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## Setup

	lua <<EOF
```lua
require'nvim-treesitter.configs'.setup {
ensure_installed = {"rust", "python"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",

        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",

        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",

        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
  },
}

```
	EOF
