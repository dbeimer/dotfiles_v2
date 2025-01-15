return {
  { "nvim-neotest/neotest-python" },
  { "nvim-neotest/neotest-jest" },
  {
    "nvim-neotest/neotest",
    opts = { adapters = { "neotest-python", "neotest-jest" } },
  },
}
