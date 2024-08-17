return {
  event = "VeryLazy",
  "r-cha/encourage.nvim",
  config = function()
    require("encourage").setup({
      messages = {
        "Great job!",
        "Keep up the good work!",
        "Don't give up!",
        "Success is just around the corner!",
        "Believe in yourself!",
        "You're making progress!",
        "Keep pushing forward!",
        "You're on the right track!",
        "Stay positive and keep going!",
        -- Add your own messages here
      },
      -- Other configuration options...
    })
  end,
}
