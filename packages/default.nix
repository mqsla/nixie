{pkgs}: {
  clientside = import ./clientside {inherit pkgs;};
  serverside = import ./serverside {inherit pkgs;};
}
