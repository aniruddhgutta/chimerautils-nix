# chimerautils-nix

Nix flake for [chimerautils](https://github.com/chimera-linux/chimerautils),
Chimera Linux's FreeBSD-based userland.

## Outputs

- `packages.<system>.chimerautils`: the userland
- `packages.<system>.chimera-userland`: chimerautils + bsdtar (meant for finix)
- `overlays.default`: adds both to `pkgs`

## Usage

As an overlay in a system config:

```nix
{
  inputs.chimerautils.url = "github:aniruddhgutta/chimerautils-nix";

  outputs = { self, nixpkgs, chimerautils, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      modules = [({ pkgs, ... }: {
        nixpkgs.overlays = [ chimerautils.overlays.default ];

        # finix: using chimerautils for coreutils
        programs.coreutils.package = pkgs.chimera-userland;
      })];
    };
  };
}
```

If you install it next to `busybox` or `coreutils` and `buildEnv` reports a
path collision, wrap it in `lib.hiPrio`.
