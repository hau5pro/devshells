{
  description = "Claude CLI devshell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.mkShell {
      name = "claude-shell";
      buildInputs = [
        pkgs.nodejs_22
      ];

      shellHook = ''
        echo "🤖 Claude shell active"

        # If Anthropic publishes a binary later, replace this with fetchurl+install.
        # For now, install via npm (global inside this shell only)
        if ! command -v claude &>/dev/null; then
          npm install -g @anthropic-ai/claude-code
        fi
      '';
    };
  };
}
