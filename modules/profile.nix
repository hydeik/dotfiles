{ hydeik, ... }:
{
  # Dynamic profile routing
  hydeik.host-profile =
    { host }:
    {
      includes = [
        (hydeik.${host.name} or { })
        (hydeik.host-name host)
        hydeik.state-version
      ];
    };

  hydeik.user-profile =
    { host, user }@ctx:
    {
      includes = [
        (hydeik."${user.name}@${host.name}" or { })
        ((hydeik.${host.name}._.common-user-env or (_: { })) ctx)
        ((hydeik.${user.name}._.common-host-env or (_: { })) ctx)
      ];
    };
}
