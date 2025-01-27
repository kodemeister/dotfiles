return {
  "chrisgrieser/nvim-various-textobjs",
  opts = {
    keymaps = {
      -- Setup the default key mappings.
      useDefaults = true,

      -- Disable some key mappings that conflict with mini.ai plugin.
      disabledDefaults = { "ae", "ie", "aq", "iq", "a#", "i#", "a_", "i_" }
    }
  }
}
