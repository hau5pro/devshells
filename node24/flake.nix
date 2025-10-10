{
  description = "Node.js 24 dev environment (Linux only, NixOS 25.05)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.mkShell {
      buildInputs = [
        pkgs.nodejs_24
      ];

      shellHook = ''
        echo "🚀 Node 24 shell active"
        node -v
      '';
    };
  };
}
