{
  description = "Nix Flake Options";

  # Get all the inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";

      # Neovim nightly overlay
      neovim = inputs.neovim-nightly-overlay.overlay;

      # All the pkgs options
      pkgs = import nixpkgs-unstable {
        inherit system;
        allowUnfree = true;
        overlays = [ neovim ];


      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          pkg-config
          openssl
          neovim-nightly # from the overlay. Check master flake for overlayAttrs
        ];
      };
    };
}
