{
  inputs,
  pkgs,
  unstablePkgs,
  ...
}:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  environment.systemPackages = with pkgs; [
    # nixpkgs-unstable.legacyPackages.${pkgs.system}.talosctl

    fastfetch
    btop
    diffr # Modern Unix `diff`
    difftastic # Modern Unix `diff`
    du-dust # Modern Unix `du`
    dua # Modern Unix `du`
    duf # Modern Unix `df`
    entr # Modern Unix `watch`
    ripgrep
    lima
    dnsmasq
    traefik
    nixpkgs-fmt
    fd
    neovim
    nixd
    nixfmt-rfc-style
    jq
    ngrok
    _1password-cli
    zellij
    inetutils
    wget
    expect
    lazydocker
    curlie
    gnupg
    gh
    devenv
    agenix-cli
  ];
}
