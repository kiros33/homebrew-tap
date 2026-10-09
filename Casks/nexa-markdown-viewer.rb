cask "nexa-markdown-viewer" do
  version "0.4.0"
  sha256 "5c784fe8b40c4ca5e47676e98138a50b206d9388ac9fb540ad69b2efc681a9cc"

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
