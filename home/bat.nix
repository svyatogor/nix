{ pkgs, ... }: {
  enable = true;
  config = {
    pager = "less -R";
    style = "numbers";
  };
}
