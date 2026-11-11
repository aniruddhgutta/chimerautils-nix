{
  description = "Chimera's core userland, based on FreeBSD";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system} = {
        default = pkgs.callPackage ./package.nix { };
        chimerautils = self.packages.${system}.default;
      };

      overlays.default = final: prev: {
        chimerautils = final.callPackage ./package.nix { };
      };
    };
}
