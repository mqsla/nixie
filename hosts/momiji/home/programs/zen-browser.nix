{
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    env = {
      LIBVA_DRIVER_NAME = "nvidia";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      NVD_BACKEND = "direct";
    };
    profiles.default = {
      isDefault = true;
      search = {
        default = "google";
        force = true;
        privateDefault = "google";
      };
      settings = {
        # --- 1. UI & QoL ---
        "browser.aboutConfig.showWarning" = false; # Hide about:config warning
        "browser.aboutwelcome.enabled" = false; # Skip Firefox onboarding
        "browser.toolbars.bookmarks.visibility" = "always"; # Always show bookmarks bar
        "browser.translations.enable" = false; # Disable built-in translations
        "general.autoScroll" = true; # Enable middle-click scrolling
        "middlemouse.paste" = false; # Disable middle-click paste

        # --- 2. Hardware Acceleration ---
        "media.hardware-video-decoding.enabled" = true; # Enable hardware video decoding

        # --- 3. Zen Browser ---
        "zen.view.sidebar-expanded" = false; # Start with collapsed sidebar
        "zen.view.use-single-toolbar" = false; # Disable single-toolbar layout
        "zen.welcome-screen.seen" = true; # Skip Zen welcome screen

        # --- 4. Privacy & Fingerprinting ---
        "browser.contentblocking.category" = "custom"; # Use custom tracking protection
        "privacy.fingerprintingProtection" = true; # Enable fingerprinting protection
        "privacy.fingerprintingProtection.pbmode" = true; # Protect private windows
        "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme,-CanvasImageExtractionPrompt,-CanvasExtractionFromThirdPartiesIsBlocked,-CanvasExtractionBeforeUserInputIsBlocked,-CanvasRandomization,-EfficientCanvasRandomization"; # Keep timezone spoofing, allow canvas access
        "layout.css.prefers-color-scheme.content-override" = 2; # Follow system theme
        "privacy.trackingprotection.enabled" = true; # Block known trackers
        "privacy.trackingprotection.fingerprinting.enabled" = true; # Block fingerprinting scripts
        "privacy.trackingprotection.cryptomining.enabled" = true; # Block cryptomining scripts

        # --- 5. WebRTC ---
        "media.peerconnection.enabled" = true; # Keep WebRTC available
        "media.peerconnection.ice.no_host" = true; # Hide local ICE host addresses
        "media.peerconnection.ice.default_address_only" = true; # Restrict ICE to default route

        # --- 6. Telemetry & Security ---
        "datareporting.healthreport.uploadEnabled" = false; # Disable health report uploads
        "datareporting.policy.dataSubmissionEnabled" = false; # Disable data submissions
        "toolkit.telemetry.enabled" = false; # Disable legacy telemetry
        "app.shield.optoutstudies.enabled" = false; # Disable browser studies
        "geo.enabled" = false; # Disable browser geolocation
        "permissions.default.geo" = 2; # Block location permissions
        "dom.security.https_only_mode" = true; # Prefer HTTPS connections

        # --- 7. Network ---
        "network.dns.disablePrefetch" = true; # Disable DNS prefetching
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
    defaultApplications = {
      "application/pdf" = ["zen-beta.desktop"];
    };
  };
}
