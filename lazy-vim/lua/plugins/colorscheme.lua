return {
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local lackluster = require("lackluster")
      lackluster.setup({
        disable_plugin = {
          bufferline = false,
          cmp = false,
          dashboard = false,
          flash = false,
          git_gutter = false,
          git_signs = false,
          headline = false,
          indentmini = false,
          lazy = false,
          lightbulb = false,
          lsp_config = false,
          mason = false,
          mini_diff = false,
          navic = false,
          noice = false,
          notify = false,
          oil = false,
          rainbow_delimiter = false, -- if you want color-rainbows you should disable this
          scollbar = false,
          telescope = false,
          todo_comments = false,
          tree = false,
          trouble = false,
          which_key = false,
          yanky = false,
        },
        tweak_syntax = {
          comment = lackluster.color.gray4, -- or gray5
        },
        tweak_background = {
          normal = "none",
          telescope = "none",
          menu = lackluster.color.gray3,
          popup = "default",
        },
        tweak_highlight = {
          -- modify @keyword's highlights to be bold and italic
          ["@comment"] = {
            overwrite = false, -- overwrite falsey will extend/update lackluster's defaults (nil also does this)
            italic = true,
          },
        },
      })
    end,
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      options = {
        -- Aquí puedes agregar tus opciones de configuración personalizadas
        transparent = true, -- Si deseas un fondo transparente
        terminal_colors = true, -- Si deseas que los colores del terminal coincidan con el esquema de colores
        styles = {
          comments = "italic", -- Estilo para los comentarios
          keywords = "bold", -- Estilo para las palabras clave
          functions = "italic,bold", -- Estilo para las funciones
        },
      },
    },
    lazy = false,
    priority = 1000,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = {
      transparent_mode = true,
      constrast = "soft",
    },
  },
  { "Everblush/nvim", name = "everblush", opts = {
    transparent_background = true,
  } },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      transparent = true,
    },
  },
}
