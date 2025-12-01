{ __findFile, ... }:
{
  den.hosts.x86_64-darwin.freya.users.hydeik.aspect = "hide";
  den.hosts.aarch64-darwin.lenneth.users.hydeik.aspect = "ikeno";
  den.hosts.aarch64-darwin.silmeria.users.hydeik.aspect = "ikeno";

  den.aspects = {
    hide.includes = [
      <den/primary-user>
      <my/user>
    ];
    ikeno.includes = [
      <den/primary-user>
      <my/user>
    ];
    freya.includes = [ <hydix/darwin> ];
    lenneth.includes = [ <hydix/darwin> ];
  };
}
