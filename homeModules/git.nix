{ inputs, ... }: {
  flake.homeModules.git = inputs.flake-parts.lib.moduleWithSystem (
    { config, ... }:
    _: {
      programs.git = {
        enable = true;
        package = config.packages.git;
      };
    }
  );
}
