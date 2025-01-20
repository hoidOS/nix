{
  stdenv,
  lib,
  fetchurl,
  darwin,
}:

stdenv.mkDerivation {
  pname = "myPackage";
  version = "v0.0.1";

  src = ./src;

  # Use a cross-platform build tool like make or directly use cc-wrapper which handles both gcc and clang
  nativeBuildInputs = lib.optionals stdenv.isDarwin [
    darwin.cctools # Provides ar, ld, etc. for macOS
    darwin.apple_sdk.frameworks.CoreFoundation # If needed for some macOS stuff
  ];

  buildPhase = ''
    # Use $CC instead of hardcoding gcc or clang
    $CC -std=c99 -Wall -Werror -c main.c
    $CC -std=c99 -Wall -Werror main.o -o main
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv main $out/bin/myPackage
  '';
}
