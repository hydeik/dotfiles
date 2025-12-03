{ __findFile, ... }:
{
  den.hosts.x86_64-darwin.freya.users.hide.aspect = "hide";
  den.hosts.aarch64-darwin.lenneth.users.ikeno.aspect = "ikeno";
  den.hosts.aarch64-darwin.silmeria.users.ikeno.aspect = "ikeno";

  den.aspects = {
    hide.includes = [
      <my/user>
    ];
    ikeno.includes = [
      <my/user>
    ];
    freya.includes = [
      <hydix/darwin>
    ];
    lenneth.includes = [
      <hydix/darwin>
    ];
  };
}
