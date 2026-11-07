{...}: {
  services.caddy = {
    enable = true;
    globalConfig = ''
      servers {
        trusted_proxies static 173.245.48.0/20 103.21.244.0/22 103.22.200.0/22 103.31.4.0/22 141.101.64.0/18 108.162.192.0/18 190.93.240.0/20 188.114.96.0/20 197.234.240.0/22 198.41.128.0/17 162.158.0.0/15 104.16.0.0/13 104.24.0.0/14 172.64.0.0/13 131.0.72.0/22 2400:cb00::/32 2606:4700::/32 2803:f800::/32 2405:b500::/32 2405:8100::/32 2a06:98c0::/29 2c0f:f248::/32
        client_ip_headers CF-Connecting-IP
      }
    '';

    virtualHosts = {
      "www.taiwan1989.xyz".extraConfig = ''
        header {
          X-Frame-Options "SAMEORIGIN"
          Content-Security-Policy "frame-ancestors 'self'"
          -Server
        }

        handle_path /upload* {
          reverse_proxy 172.17.0.1:8081 {
            header_up Host {host}
            header_up X-Real-IP {remote_host}
          }
          request_body {
            max_size 750MB
          }
        }

        handle {
          reverse_proxy 127.0.0.1:9099 {
            header_up Host {host}
            header_up X-Real-IP {remote_host}
          }
        }

        @html {
          path *.html *.htm /
        }
        header @html {
          Cache-Control "no-cache, no-store, must-revalidate"
          Pragma "no-cache"
          Expires "0"
        }

        @static {
          path *.png *.jpg *.jpeg *.gif *.ico
        }
        header @static {
          Cache-Control "public, max-age=86400"
        }

        @fonts {
          path *.woff *.woff2 *.ttf *.eot *.svg
        }
        header @fonts {
          Cache-Control "public, max-age=604800"
        }

        log {
          output file /var/log/caddy/taiwan1989_access.log
        }
      '';
      "wcf.taiwan1989.xyz".extraConfig = ''
        header {
          X-Frame-Options "SAMEORIGIN"
          Content-Security-Policy "frame-ancestors 'self'"
          -Server
        }

        handle_path /upload* {
          reverse_proxy 172.17.0.1:8081 {
            header_up Host {host}
            header_up X-Real-IP {remote_host}
          }
          request_body {
            max_size 750MB
          }
        }

        handle {
          reverse_proxy 127.0.0.1:9099 {
            header_up Host {host}
            header_up X-Real-IP {remote_host}
          }
        }

        @html {
          path *.html *.htm /
        }
        header @html {
          Cache-Control "no-cache, no-store, must-revalidate"
          Pragma "no-cache"
          Expires "0"
        }

        @static {
          path *.png *.jpg *.jpeg *.gif *.ico
        }
        header @static {
          Cache-Control "public, max-age=86400"
        }

        @fonts {
          path *.woff *.woff2 *.ttf *.eot *.svg
        }
        header @fonts {
          Cache-Control "public, max-age=604800"
        }

        log {
          output file /var/log/caddy/wcf_taiwan1989_access.log
        }
      '';

      "zp.taiwan1989.xyz".extraConfig = ''
        handle {
          reverse_proxy 127.0.0.1:3000 {
            header_up Host {host}
            header_up X-Real-IP {remote_host}
          }
        }
      '';
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/log/caddy 0755 caddy caddy -"
  ];

  systemd.services.caddy.serviceConfig = {
    AmbientCapabilities = ["CAP_NET_BIND_SERVICE"];
    CapabilityBoundingSet = ["CAP_NET_BIND_SERVICE"];
  };
}
