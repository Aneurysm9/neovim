{pkgs, ...}: {
  plugins = {
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
    dap = {
      enable = true;
      extensions = {
      };

      adapters = {
        executables = {lldb = {command = "${pkgs.lldb_19}/bin/lldb-dap";};};
      };
    };
  };
}
