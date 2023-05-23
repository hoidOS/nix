{
  description = "Neovim Nightly";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs @ { self, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";

      # Neovim nightly overlay
      neovim = inputs.neovim-nightly-overlay.overlay;

      # All the pkgs options
      pkgs = import nixpkgs-unstable {
        allowUnfree = true;
        overlays = [ neovim ];
        inherit system;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          neovim-nightly # from the overlay. Check master flake for overlayAttrs
        ];
      };
    };
}
