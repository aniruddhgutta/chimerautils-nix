{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  byacc,
  flex,
  acl,
  bzip2,
  libedit,
  libselinux,
  libxo,
  ncurses,
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
    libedit
    libselinux
    libxo
    ncurses
    openssl
    xz
    zlib
    zstd
  ];

  mesonFlags = [
    "--libexecdir=lib/chimerautils"
    "-Dchimera_realpath=enabled"
  ];
  
  postInstall = ''
    install -Dm644 ${finalAttrs.src}/LICENSE -t $out/share/licenses/chimerautils

    # etc files: Chimera ships them under share/ and installs via tmpfiles
    if [ -d $out/etc ]; then
      mkdir -p $out/share/chimerautils
      mv $out/etc/* $out/share/chimerautils/
      rmdir $out/etc
    fi
  '';

  meta = {
    description = "Chimera's core userland, based on FreeBSD";
    homepage = "https://github.com/chimera-linux/chimerautils";
    license = lib.licenses.bsd2;
    platforms = lib.platforms.linux;
  };
})
