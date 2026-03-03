{
  description = "House's personal Nix devshells collection";

  inputs = {
    nixpkgs.url  = "github:NixOS/nixpkgs/nixos-25.05";

    # Language environments
    node22.url   = "path:./node22";
    node24.url   = "path:./node24";
    go.url       = "path:./go";
    dotnet8.url  = "path:./dotnet8";
  };

  outputs = { self, nixpkgs, node22, node24, go, dotnet8 }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };

    # Wrap a devShell so it always drops into zsh
    withZsh = shell: pkgs.mkShell {
      buildInputs = (shell.buildInputs or []);
      packages = (shell.packages or []);
      nativeBuildInputs = (shell.nativeBuildInputs or []);
      shellHook = ''
        ${shell.shellHook or ""}
        exec zsh
      '';
    };
  in {
    devShells.${system} = {
      node22  = withZsh node22.devShells.${system}.default;
      node24  = withZsh node24.devShells.${system}.default;
      go      = withZsh go.devShells.${system}.default;
      dotnet8 = withZsh dotnet8.devShells.${system}.default;
    };
  };
}
