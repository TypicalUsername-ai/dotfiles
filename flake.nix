{
  description = "bat configuration flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    wrappers.url = "github:lassulus/wrappers";
    home-manager.url = "github:nix-community/home-manager";
    import-tree.url = "github:vic/import-tree";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake
      {
        inherit inputs;
      }
      {
        imports = [
          inputs.home-manager.flakeModules.home-manager
          (inputs.import-tree ./homeModules)
          ./packages.nix
        ];
        systems = [ "x86_64-linux" ];
      };
}
