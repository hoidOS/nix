{
  description = "Ruby development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f { inherit system; });
    in
    {
      devShells = forAllSystems (
        { system }:
        let
          pkgs = import nixpkgs { inherit system; };
          # rubyEnv = pkgs.ruby_3_3.withPackages (ps: with ps; [ bundler ]);
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              # rubyEnv  # Ruby 3.3 with Bundler
              pkg-config
              libyaml.dev
              openssl.dev # For crypto-related gems
              zlib.dev # For compression gems
              libxml2.dev # For XML parsing gems like nokogiri
              libxslt.dev
              libffi.dev
              # Add more as needed, e.g., postgresql for DB
            ];
            shellHook = ''
              echo "Ruby dev environment loaded with version $(ruby -v)"
            '';
          };
        }
      );
    };
}
