return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- theme = '',
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {
          {
            "mode",
            padding = { left = 0, right = 0 },
            separator = { left = "", right = "" },
          },
        },
        lualine_b = { { "branch", icon = "" } },
        lualine_c = {
          {
            "filetype",
            colored = false,
            icon_only = true,
            padding = { left = 2 },
          },
          -- { 'windows', }
          {
            "filename",
            file_status = true, -- Displays file status (readonly status, modified status)
            newfile_status = false,
            path = 1,
            shorting_target = 40, -- Shortens path to leave 40 spaces in the window
            -- for other components. (terrible name, any suggestions?)
            symbols = {
              modified = " ", -- Text to show when the file is modified.
              readonly = " ", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "[No Name]", -- Text to show for unnamed buffers.
              newfile = " ", -- Text to show for new created file before first writting
            },
          },
        },
        lualine_z = {
          { "location", separator = { left = "", right = "" } },
        },
        -- These will be filled later
        lualine_x = {},
        lualine_y = {
          "progress",
        },
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {
          {
            "filetype",
            colored = false,
            icon_only = true,
            padding = { left = 2 },
          },
          { "filename", path = 1 },
        },
        lualine_x = {},
      },
    },
  },
}
