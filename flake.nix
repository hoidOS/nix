{
  description = "Hoid's flake templates";

  outputs = { self, ... }: {
    templates = {
      emacs = {
        path = ./emacs;
        description = "Emacs Unstable";
      };
      neovim = {
        path = ./neovim;
        description = "Neovim Nightly";
      };
      rust = {
        path = ./rust;
        description = "Rust Shell";
      };
    };
  };
}
