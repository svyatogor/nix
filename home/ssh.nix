{ ... }:
{
  enable = true;
  forwardAgent = true;
  includes = [
    "~/.orbstack/ssh/config"
    "~/.ssh/hosts.config"
  ];
  matchBlocks = {
    "*" = {
      identityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
    };
  };
}
