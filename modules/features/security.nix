{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.security = {
    pkgs,
    lib,
    ...
  }: {
    # Taken from https://github.com/xddxdd/nixos-config/blob/master/nixos/minimal-components/hardening.nix
    # Blacklist kernel modules vulnerable to Dirty Frag (CVE-2025-XXXX)
    # https://github.com/V4bel/dirtyfrag
    # Using extraModprobeConfig instead of blacklistedKernelModules to also
    # override the install command, preventing accidental/manual loading.
    boot.extraModprobeConfig = ''
      blacklist esp4
      install esp4 ${lib.getExe' pkgs.coreutils "true"}
      blacklist esp6
      install esp6 ${lib.getExe' pkgs.coreutils "true"}
      blacklist rxrpc
      install rxrpc ${lib.getExe' pkgs.coreutils "true"}
      blacklist rds
      install rds ${lib.getExe' pkgs.coreutils "true"}
      blacklist rds_tcp
      install rds_tcp ${lib.getExe' pkgs.coreutils "true"}
    '';

    security.sudo.enable = lib.mkForce false;
    security.sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
  };
}
