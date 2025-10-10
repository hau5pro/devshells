{
  description = "hau5's Nix devShells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    node22.url = "path:./node22";
    node24.url = "path:./node24";
  };

  outputs = { self, nixpkgs, node22, node24 }:
  {
    devShells.x86_64-linux = {
      node22 = node22.devShells.x86_64-linux.default;
      node24 = node24.devShells.x86_64-linux.default;
    };
  };
}
