{
  description = "Nix Flake Reference";

  inputs = {
    # Nixpkgs both channels
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Neovim Nightly
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # NUR Repo
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      # system check: nix repl: builtins.currentSystem
      system = "x86_64-linux";

      # Neovim nightly overlay
      neovim = inputs.neovim-nightly-overlay.overlay;
      # NUR repo overlay
      nur = inputs.nur.overlay;

      # All the pkgs options
      pkgs = import nixpkgs-unstable {
        inherit system;
        # Allow unfree packages e.g. obsidian
        config.allowUnfree = true;

        # Include all the overlays
        overlays = [ neovim nur ];
      };
    in
    {
      # Checks if the build evals
      checks.${system} = {
        nvim = pkgs.neovim-nightly;
      };
      # $nix run 
      # $nix run .#default $nix run .#nvim
      # $nix build
      packages.${system} = {
        default = pkgs.neovim-nightly;
        nvim = pkgs.neovim-unwrapped;
        ob = pkgs.obsidian;
        # Package from the NUR repo
        # hello = pkgs.nur.repos.mic92.hello-nur;
      };

      # nix run and nix build works here to ?|?
      legacyPackages.${system} = {
        htop = pkgs.htop;
      };

      # nix develop -c $SHELL
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          pkg-config
          openssl
          neovim-nightly # from the overlay. Check master flake for overlayAttrs
        ];
      };
    };
}
