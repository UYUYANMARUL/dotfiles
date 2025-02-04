{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs,nix-homebrew }:
  let
    configuration = { pkgs,config, ... }: {

        nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs;[
            zsh
            fzf
            zinit
            vim
            neovim
            mkalias
            tmux
            zellij
            kitty
            alacritty
            oh-my-posh
            zoxide
            stow
            lsd
            git
            lazygit
            curl
            syncthing
            obsidian
            mos
            oh-my-zsh
          karabiner-elements
            # kanata
          elixir
          elixir-ls
          rustup
          gcc
          ghc
          llvm
        ];

        homebrew = {
          enable=true;
          casks = [];
        };


system.activationScripts.applications.text = let
  env = pkgs.buildEnv {
    name = "system-applications";
    paths = config.environment.systemPackages;
    pathsToLink = "/Applications";
  };
in
  pkgs.lib.mkForce ''
  # Set up applications.
  echo "setting up /Applications..." >&2
  rm -rf /Applications/Nix\ Apps
  mkdir -p /Applications/Nix\ Apps
  find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
  while read src; do
    app_name=$(basename "$src")
    echo "copying $src" >&2
    ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
  done
      '';

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;


  # services.kanata = {
  #   enable = true;
  #   keyboards = {
  #     internalKeyboard = {
  #       devices = [
  #         "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
  #       ];
  #       extraDefCfg = "process-unmapped-keys yes";
  #       config = ''
  #       (defsrc
  #        caps a s d f h j k l
  #       )
  #       (defvar
  #        tap-time 150
  #        hold-time 200
  #       )
  #       (defalias
  #        caps (tap-hold 100 100 esc lctl)
  #        a (tap-hold $tap-time $hold-time a lmet)
  #        s (tap-hold $tap-time $hold-time s lalt)
  #        d (tap-hold $tap-time $hold-time d lsft)
  #        f (tap-hold $tap-time $hold-time f lctl)
  #        h (tap-hold $tap-time $hold-time h rctl)
  #        j (tap-hold $tap-time $hold-time j rsft)
  #        k (tap-hold $tap-time $hold-time k ralt)
  #        l (tap-hold $tap-time $hold-time l rmet)
  #       )
  #
  #       (deflayer base
  #        @caps @a  @s  @d  @f  @h  @j  @k  @l
  #       )
  #       '';
  #     };
  #   };
  # };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
      modules = [ configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user="ataberkcekic";
              autoMigrate = true;
            };
          }
        ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mac".pkgs;
  };

#darwin-rebuild switch --flake ~/dotfiles/.config/nix#mac
}
