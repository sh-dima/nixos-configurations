{ ... }:

{
  programs.git = {
    settings = {
      user = {
        name = "Дима Ш.";
        email = "dima.o.sh@proton.me";
      };

      commit = {
        gpgsign = true;
      };
    };
  };
}
