{
  # Create an aspect that allows unfree packages on dynamic nix classes.
  #
  # usage:
  #   den.aspects.my-laptop.includes
  #     (hydeik.unfree ["cursor"])
  #   ]

  hydeik.unfree = allowed-names: {
    __functor =
      _:
      { class, ... }:
      {
        ${class} =
          { lib, ... }:
          {
            nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-names;
          };
      };
  };
}
