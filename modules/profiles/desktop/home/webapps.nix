{ pkgs, ... }:

{
  # xdg.desktopEntries = {
  #   chatgpt = {
  #     name = "ChatGPT";
  #     genericName = "AI Chat";
  #     exec = "${pkgs.chromium}/bin/chromium --ozone-platform-hint=auto --app=https://chat.openai.com --class=webapp-chatgpt --user-data-dir=\${HOME}/.config/chromium-apps/chatgpt";
  #     icon = "chatgpt";   # put a .png/.svg in ~/.local/share/icons/ or use full path
  #     type = "Application";
  #     categories = [ "Network" "WebBrowser" ];
  #     startupWMClass = "webapp-chatgpt";
  #   };

  #   notion = {
  #     name = "Notion";
  #     exec = let
  #       chromium = pkgs.chromium.override {
  #         commandLineArgs = [ "--enable-features=WaylandWindowDecorations,WebUIDarkMode" "--force-dark-mode" ];
  #       };
  #     in "${chromium}/bin/chromium --app=https://www.notion.so --class=webapp-notion --user-data-dir=\${HOME}/.config/chromium-apps/notion";
  #     icon = "${pkgs.notion-app-enhanced}/share/icons/hicolor/256x256/apps/notion.png";
  #     startupWMClass = "webapp-notion";
  #   };
  # };

  # Optional:alacritty make sure icons folder is watched
  # xdg.enable = true;
}
