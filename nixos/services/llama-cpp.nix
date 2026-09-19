{
  pkgs,
  ...
}:
{
  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp.override { cudaSupport = true; };
    openFirewall = true;

    settings = {
      host = "0.0.0.0";
      port = 8080;
      model = pkgs.fetchurl {
        url = "https://huggingface.co/unsloth/Qwen3.5-9B-GGUF/resolve/main/Qwen3.5-9B-Q4_K_M.gguf";
        hash = "sha256-A7dHJ6hgpWM44ELEQguz8Esv7Fc0F19MufqFPa9St+g=";
      };
      flash-attn = "on";
      gpu-layers = "all";
      temp = 0.6;
      top-k = 20;
      top-p = 0.95;
      min-p = 0.0;
      presence-penalty = 0.0;
      repeat-penalty = 1.0;
    };
  };

  tima.unfree = [
    "cuda_cudart"
    "cuda_cccl"
    "libcublas"
    "cuda_nvcc"
    "cuda_nvrtc"
  ];

}
