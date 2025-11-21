{
  description = "Google ADK Lab Development Environment using Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Provide dev shells for multiple systems so you can choose at
      # `nix develop .#devShells.<system>.default` without editing this file.
      # Add common systems; include macOS x86_64 & zsh support for users & CI
      supportedSystems = [ "aarch64-linux" "aarch64-darwin" "x86_64-linux" "x86_64-darwin" ];

      mkDevShellFor = system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in pkgs.mkShell {
        # 1. The Tools we need (Nix provides these)
        buildInputs = with pkgs; [
          python311       # The interpreter
          uv              # The package manager
          stdenv.cc.cc.lib # C libraries often needed for AI/ML wheels
          zlib            # Common dependency
          zsh             # Provide zsh inside the dev shell for convenience
          github-cli      # GitHub CLI for repository management
        ];

        # 2. The Environment Hook
        # This tells Linux where to find the libraries Nix downloaded,
        # so 'uv' installed packages can find them.
        shellHook = ''
          export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib:$LD_LIBRARY_PATH
          echo "🧪 Capstone Lab Environment Loaded"
          echo "Python: $(python --version)"
          echo "uv: $(uv --version)"
        '';
      };

    # Convert the list of systems into an attribute set of devShells
    # (devShells.${system}.default) so flakes tooling can find them.
    in {
      devShells = builtins.listToAttrs (map (s: { name = s; value = { default = mkDevShellFor s; }; }) supportedSystems);
    };
}