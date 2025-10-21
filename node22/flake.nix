{
  description = "Node.js 22 dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.mkShell {
      buildInputs = [ pkgs.nodejs_22 pkgs.yarn ];
      shellHook = ''
        echo "🐢 Node 22 shell active"
        echo "Node: $(node -v)"
        echo "Yarn: $(yarn -v)"
      '';
    };
  };
}
