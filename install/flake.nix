{
  description = "Nix Flake Install";

  inputs = {
    # Nixpkgs both channels
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      # system check: nix repl: builtins.currentSystem
      system = "x86_64-linux";

      # All the pkgs options
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # $nix run 
      # $nix run .#default $nix run .#nvim
      # $nix build
      packages.${system} = {
        default = pkgs.neovim;
        nvim = pkgs.neovim;
      };

      # nix develop -c $SHELL
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          curl
          git
          lsd
          neovim
          wget
          zsh
        ];

        shellHook = ''
          echo "+++++++++++++++++NIX INSTALL SHELL++++++++++++++++"
          echo "--------------------------------------------------"
        '';
      };
    };
}
