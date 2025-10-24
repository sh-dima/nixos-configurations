{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ollama
    open-webui
    llama-cpp
  ];

  services.ollama.enable = true;

  systemd.services.ollama.serviceConfig = {
    Environment = [
      "OLLAMA_HOST=0.0.0.0:11434"
    ];
  };

  services.open-webui = {
    enable = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      SCARF_NO_ANALYTICS = "True";
      DO_NOT_TRACK = "True";

      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
    };
  };
}