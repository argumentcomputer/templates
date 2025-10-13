{
  description = "Nix Flake Template";
  outputs = { self }: {
    templates = {
      lean = {
        path = ./lean;
        description = "Lean project template with CI and Nix support";
      };
      rust = {
        path = ./rust;
        description = "Rust project with CI and Nix support";
      };
    };
  };
}
