{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  cups,
  dpkg,
  gtk2,
  libGLU,
  libICE,
  libSM,
  libXScrnSaver,
  libdrm,
  libfontenc,
  libgcc,
  libx11,
  libxau,
  libxaw,
  libxcb,
  libxcomposite,
  libxcursor,
  libxdamage,
  libxdmcp,
  libxext,
  libxfixes,
  libxi,
  libxinerama,
  libxkbfile,
  libxmu,
  libxpm,
  libxrandr,
  libxrender,
  libxres,
  libxt,
  libxtst,
  libxv,
  libxxf86vm,
  llvmPackages,
  qt3d,
  tinyxml,
  util-linux,
  wrapQtAppsHook,
  xcb-util-cursor,
  xcbutil,
  xcbutilimage,
  xcbutilkeysyms,
  xcbutilrenderutil,
  xcbutilwm,
}: let
  version = "24.1.0.161";
  repository = "https://repo.ascon.ru/stable/deb/pool/main";

  componentHashes = {
    ascon-kompas3d-v24-full = "sha256-KhBf0K450J3donQB7OmbHuPUmNREcCWJdFlhi6dkXyo=";
    ascon-kompas3d-v24 = "sha256-aFJ5OT1ZtT6a9IGURMtIWoHYSCZG4c8SlXNLmyLg6Zc=";
    ascon-kompas-graphic-v24 = "sha256-5ebowbW/HxnZfnC6uUizBsQKD+NCu9+WgwcGz8Oop4I=";
    ascon-kompas-plugins-v24 = "sha256-A90aR0AIJDSdu6kXq70g/kIm1w7QUnl/wOOgwwnUdrY=";
    ascon-kompas-nesting-v24 = "sha256-/LXNk9k2MmDvgnf4eGqrXCGnswdmeDyBvrlAcVMgZY8=";
    ascon-kompas-servicetools-v24 = "sha256-QiEqVyllq5ahZsE+liUWoCqOqrqL4Tpgc6MXPCeS0fo=";
    ascon-kompas-featurekompas-v24 = "sha256-zuWsok3h5deOEqJ8Na4ruaKh8rjVPfAN4yj7RlNSiQA=";
    ascon-kompas-sdk-v24 = "sha256-z0bohENrSBk4LDPK+cC3YkYARxvwdpEJMZdVuf1oAPA=";
    ascon-kompas-libsamples-v24 = "sha256-wZfda5t8aaH2IlHByZrKa7lDfeqWK483FxQnaoXhARk=";
    ascon-kompas-coupling-v24 = "sha256-lptq6iZA0Ij09VkvwsIcAqAuJJfSfpn8/Vqn8AaJhtU=";
    ascon-kompas-help-v24 = "sha256-nmFqmsPx6g0+4ptFnOJ6AtVoSVtZWEGmU88qhQl9XR8=";
    ascon-kompas-checker-v24 = "sha256-z+huhrrEvgA50G0UJ7Cd7q0pMAJtYoTk2BHyEZepzXU=";
    ascon-kompas-dimchain-v24 = "sha256-EtY1KLWWFWTogY0QnS/E4x+76FaUohWBk860CJrSuo0=";
  };

  fetchComponent = name: hash:
    fetchurl {
      inherit hash;
      url = "${repository}/a/${name}/${name}_${version}_amd64.deb";
    };

  auxiliaryDebs = [
    (fetchurl {
      url = "${repository}/a/ascon-kompas-common/ascon-kompas-common_1.0.0.3_amd64.deb";
      hash = "sha256-fYGTd2WNrQBSXDvn5g/yHM8WTXkALNsnGPd9dxUNgM4=";
    })
    (fetchurl {
      url = "${repository}/a/ascon-kompas-fonts/ascon-kompas-fonts_1.0.0.7_amd64.deb";
      hash = "sha256-iQKgDSzyd3fRBcZzl4IbkCn9Z0z+xsCRRhW+lbo9cyo=";
    })
    (fetchurl {
      url = "${repository}/a/ascon/ascon-polynom-library-23.3-23.3.0.25101312-amd64.deb";
      hash = "sha256-IIfFSfZ2+HTf0diA7+6BcvGzIgDbwDmUq1ruAqLaB20=";
    })
  ];
in
  stdenv.mkDerivation {
    pname = "kompas3d";
    inherit version;

    srcs = lib.mapAttrsToList fetchComponent componentHashes ++ auxiliaryDebs;

    nativeBuildInputs = [
      autoPatchelfHook
      dpkg
      wrapQtAppsHook
    ];

    buildInputs = [
      cups
      gtk2
      libGLU
      libICE
      libSM
      libXScrnSaver
      libdrm
      libfontenc
      libgcc.lib
      libx11
      libxau
      libxaw
      libxcb
      libxcomposite
      libxcursor
      libxdamage
      libxdmcp
      libxext
      libxfixes
      libxi
      libxinerama
      libxkbfile
      libxmu
      libxpm
      libxrandr
      libxrender
      libxres
      libxt
      libxtst
      libxv
      libxxf86vm
      llvmPackages.libcxx
      llvmPackages.libunwind
      llvmPackages.openmp
      qt3d
      tinyxml
      util-linux.lib
      xcb-util-cursor
      xcbutil
      xcbutilimage
      xcbutilkeysyms
      xcbutilrenderutil
      xcbutilwm
    ];

    unpackPhase = ''
      runHook preUnpack
      for deb in $srcs; do
        dpkg-deb --extract "$deb" .
      done
      runHook postUnpack
    '';

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p "$out"
      cp -r etc opt "$out/"
      cp -r usr/bin usr/share "$out/"

      base="$out/opt/ascon/kompas3d-v24"
      mkdir -p "$out/bin"
      ln -s "$base/Bin/kKompas" "$out/bin/kompas3d"
      ln -s "$base/License/kactivation" "$out/bin/kompas3d-activation"
      ln -s "$out/opt/ascon/PolynomLibrary" "$base/Libs/PolynomLibrary"

      if [ -d "$out/share/applications/flystartmenu/kompas3d-24" ]; then
        mv "$out/share/applications/flystartmenu/kompas3d-24"/* "$out/share/applications/"
        rm -rf "$out/share/applications/flystartmenu"
      fi

      for desktop in "$out"/share/applications/*.desktop; do
        [ -e "$desktop" ] || continue
        substituteInPlace "$desktop" \
          --replace-quiet "/opt/ascon/kompas3d-v24/Bin/kKompas" "kompas3d" \
          --replace-quiet "/opt/ascon/kompas3d-v24/License/kactivation" "kompas3d-activation" \
          --replace-quiet "/opt/ascon/kompas3d-v24" "$base"
      done

      runHook postInstall
    '';

    autoPatchelfIgnoreMissingDeps = [
      "*.tx"
      "*.txv"
      "liboless.so"
    ];

    meta = {
      description = "KOMPAS-3D v24 CAD system";
      homepage = "https://kompas.ru/kompas-3d/";
      license = lib.licenses.unfree;
      mainProgram = "kompas3d";
      platforms = ["x86_64-linux"];
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    };
  }
