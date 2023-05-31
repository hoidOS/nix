{
  description = "Hoid's flake templates";

  outputs = { self, ... }: {
    templates = {
      c = {
        path = ./c;
        description = "C Env";
      };
      emacs = {
        path = ./emacs;
        description = "Emacs Unstable";
      };
      install = {
        path = ./install;
        description = "Install Flake";
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
