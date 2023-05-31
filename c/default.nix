{ stdenv
, ...
}:

stdenv.mkDerivation {
  pname = "myPackage";
  version = "v0.0.1";

  src = ./src;

  buildPhase = ''
    gcc -c main.c
    gcc main.o -o main
    # ls -la
    # exit 1
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv main $out/bin/myPackage
  '';
}

