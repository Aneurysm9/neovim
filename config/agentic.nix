{pkgs, ...}: {
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      pname = "agentic-nvim";
      version = "2026-02-14";
      src = pkgs.fetchFromGitHub {
        owner = "carlos-algms";
        repo = "agentic.nvim";
        rev = "63fbccc232ea719d0ef9eb74d7e47c2914bc46c5";
        hash = "sha256-jua/vzowXHf7nQY841t/r48nj+GWbGcuNPkWZS32XIA=";
      };
      doCheck = false;
    })
  ];

  extraConfigLua = ''
    require("agentic").setup({
      provider = vim.env.AGENTIC_PROVIDER or "claude-acp",
      acp_providers = {
        ["kiro-acp"] = {
          command = "kiro-cli",
          args = { "acp" },
        },
      },
      window = {
        position = "right",
      },
    })
  '';

  plugins.which-key.settings.spec = [
    {
      __unkeyed-1 = "<leader>a";
      group = "AI Agent";
      icon = "󰚩";
    }
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>at";
      action = "<CMD>lua require('agentic').toggle()<CR>";
      options.desc = "Toggle Chat";
    }
    {
      mode = ["n" "v"];
      key = "<leader>ac";
      action = "<CMD>lua require('agentic').add_selection_or_file_to_context()<CR>";
      options.desc = "Add to Context";
    }
    {
      mode = "n";
      key = "<leader>an";
      action = "<CMD>lua require('agentic').new_session()<CR>";
      options.desc = "New Session";
    }
    {
      mode = "n";
      key = "<leader>ar";
      action = "<CMD>lua require('agentic').restore_session()<CR>";
      options.desc = "Restore Session";
    }
  ];
}
