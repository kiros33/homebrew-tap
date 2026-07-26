cask "nexa-markdown-viewer" do
  version "0.3.2"
  sha256 "945df78c8381309ba21ba3e8084a86cd5497006336e212f790c5b892bbeffce9"

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
