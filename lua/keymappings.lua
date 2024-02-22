local function register_mappings(mappings, default_options)
  for mode, mode_mappings in pairs(mappings) do
    for _, mapping in pairs(mode_mappings) do
      local options = #mapping == 3 and table.remove(mapping) or default_options
      local prefix, cmd = unpack(mapping)
      local success, message = pcall(vim.keymap.set, mode, prefix, cmd, options)
      if not success then
        print(string.format("Error while setting the mapping [%s, %s] : %s", prefix, cmd, message))
      end
    end
  end
end

local function telescope_find_hidden_files()
  require("telescope.builtin").find_files({ hidden = true })
end

local function telescope_global_search()
  require("telescope.builtin").live_grep()
end

local border_options = { float = { border = "rounded" } }

local mappings = {
  i = {
    { "kk", "<ESC>" },
    { "jj", "<ESC>" },
    { "jk", "<ESC>" },
    { "<C-'>", "``<esc>i" },
  },

  n = {
    { "<C-Up>", "<cmd>resize -2<CR>", { silent = true } },
    { "<leader>j", ":w<CR>", { silent = true } },
    { "<leader>m", ":bd<CR>", { silent = true } },
    { "<C-Down>", "<cmd>resize +2<CR>", { silent = true } },
    { "<C-Left>", "<cmd>vertical resize -2<CR>", { silent = true } },
    { "<C-Right>", "<cmd>vertical resize +2<CR>", { silent = true } },
    { "<C-p>", telescope_find_hidden_files },
    { "<C-o>", telescope_global_search },
    { "<esc>", "<cmd>noh<cr><esc>" },
    { "Y", "y$" },
    { "K", vim.lsp.buf.hover },
    { "[q", ":cprev<CR>" },
    { "]q", ":cnext<CR>" },
    {
      "[d",
      function()
        vim.diagnostic.goto_prev(border_options)
      end,
    },
    {
      "]d",
      function()
        vim.diagnostic.goto_next(border_options)
      end,
    },
    { "gD", vim.lsp.buf.declaration },
    { "gk", vim.lsp.buf.hover },
    { "gd", vim.lsp.buf.definition },
    { "gr", vim.lsp.buf.references },
    { "gi", vim.lsp.buf.implementation },
    { "H", "<cmd>BufferLineCyclePrev<CR>" },
    { "L", "<cmd>BufferLineCycleNext<CR>" },
    { "<C-d>", "<C-d>zz" },
    { "<C-u>", "<C-u>zz" },
    { "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true } },
    { "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true } },
    { "gx", '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>' },
    { "<leader>gg", ":Gitsigns preview_hunk<CR>" },
    { "<C-h>", "<cmd> TmuxNavigateLeft<CR>" },
    { "<C-l>", "<cmd> TmuxNavigateRight<CR>" },
    { "<C-j>", "<cmd> TmuxNavigateDown<CR>" },
    { "<C-k>", "<cmd> TmuxNavigateUp<CR>" },
  },
  t = {
    { "<Esc>", [[ <C-\><C-n> ]] },
    { "jj", [[ <C-\><C-n> ]] },
  },
  v = {
    { "<", "<gv" },
    { ">", ">gv" },
    { "J", "<cmd>m '>+1<CR>gv=gv" },
    { "K", "<cmd>m '<-2<CR>gv=gv" },
  },
  x = {
    { "<leader>p", '"_dP' },
  },
}

register_mappings(mappings, { silent = true, noremap = true })

-- vim.cmd("nnoremap S :%s/")
