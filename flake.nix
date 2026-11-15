{
  description = "bat configuration flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    wrappers.url = "github:lassulus/wrappers";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    inputs@{ flake-parts, wrappers, ... }:
    flake-parts.lib.mkFlake
      {
        inherit inputs;
      }
      {
        imports = [
          inputs.home-manager.flakeModules.home-manager
        ];
        systems = [ "x86_64-linux" ];

        flake = {
          homeModules = {
          };
        };
        perSystem =
          {
            pkgs,
            #wrappers,
            ...
          }:
          {
            packages = {
              bat =
                (wrappers.wrapperModules.bat.apply {
                  inherit pkgs;
                  "bat-config".path = "bat/bat.conf";
                }).wrapper;

              git =
                (wrappers.wrapperModules.git.apply {
                  inherit pkgs;
                  settings = {
                    user = {
                      name = "TypicalUsername-ai";
                      email = "mati.domalewski@gmail.com";
                    };
                    extraConfig = {
                      init.defaultBranch = "main";
                    };
                    alias = {
                      s = "status";
                      c = "checkout";
                      b = "branch";
                    };
                  };
                }).wrapper;

              btop =
                (wrappers.wrapperModules.btop.apply {
                  inherit pkgs;
                  "btop.conf".path = "btop/btop.conf";
                }).wrapper;

              eza =
                (wrappers.wrapperModules.eza.apply {
                  inherit pkgs;
                  "theme.yml".path = import ./eza/theme.nix { theme = "tokyonight"; };
                }).wrapper;

              zellij =
                (wrappers.wrapperModules.zellij.apply {
                  inherit pkgs;
                  "config.kdl".path = builtins.path { path = ./zellij/config.kdl; };
                  env = {
                    ZELLIJ_CONFIG_DIR = builtins.path { path = ./zellij/layouts; };
                  };
                }).wrapper;
            };
          };
      };

}
