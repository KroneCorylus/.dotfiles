return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  config = function()
    require('telescope').setup {
      defaults = {
        extensions = {
          undo = {
            -- telescope-undo.nvim config, see below
          },
        },
        mappings = {
          i = {
            --['<C-u>'] = false,
            ['<C-x>'] = require('telescope.actions').delete_buffer,
            --['<c-d>'] = false
          },
          n = {
            ['<C-x>'] = require('telescope.actions').delete_buffer
          }
        },
      },
    }
    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require("telescope").load_extension, "undo")
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    "debugloop/telescope-undo.nvim",

    -- Useful for getting pretty icons, but requires a Nerd Font.
    {
      'nvim-tree/nvim-web-devicons',
      enabled = vim.g.have_nerd_font
    },
  },
}
