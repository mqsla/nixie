{
  lib,
  bash,
  buildFHSEnv,
  kompas3d,
  makeWrapper,
  open-sans,
  writeText,
}: let
  pname = "kompas3d-fhs";
  launcher = writeText "kompas3d-launcher" ''
    export QT_QPA_PLATFORM=xcb
    export QT_STYLE_OVERRIDE=Fusion
    cd /opt/ascon/kompas3d-v24/Bin

    if [ "''${1-}" = "--activate" ]; then
      shift
      exec ../License/kactivation "$@"
    fi

    exec ./kKompas "$@"
  '';
in
  buildFHSEnv {
    inherit pname;
    inherit (kompas3d) version;

    runScript = "${lib.getExe bash} ${launcher}";
    targetPkgs = _pkgs: [
      kompas3d
      open-sans
    ];

    extraInstallCommands = ''
      ln -s "${kompas3d}/share" "$out/share"
      ln -s "$out/bin/${pname}" "$out/bin/kompas3d"
      ${makeWrapper}/bin/makeWrapper "$out/bin/${pname}" "$out/bin/kompas3d-activation" \
        --add-flags "--activate"
    '';

    meta =
      kompas3d.meta
      // {
        mainProgram = "kompas3d";
      };
  }
