return {
  "echasnovski/mini.ai",
  opts = function()
    return {
      custom_textobjects = {
        -- Define custom text objects "ae" / "ie" to select the entire buffer.
        e = require("mini.extra").gen_ai_spec.buffer()
      }
    }
  end
}
