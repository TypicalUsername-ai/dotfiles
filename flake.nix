{
  description = "bat configuration flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    wrappers.url = "github:lassulus/wrappers";

  };

  outputs =
    inputs@{ flake-parts, wrappers, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
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
          };
        };
    };

}
