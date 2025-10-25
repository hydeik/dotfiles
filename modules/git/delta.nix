{
  flake.modules.homeManager.base = {
    programs = {
      delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          line-numbers = true;
          navigate = true;
          side-by-side = true;
        };
      };
    };
  };
}
