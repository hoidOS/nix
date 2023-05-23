{
  description = "Neovim Nightly";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = inputs @ { self, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";

      # Neovim nightly overlay
      emacs = inputs.emacs-overlay.overlay;

      # All the pkgs options
      pkgs = import nixpkgs-unstable {
        allowUnfree = true;
        overlays = [ emacs ];
        inherit system;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          emacsUnstable # emacsUnstable or emacsGit for Master
        ];
      };
    };
}
