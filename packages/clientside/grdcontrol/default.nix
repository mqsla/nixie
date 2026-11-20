{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  dpkg,
  libxcb,
}: let
  version = "4.4.3";
in
  stdenv.mkDerivation {
    pname = "grdcontrol";
    inherit version;

    src = fetchurl {
      url = "https://download.guardant.ru/Guardant_Control_Center/${version}/grdcontrol-${version}_amd64.deb";
      hash = "sha256-mDNXypH5O9Rvy+2r4rgDnilHj1lcxNbwMiIR3sWZcLk=";
    };

    nativeBuildInputs = [
      autoPatchelfHook
      dpkg
    ];
    buildInputs = [libxcb];

    unpackPhase = ''
      runHook preUnpack
      dpkg-deb --extract "$src" .
      runHook postUnpack
    '';

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      sourceDir=opt/guardant/grdcontrol
      targetDir="$out/libexec/grdcontrol"

      mkdir -p "$targetDir"
      cp -r "$sourceDir/www" "$targetDir/"
      install -Dm644 "$sourceDir/grdcontrold.properties" "$targetDir/grdcontrold.properties"
      install -Dm755 "$sourceDir/grdcontrold" "$targetDir/grdcontrold"
      install -Dm755 "$sourceDir/license_wizard" "$out/bin/grdcontrol-license-wizard"
      install -Dm644 "$sourceDir/95-grdnt.rules" "$out/lib/udev/rules.d/95-grdnt.rules"

      substituteInPlace "$targetDir/grdcontrold.properties" \
        --replace-fail "logger.server.pathprefix = logs_gcc/" \
          "logger.server.pathprefix = /var/lib/grdcontrol/logs_gcc/" \
        --replace-fail "server.wwwroot = www" \
          "server.wwwroot = $targetDir/www"

      runHook postInstall
    '';

    meta = {
      description = "Guardant Control Center license service";
      homepage = "https://www.guardant.com/support/users/control-center/";
      license = lib.licenses.unfree;
      mainProgram = "grdcontrol-license-wizard";
      platforms = ["x86_64-linux"];
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    };
  }
