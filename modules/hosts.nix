{ hydeik, den, ... }:
{
  den.default.host._.host.includes = [
    hydeik.host-profile
    den._.home-manager
  ];

  den.default.user._.user.includes = [
    hydeik.user-profile
  ];
}
