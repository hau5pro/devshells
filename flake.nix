{
  description = "House's personal Nix devshells collection";

  inputs = {
    nixpkgs.url  = "github:NixOS/nixpkgs/nixos-25.05";

    # Language environments
    node22.url   = "path:./node22";
    node24.url   = "path:./node24";
    go.url       = "path:./go";
    dotnet8.url  = "path:./dotnet8";

    # AI tools
    claude.url   = "path:./ai";
  };

  outputs = { self, nixpkgs, node22, node24, go, dotnet8, claude }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    # Helper: merge two devShells manually
    mergeShells = a: b:
      pkgs.mkShell {
        buildInputs = (a.buildInputs or []) ++ (b.buildInputs or []);
        packages = (a.packages or []) ++ (b.packages or []);
        nativeBuildInputs = (a.nativeBuildInputs or []) ++ (b.nativeBuildInputs or []);
        shellHook = ''
          ${a.shellHook or ""}
          ${b.shellHook or ""}
        '';
      };
  in {
    devShells.${system} = {
      claude  = claude.devShells.${system}.default;

      node22  = mergeShells node22.devShells.${system}.default  claude.devShells.${system}.default;
      node24  = mergeShells node24.devShells.${system}.default  claude.devShells.${system}.default;
      go      = mergeShells go.devShells.${system}.default      claude.devShells.${system}.default;
      dotnet8 = mergeShells dotnet8.devShells.${system}.default claude.devShells.${system}.default;
    };
  };
}
