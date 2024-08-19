{ lib
, beamPackages
, erlang
, fetchFromGitHub
, gcc
, gnumake
, makeWrapper
, openssl
, stdenv
, unixODBC
, zlib
, nixosTests
}:

stdenv.mkDerivation rec {
  name = "mongoose-im";
  version = "6.2.1";

  src = fetchFromGitHub {
    owner = "esl";
    repo = "MongooseIM";
    rev = "${version}";
    sha256 = "0s248i9c892f498dvgi3n3pczjli9c344vni1nbcndri6nhs9a0j";
  };

  SKIP_CERT_BUILD=1;

  buildInputs =
    [ gcc gnumake erlang openssl unixODBC zlib ];

  nativeBuildInputs = [ makeWrapper ];

  configurePhase = ''
    mkdir -p $out/tools
    cp -r $src/tools $out/tools
    chmod +x $out/tools/configure
  '';

  #installPhase = ''
  #  mkdir -p $out/bin
  #  cp -r $src $out/bin/dagger
  #  chmod +x $out/bin/dagger
  #'';

  buildPhase = ''
    make
  '';

  meta = {
    description = ''MongooseIM is Erlang Solutions' robust, scalable and efficient XMPP server, aimed at large installations. Specifically designed for enterprise purposes, it is fault-tolerant and can utilise the resources of multiple clustered machines.'';
    license = lib.licenses.gpl2;
    homepage = "https://trymongoose.im/";
  };
}

#beamPackages.buildRebar3 rec {
#  name = "mongoose-im";
#  version = "6.2.1";
#
#  src = fetchFromGitHub {
#    owner = "esl";
#    repo = "MongooseIM";
#    rev = "${version}";
#    sha256 = "0s248i9c892f498dvgi3n3pczjli9c344vni1nbcndri6nhs9a0j";
#  };
#
#  beamDeps = [ gcc gnumake erlang openssl unixODBC zlib ];
#
#  buildPhase = ''
#    runHook preBuild
#    SKIP_CERT_BUILD=1 make
#    runHook postBuild
#  '';
#
#  meta = {
#    description = ''MongooseIM is Erlang Solutions' robust, scalable and efficient XMPP server, aimed at large installations. Specifically designed for enterprise purposes, it is fault-tolerant and can utilise the resources of multiple clustered machines.'';
#    license = lib.licenses.gpl2;
#    homepage = "https://trymongoose.im/";
#  };
#}
#
