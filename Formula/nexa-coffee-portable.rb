# Homebrew Formula — Nexa Coffee 포터블(Linux x86_64 정적 바이너리 · musl). 버전·체크섬은 render-manifests.sh가 채운다.
# macOS는 Cask(nexa-coffee)를 쓴다 — 메뉴바 앱은 .app 번들이어야 로그인 항목 등록이 자연스럽다.
class NexaCoffeePortable < Formula
  desc "Tiny tray timer that keeps the computer awake (Linux · static binary)"
  homepage "https://github.com/SosomLab/nexa-coffee"
  url "https://github.com/SosomLab/nexa-coffee/releases/download/v0.1.0/nexa-coffee-0.1.0-linux-x64.tar.gz"
  version "0.1.0"
  sha256 "290480c774af0135024e579de7fd1a1fc3e6ad8232d4ca0386704437f9e07120"
  license "MIT"

  depends_on :linux

  def install
    bin.install "nexa-coffee"
    (share/"applications").install "nexa-coffee.desktop"
    (share/"icons/hicolor/256x256/apps").install "nexa-coffee-256.png" => "nexa-coffee.png"
  end

  def caveats
    <<~EOS
      Nexa Coffee needs a StatusNotifierItem tray host (KDE Plasma, or GNOME with the AppIndicator extension)
      and one of yad / zenity / kdialog for the custom-duration dialog.
    EOS
  end

  test do
    assert_predicate bin/"nexa-coffee", :executable?
  end
end
