{
  hydix.hostname =
    { host, ... }:
    {
      ${host.class}.networking.hostName = host.hostName;
    };
}
