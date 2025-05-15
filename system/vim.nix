{
  inputs,
  hostname,
  username,
  system,
  unstablePkgs,
  ...
}:
# Add unstablePkgs here
{
  imports = [ inputs.nvf.nixosModules.default ];

  programs.nvf = {
    enable = true;

    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lineNumberMode = "number";
      vim.lsp = {
        enable = true;
        inlayHints.enable = true;
      };

      vim.theme = {
        name = "catppuccin";
        enable = true;
        style = "frappe";
      };
      vim.formatter.conform-nvim.enable = true;
      vim.filetree.nvimTree.enable = true;

      vim.options = {
        tabstop = 2;
      };

      vim.languages.enableFormat = true;
      vim.languages.enableTreesitter = true;

      vim.languages.nix.enable = true;
      vim.languages.html.enable = true;
      vim.languages.ruby = {
        enable = true;
        lsp.server = "rubylsp";
      };

      vim.statusline.lualine.enable = true;
      vim.binds.whichKey.enable = true;

      vim.autocomplete = {
        nvim-cmp.enable = true;
      };
      vim.telescope.enable = true;
    };
  };
}
