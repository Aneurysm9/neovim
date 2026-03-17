{
  plugins = {
    bufferline = {
      enable = true;
      settings = {
        options = {
          always_show_bufferline = false;
          buffer_close_icon = "";
        };
      };
    };

    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        current_line_blame_opts = {
          virt_text = true;
          virt_text_pos = "eol";
        };
        signcolumn = true;
        signs = {
          add = {text = "│";};
          change = {text = "│";};
          changedelete = {text = "~";};
          delete = {text = "_";};
          topdelete = {text = "‾";};
          untracked = {text = "┆";};
        };
        watch_gitdir = {follow_files = true;};
      };
    };

    harpoon = {
      enable = true;
    };

    hop.enable = true;
    lazygit.enable = true;
    lualine = {
      enable = true;
      settings.options.globalstatus = true;
    };

    mini = {
      enable = true;
      modules = {
        surround = {};
        indentscope = {
          symbol = "│";
          options = {try_as_border = true;};
        };
      };
    };

    nvim-autopairs.enable = true;
    colorizer.enable = true;
    nvim-tree.enable = true;
    render-markdown.enable = true;
    todo-comments.enable = true;

    treesitter = {
      enable = true;
      folding.enable = false;
      settings.indent.enable = true;
    };

    vim-surround.enable = true;
    web-devicons.enable = true;
  };
}
