{
  description = "Go dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.mkShell {
      buildInputs = [
        pkgs.go
        pkgs.gopls  # language server for editors
      ];

      shellHook = ''
        echo "🐹 Go dev shell active"
        go version
      '';
    };
  };
}
