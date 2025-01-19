return {
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
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
}
