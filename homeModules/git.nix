{ self, ... }: {
  flake.homeModules.git = {
    programs.git = {
      enable = true;
      package = self.packages.git;
    };
  };
}
