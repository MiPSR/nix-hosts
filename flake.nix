{
  description = "ui host config";

  outputs = { self }:
    {
      host = { pkgs, ... }:
        {
          boot.kernelPackages = pkgs.linuxPackages_zen;

          hardware = {
            alsa.enablePersistence = true;
            amdgpu.opencl.enable = true;
            graphics = {
              enable = true;
              enable32Bit = true;
            };
          };

          networking.hostName = "ui";

          services.power-profiles-daemon.enable = true;

          system.stateVersion = "26.05";

          users.users.m.packages = with pkgs; [
            darktable
            (discord.override { withVencord = true; })
            gamescope
            git
            google-chrome
            heroic
            interlude
            jdk
            kdePackages.elisa
            kdePackages.falkon
            kdePackages.kaddressbook
            kdePackages.kate
            kdePackages.kclock
            kdePackages.kdepim-addons
            kdePackages.kmail
            kdePackages.neochat
            krita
            libreoffice-qt
            librewolf
            mpv
            openutau
            osu-lazer-bin
            pixelorama
            prismlauncher
            protonup-rs
            steam
          ];
        };
    };
}
