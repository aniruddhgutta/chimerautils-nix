{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  acl,
  byacc,
  flex,
  bzip2,
  libxo,
  ncurses,
  libedit,
  libselinux,
  openssl,
  xz,
  zlib,
  zstd,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "chimerautils";
  version = "15.1.2";

  src = fetchFromGitHub {
    owner = "chimera-linux";
    repo = "chimerautils";
    rev = "v${finalAttrs.version}";
    hash = "sha256-N9S841W3MboJpD3LWLvXxMBbnbEQkHKjquSSVdOj8FE=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    byacc
    flex
  ];

  buildInputs = [
    acl
    bzip2
    libxo
    ncurses
    libedit
    libselinux
    openssl
    xz
    zlib
    zstd
  ];

  mesonFlags = [ "-Dchimera_realpath=enabled" ];

  meta = {
    description = "Chimera's core userland, based on FreeBSD";
    homepage = "https://github.com/chimera-linux/chimerautils";
    license = lib.licenses.bsd2;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ fromSource ];
  };
})
