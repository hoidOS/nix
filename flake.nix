{
  description = "Hoid's flake templates";

  outputs = { self, ... }: {
    templates = {
      rust = {
        path = ./rust;
        description = "Rust Shell";
      };
      # rust-hello = {
      #   path = ./rust-hello-template;
      #   description = "Simple Hello World in Rust";
      # };
    };
  };
}
