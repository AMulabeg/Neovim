vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "x", '"_x')
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })
keymap.set("n", "<leader><tab>", "<Cmd>bprevious<CR>", { desc = "Go to previous buffer" })
keymap.set("n", "<tab>", "<Cmd>bnext<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<leader>bd", "<Cmd>bdelete<CR>", { desc = "Delete buffer" })
keymap.set("n", "<leader>sm", function()
  if vim.t.maximized then
    vim.cmd("wincmd =")
    vim.t.maximized = false
  else
    vim.cmd("wincmd | | wincmd _")
    vim.t.maximized = true
  end
end, { desc = "Maximize window toggle" })

local function pi_prompt(mode, prompt)
  local cwd = vim.fn.getcwd()
  local args = { "pi-tmux", mode, cwd }
  if prompt and prompt ~= "" then
    table.insert(args, prompt)
  end
  vim.fn.jobstart(args, { detach = true })
end

local function get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line, start_col = start_pos[2], start_pos[3]
  local end_line, end_col = end_pos[2], end_pos[3]
  local lines = vim.fn.getline(start_line, end_line)
  if #lines == 0 then
    return ""
  end
  lines[1] = string.sub(lines[1], start_col)
  lines[#lines] = string.sub(lines[#lines], 1, end_col)
  return table.concat(lines, "\n")
end

vim.api.nvim_create_user_command("Pi", function(opts)
  pi_prompt("popup", table.concat(opts.fargs, " "))
end, { nargs = "*", desc = "Open Pi in a tmux popup" })

vim.api.nvim_create_user_command("PiSplit", function(opts)
  pi_prompt("split", table.concat(opts.fargs, " "))
end, { nargs = "*", desc = "Open Pi in a tmux side pane" })

keymap.set("n", "<leader>ap", function()
  pi_prompt("popup")
end, { desc = "Open Pi popup" })

keymap.set("n", "<leader>aP", function()
  pi_prompt("split")
end, { desc = "Open Pi side pane" })

keymap.set("x", "<leader>ap", function()
  local file = vim.fn.expand("%:p")
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local text = get_visual_selection()
  local prompt = string.format("Review this selection from %s:%d-%d:\n\n```\n%s\n```", file, start_line, end_line, text)
  pi_prompt("popup", prompt)
end, { desc = "Ask Pi about selection" })
