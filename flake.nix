{
  description = "Google ADK Lab Development Environment using Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Explicitly using your architecture
      system = "aarch64-darwin"; # For Apple Silicon macOS
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        # 1. The Tools we need (Nix provides these)
        buildInputs = with pkgs; [
          python311       # The interpreter
          uv              # The package manager
          stdenv.cc.cc.lib # C libraries often needed for AI/ML wheels
          zlib            # Common dependency
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
    };
}