return {
  "andweeb/presence.nvim",
  event = "BufEnter",
  config = function()
    require("presence"):setup({
      neovim_image_text = "Editing image",
      debounce_timeout = 42,
      editing_text = "Editing %s",
      file_explorer_text = "file explorer %s",
      git_commit_text = "Git ",
      plugin_manager_text = "Editing plugins",
      reading_text = "Reading %s",
      workspace_text = "Workspace  %s",
      line_number_text = "Line number %s",
    })
  end,
}
