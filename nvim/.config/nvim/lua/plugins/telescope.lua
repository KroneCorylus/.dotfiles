return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  opts = {
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
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    "debugloop/telescope-undo.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
}
