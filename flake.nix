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
      ref = {
        path = ./ref;
        description = "Reference Template";
      };
      rust = {
        path = ./rust;
        description = "Rust Shell";
      };
    };
  };
}
