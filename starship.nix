{
  lib,
  pkgs,
  ...
}:
with lib; let
  flavor = "macchiato";
in {
  programs.starship = {
    settings =
      {
        # See docs here: https://starship.rs/config/

        palette = "catppuccin_${flavor}";

        directory.fish_style_pwd_dir_length = 1; # turn on fish directory truncation
        directory.truncation_length = 2; # number of directories not to truncate
        gcloud.disabled = true; # annoying to always have on
        hostname.style = "bold green"; # don't like the default
        memory_usage.disabled =
          true; # because it includes cached memory it's reported as full a lot
        shlvl.disabled = false;
        username.style_user = "bold blue"; # don't like the default

        # symbols
        aws.symbol = mkDefault " ";
        battery.full_symbol = mkDefault "󰁹";
        battery.charging_symbol = mkDefault "󰂄";
        battery.discharging_symbol = mkDefault "󰂃";
        battery.unknown_symbol = mkDefault "󰂑";
        battery.empty_symbol = mkDefault "󰂎";
        cmake.symbol = mkDefault "△ ";
        conda.symbol = mkDefault " ";
        crystal.symbol = mkDefault "󰋘 ";
        dart.symbol = mkDefault " ";
        directory.read_only = mkDefault " 󰌾";
        docker_context.symbol = mkDefault " ";
        dotnet.symbol = mkDefault " ";
        elixir.symbol = mkDefault " ";
        elm.symbol = mkDefault " ";
        erlang.symbol = mkDefault " ";
        gcloud.symbol = mkDefault " ";
        git_branch.symbol = mkDefault " ";
        git_commit.tag_symbol = mkDefault " ";
        git_status.format = mkDefault "([$all_status$ahead_behind]($style) )";
        git_status.conflicted = mkDefault "󰅰 ";
        git_status.ahead = mkDefault " ";
        git_status.behind = mkDefault " ";
        git_status.diverged = mkDefault "󰃻 ";
        git_status.untracked = mkDefault " ";
        git_status.stashed = mkDefault " ";
        git_status.modified = mkDefault " ";
        git_status.staged = mkDefault " ";
        git_status.renamed = mkDefault " ";
        git_status.deleted = mkDefault " ";
        golang.symbol = mkDefault " ";
        helm.symbol = mkDefault "⎈ ";
        hg_branch.symbol = mkDefault " ";
        java.symbol = mkDefault " ";
        julia.symbol = mkDefault " ";
        kotlin.symbol = mkDefault " ";
        kubernetes.symbol = mkDefault "☸ ";
        lua.symbol = mkDefault " ";
        memory_usage.symbol = mkDefault "󰍛 ";
        nim.symbol = mkDefault "󰆥 ";
        nix_shell.symbol = mkDefault " ";
        nodejs.symbol = mkDefault "󰎙 ";
        openstack.symbol = mkDefault "󰊓 ";
        package.symbol = mkDefault " ";
        perl.symbol = mkDefault " ";
        php.symbol = mkDefault " ";
        purescript.symbol = mkDefault "<≡> ";
        python.symbol = mkDefault " ";
        ruby.symbol = mkDefault " ";
        rust.symbol = mkDefault " ";
        shlvl.symbol = mkDefault " ";
        status.symbol = mkDefault " ";
        status.not_executable_symbol = mkDefault " ";
        status.not_found_symbol = mkDefault "󰍉 ";
        status.sigint_symbol = mkDefault " ";
        status.signal_symbol = mkDefault " ";
        swift.symbol = mkDefault " ";
        terraform.symbol = mkDefault "𝗧 ";
        vagrant.symbol = mkDefault "𝗩 ";
        zig.symbol = mkDefault " ";
      }
      // builtins.fromTOML (builtins.readFile
        (pkgs.fetchFromGitHub
          {
            owner = "catppuccin";
            repo = "starship";
            rev = "3e3e54410c3189053f4da7a7043261361a1ed1bc"; # Replace with the latest commit hash
            sha256 = "sha256-soEBVlq3ULeiZFAdQYMRFuswIIhI9bclIU8WXjxd7oY=";
          }
          + /palettes/${flavor}.toml));
  };
}
