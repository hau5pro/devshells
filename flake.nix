{
  description = "House's personal Nix devshells collection";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    node22.url = "path:./node22";
    node24.url = "path:./node24";
    go.url     = "path:./go";
    dotnet8.url = "path:./dotnet8";
  };

  outputs = { self, nixpkgs, node22, node24, go, dotnet8 }:
  {
    devShells.x86_64-linux = {
      node22 = node22.devShells.x86_64-linux.default;
      node24 = node24.devShells.x86_64-linux.default;
      go     = go.devShells.x86_64-linux.default;
      dotnet8 = dotnet8.devShells.x86_64-linux.default;
    };
  };
}
