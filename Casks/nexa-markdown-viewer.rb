cask "nexa-markdown-viewer" do
  version "0.2.1"
  sha256 "08a0f9965e5660f60877b883ea6294919c0185ec6d2284a2152386f9a125c725"

  url "https://github.com/kiros33/sosomlab-nexa-viewer/releases/download/v#{version}/NexaMarkdownViewer_#{version}_universal.dmg"
  name "Nexa Markdown Viewer"
  desc "Markdown viewer built with Tauri"
  homepage "https://github.com/kiros33/sosomlab-nexa-viewer"

  license :mit

  app "NexaMarkdownViewer.app"

  zap trash: [
    "~/Library/Application Support/com.sosomlab.nexa-markdown-viewer",
    "~/Library/Preferences/com.sosomlab.nexa-markdown-viewer.plist",
    "~/Library/Saved Application State/com.sosomlab.nexa-markdown-viewer.savedState",
  ]
end
