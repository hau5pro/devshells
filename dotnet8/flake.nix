{
  description = ".NET 8 dev environment (Linux, NixOS 25.05)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default = let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in pkgs.mkShell {
      buildInputs = [
        pkgs.dotnetCorePackages.sdk_8_0
      ];

      shellHook = ''
        export DOTNET_ROOT="${pkgs.dotnetCorePackages.sdk_8_0}/share/dotnet"
        echo "🧩 .NET 8 dev shell active"
        dotnet --info | head -n 5
      '';
    };
  };
}
