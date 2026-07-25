cask "nexa-markdown-viewer" do
  version "0.3.0"
  sha256 "5277081a0830d7c2ada7c8e29335578e16fd05197ad789b0487085ec83505f41"

  url "https://github.com/kiros33/sosomlab-nexa-viewer/releases/download/v#{version}/NexaMarkdownViewer_#{version}_universal.dmg"
  name "Nexa Markdown Viewer"
  desc "Markdown viewer built with Tauri"
  homepage "https://github.com/kiros33/sosomlab-nexa-viewer"


  app "NexaMarkdownViewer.app"

  zap trash: [
    "~/Library/Application Support/com.sosomlab.nexa-markdown-viewer",
    "~/Library/Preferences/com.sosomlab.nexa-markdown-viewer.plist",
    "~/Library/Saved Application State/com.sosomlab.nexa-markdown-viewer.savedState",
  ]
end
