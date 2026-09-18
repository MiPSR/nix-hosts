{
  description = "blablabla wip wip wip blablabla mec si tu lis ça tu es fou";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";

      hostDirs = nixpkgs.lib.filterAttrs
        (name: type: type == "directory" && !nixpkgs.lib.hasPrefix "." name)
        (builtins.readDir ./hosts);

      mkHost = name: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/${name} ];
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs (name: _: mkHost name) hostDirs;

      nixosModules = nixpkgs.lib.mapAttrs (name: _: ./hosts/${name}) hostDirs;
    };
}
