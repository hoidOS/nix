{
  description = "Hoid's flake templates";

  outputs = { self, ... }: {
    templates = {
      rust = {
        path = ./rust;
        description = "Rust Shell";
      };
      neovim = {
        path = ./neovim;
        description = "Neovim Nightly";
      };
    };
  };
}
