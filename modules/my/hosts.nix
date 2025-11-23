{ __findFile, ... }:
{
  den.hosts.x86_64-darwin.freya.users.hydeik.aspect = "hide";
  den.hosts.aarch64-darwin.freya.users.hydeik.aspect = "ikeno";

  den.aspects = {
    hide.includes = [ <my/user> ];
    ikeno.includes = [ <my/user> ];
  };
}
