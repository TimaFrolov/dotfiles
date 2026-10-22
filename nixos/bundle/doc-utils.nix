{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    graphviz
    pdftk
    ffmpeg-full
    imagemagick
    ghostscript
    ripgrep-all
  ];
}
