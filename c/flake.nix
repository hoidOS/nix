{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs, ... }:
    let
      # Define systems for both Linux and Darwin (macOS)
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      # Helper function for each system
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
          }
        );

    in
    {
      packages = forAllSystems (
        { pkgs, ... }:
        {
          # Call default.nix for each system
          myPackage = pkgs.callPackage ./. { };
          default = self.packages.${pkgs.system}.myPackage;
        }
      );
    };
}
