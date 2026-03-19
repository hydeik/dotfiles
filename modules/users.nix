{ den, ... }:
{
  den.aspects.hide = {
    includes = [
      den.provides.primary-user
      den.aspects.hydeik
    ];
  };

  den.aspects.ikeno = {
    includes = [
      den.provides.primary-user
      den.aspects.hydeik
    ];
  };
}
