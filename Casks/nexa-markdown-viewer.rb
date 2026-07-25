cask "nexa-markdown-viewer" do
  version "0.3.1"
  sha256 "47770e865cd3c87a1fc49fcd2b16b3b5f40913d662f38898d0c0a4656409dfd7"

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
