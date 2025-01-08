{ config, ... }:

{
  config = {
    programs.inori.enable = true;

    nmt.script = ''
      assertPathNotExist ${config.xdg.configHome}/inori/config.toml
    '';
  };
}
