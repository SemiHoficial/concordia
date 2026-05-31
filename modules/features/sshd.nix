{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.sshd = {config, ...}: {
    services.openssh = {
      enable = true;
      ports = [2666];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = ["${config.prefer.user.name}"];
      };
    };
  };
}
