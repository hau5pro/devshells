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
    lib = nixpkgs.lib;

    # helper: merge Claude into any shell
    withClaude = shell: lib.mkMerge [ shell claude.devShells.${system}.default ];
  in {
    devShells.${system} = {
      # keep Claude standalone too
      claude  = claude.devShells.${system}.default;

      # merge Claude into all other shells
      node22  = withClaude node22.devShells.${system}.default;
      node24  = withClaude node24.devShells.${system}.default;
      go      = withClaude go.devShells.${system}.default;
      dotnet8 = withClaude dotnet8.devShells.${system}.default;
    };
  };
}
