{ inputs, ... }:
{
  flake-file.inputs = {
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
  };

  hydeik.ai.homeManager =
    { pkgs, ... }:
    {
      home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
        # AI Coding Agents
        claude-code
        claw-code
        codex
        copilot-cli
        gemini-cli
        # AI Assistants
        hermes-agent
        # Claude Code Ecosystems
        ccstatusline
        # Usage Analytics
        ccusage
        ccusage-codex
        # Utilities
        copilot-language-server
      ];
    };
}
