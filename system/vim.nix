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
  imports = [inputs.nvf.nixosModules.default];

  programs.nvf = {
    enable = true;

    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lineNumberMode = "number";
      vim.lsp = {
        enable = true;
        inlayHints.enable = true;
        formatOnSave = true;
      };

      vim.theme = {
        name = "catppuccin";
        enable = true;
        style = "frappe";
      };
      vim.formatter.conform-nvim = {
        enable = true;
      };
      vim.filetree.nvimTree = {
        enable = true;
        mappings.toggle = "<leader>b";
        openOnSetup = false;
        setupOpts = {
          filters = {
            git_ignored = true;
            dotfiles = true;
          };
          git = {
            enable = true;
          };
          modified.enable = true;
        };
      };
      vim.git = {
        enable = true;
      };

      vim.options = {
        tabstop = 2;
        shiftwidth = 2;
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
