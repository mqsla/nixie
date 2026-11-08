{
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    profiles.default = {
      isDefault = true;
      search = {
        default = "google";
        force = true;
        privateDefault = "google";
      };
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.contentblocking.category" = "custom";
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.translations.enable" = false;
        "general.autoScroll" = true;
        "middlemouse.paste" = false;
        "media.hardware-video-decoding.enabled" = true;
        "zen.view.sidebar-expanded" = false;
        "zen.view.use-single-toolbar" = false;
        "zen.welcome-screen.seen" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.fingerprintingProtection.pbmode" = true;
        "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme,-CanvasImageExtractionPrompt,-CanvasExtractionFromThirdPartiesIsBlocked,-CanvasExtractionBeforeUserInputIsBlocked,-CanvasRandomization,-EfficientCanvasRandomization";
        "layout.css.prefers-color-scheme.content-override" = 2;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "media.peerconnection.enabled" = true;
        "media.peerconnection.ice.no_host" = true;
        "media.peerconnection.ice.default_address_only" = true;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "geo.enabled" = false;
        "permissions.default.geo" = 2;
        "dom.security.https_only_mode" = true;
        "network.dns.disablePrefetch" = true;
      };
    };
    policies = let
      installExtension = slug: {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
        installation_mode = "normal_installed";
      };
    in {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      OfferToSaveLogins = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      PasswordManagerEnabled = false;
      Permissions.Location.BlockNewRequests = true;
      PromptForDownloadLocation = true;
      TranslateEnabled = false;
      UserMessaging.SkipOnboarding = true;

      ExtensionSettings = {
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" =
          (installExtension "bitwarden-password-manager")
          // {
            default_area = "navbar";
          };
        "gdpr@cavi.au.dk" = installExtension "consent-o-matic";
        "jid1-BoFifL9Vbdl2zQ@jetpack" = installExtension "decentraleyes";
        "{cb31ec5d-c49a-4e5a-b240-16c767444f62}" = installExtension "indie-wiki-buddy";
        "jid1-MnnxcxisBPnSXQ@jetpack" = installExtension "privacy-badger17";
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = installExtension "return-youtube-dislikes";
        "firefox-extension@steamdb.info" = installExtension "steam-database";
        "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = installExtension "traduzir-paginas-web";
        "uBlock0@raymondhill.net" = installExtension "ublock-origin";
      };
    };
  };

  xdg.mimeApps = {
    enable = true;
    associations.added."application/pdf" = ["zen-beta.desktop"];
    defaultApplications."application/pdf" = ["zen-beta.desktop"];
  };
}
