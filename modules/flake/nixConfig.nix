{
  flake-file = {
    description = "Hidekazu Ikeno (hydeik)'s dotfile powered by Nix";

    # A set of nix.conf options to be set when evaluating any part of a flake.
    nixConfig = {
      # If set to true, `builtins.warn` will throw an error when logging a warning.
      abort-on-warn = true;
      # Disallow import from derivation
      allow-import-from-derivation = false;
    };
  };
}
