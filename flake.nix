{
  description = "Chimera's core userland, based on FreeBSD";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
    in
    {
      overlays.default = final: _: {
        chimerautils = final.callPackage ./package.nix { };

        # chimerautils + bsdtar to make a complete userland
        chimera-userland = final.buildEnv {
          name = "chimera-userland";
          paths = [
            final.chimerautils
            final.libarchive
          ];
          postBuild = "ln -s bsdtar $out/bin/tar";
        };
      };

      packages.${system} = {
        inherit (pkgs) chimerautils chimera-userland;
        default = pkgs.chimera-userland;
      };
    };
}
