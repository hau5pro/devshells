{
  description = "Claude CLI devshell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.mkShell {
      name = "claude-shell";
      buildInputs = [ pkgs.nodejs_22 ];

      shellHook = ''
        echo "🤖 Claude shell active"

        # ensure npm installs to a user-writable prefix
        export NPM_CONFIG_PREFIX="$HOME/.npm-global"
        export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"

        # install Claude CLI if not already present
        if ! command -v claude >/dev/null 2>&1; then
          echo "Installing Claude CLI..."
          mkdir -p "$NPM_CONFIG_PREFIX"
          npm install -g @anthropic-ai/claude-code
        fi

        echo "Claude: $(claude -v)"
      '';
    };
  };
}
