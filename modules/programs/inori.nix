{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.programs.inori;

  tomlFormat = pkgs.formats.toml { };
in {
  meta.maintainers = [ hm.maintainers.lunahd ];

  options.programs.inori = {
    enable = mkEnableOption "inori";

    package = mkOption {
      type = types.package;
      default = pkgs.inori;
      defaultText = literalExpression "pkgs.inori";
      description = "The inori package to use.";
    };

    settings = mkOption {
      type = tomlFormat.type;
      default = { };
      example = literalExpression ''
        {
          seek_seconds = 10;
          dvorak_keybindings = true;
        }
      '';
      description = ''
        Configuration written to {file}`$XDG_CONFIG_HOME/inori/config.toml`.

        See <https://github.com/eshrh/inori/blob/master/CONFIGURATION.md> for available options.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."inori/config.toml" = mkIf (cfg.settings != { }) {
      source = tomlFormat.generate "config.toml" cfg.settings;
    };
  };
}

