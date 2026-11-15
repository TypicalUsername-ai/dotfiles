{
  inputs,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        bat =
          (inputs.wrappers.wrapperModules.bat.apply {
            inherit pkgs;
            "bat-config".path = "bat/bat.conf";
          }).wrapper;

        git =
          (inputs.wrappers.wrapperModules.git.apply {
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
          (inputs.wrappers.wrapperModules.btop.apply {
            inherit pkgs;
            "btop.conf".path = "btop/btop.conf";
          }).wrapper;

        eza =
          (inputs.wrappers.wrapperModules.eza.apply {
            inherit pkgs;
            "theme.yml".path = import ./eza/theme.nix { theme = "tokyonight"; };
          }).wrapper;

        zellij =
          (inputs.wrappers.wrapperModules.zellij.apply {
            inherit pkgs;
            "config.kdl".path = builtins.path { path = ./zellij/config.kdl; };
            env = {
              ZELLIJ_CONFIG_DIR = builtins.path { path = ./zellij/layouts; };
            };
          }).wrapper;
      };
    };
}
