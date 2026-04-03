{ username, ... }: {
  networking.hostName     = "${username}-macbook";
  networking.computerName = "${username}'s MacBook";

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  nix.settings.trusted-users = [ "@admin" username ];
}
