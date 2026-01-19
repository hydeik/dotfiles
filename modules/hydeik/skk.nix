{ inputs, ... }:
let
  flake-file.inputs = {
    skk-dev-dict = {
      url = "github:skk-dev/dict";
      flake = false;
    };
    yaskkserv2-service = {
      url = "github:ttak0422/yaskkserv2-service";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };

  skk-dictionaries = [
    "SKK-JISYO.L"
    "SKK-JISYO.jinmei"
    "SKK-JISYO.geo"
    "SKK-JISYO.station"
    "SKK-JISYO.propernoun"
    "SKK-JISYO.law"
    "SKK-JISYO.okinawa"
    "SKK-JISYO.china_taiwan"
    "SKK-JISYO.assoc"
    "SKK-JISYO.edict"
    "zipcode/SKK-JISYO.zipcode"
    "zipcode/SKK-JISYO.office.zipcode"
    "SKK-JISYO.JIS2"
    "SKK-JISYO.JIS3_4"
    "SKK-JISYO.JIS2004"
    "SKK-JISYO.itaiji"
    "SKK-JISYO.itaiji.JIS3_4"
  ];

  hydeik.skk.darwin =
    { pkgs, ... }:
    let
      inherit (inputs.yaskkserv2-service.packages.${pkgs.stdenvNoCC.hostPlatform.system}) yaskkserv2;
    in
    {
      imports = [
        inputs.yaskkserv2-service.darwinModules.default
        {
          nixpkgs.overlays = [
            (final: prev: {
              yaskkserv2-dictionary = prev.stdenvNoCC.mkDerivation {
                name = "yaskkserv2-dictionary";
                src = inputs.skk-dev-dict;
                # ignoer Makefile
                dontBuild = true;
                installPhase = ''
                  mkdir $out
                  ${yaskkserv2}/bin/yaskkserv2_make_dictionary --dictionary-filename=$out/dictionary.yaskkserv2 ${builtins.concatStringsSep " " skk-dictionaries}
                '';
              };
            })
          ];
        }
      ];

      services.yaskkserv2 = {
        enable = true;
        dictionary = "${pkgs.yaskkserv2-dictionary}/dictionary.yaskkserv2";
      };
    };
in
{
  inherit flake-file;
  inherit hydeik;
}
