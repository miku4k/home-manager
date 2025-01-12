{ config, ... }:

{
  config = {
    programs.inori = {
      enable = true;
      patch_array_keybindings = true;
      settings = {
        seek_seconds = 10;
        dvorak_keybindings = true;
        keybindings = {
          toggle_playpause = [ "p" "<space>" ];
          next_song = [ ">" "C-n" ];
          previous_song = [ "<" "C-p" ];
          seek = "<right>";
          seek_backwards = "<left>";

          up = "k";
          down = "j";
          left = "h";
          right = "l";
          top = [ "g g" "<home>" ];
          bottom = [ "G" "<end>" ];
          quit = [ "<esc>" "q" ];
        };
        theme = {
          status_artist.fg = "#fab387";
          status_album.fg = "#89b4fa";
          status_title = {
            fg = "#cba6f7";
            add_modifier = "BOLD";
          };
          album.fg = "#89b4fa";
          playing.fg = "#a6e3a1";
        };
      };
    };

    nmt.script = ''
      assertFileExists ${config.xdg.configHome}/inori/config.toml
      assertFileContent ${config.xdg.configHome}/inori/config.toml ${
        ./full-config.toml
      }
    '';
  };
}
