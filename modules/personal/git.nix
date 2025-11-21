{ ... }:

{
  programs.git = {
    extraConfig = {
      commit = {
        gpgsign = true;
      };
    };

    userName = "Дима Ш.";
    userEmail = "dima.o.sh@proton.me";
  };
}
