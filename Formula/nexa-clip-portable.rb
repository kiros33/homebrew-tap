# Homebrew Formula — Nexa Clip(포터블 채널: 실행 파일만)
#
# Cask(.app)와 **다른 이름**을 쓴다. 같은 탭에 같은 이름의 cask와 formula가 있으면
# `brew install nexa-clip`이 무엇을 뜻하는지 모호해진다 — 사용자가 고민하게 만드는
# 이름은 쓰지 않는다. 설치본이 필요하면 cask, PATH에 실행 파일만 놓고 싶으면 이쪽.
#
# 버전과 체크섬 자리는 릴리스 워크플로가 실제 산출물 해시로 채운다(render-manifests.sh).
class NexaClipPortable < Formula
  desc "Cross-platform clipboard manager (portable binary)"
  homepage "https://github.com/SosomLab/nexa-clip"
  version "0.1.2"
  # PolyForm Noncommercial 1.0.0 — SPDX 식별자가 있다(오픈소스 라이선스는 아니다).
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/SosomLab/nexa-clip/releases/download/v0.1.2/nexa-clip-0.1.2-macos-arm64-portable.tar.gz"
      sha256 "f5c415974624648b732266386f54edd63a8857222c70118a489d8510c33c6306"
    end
    on_intel do
      url "https://github.com/SosomLab/nexa-clip/releases/download/v0.1.2/nexa-clip-0.1.2-macos-x64-portable.tar.gz"
      sha256 "edb291e7df02a26ee899843d09cc312e8c3bda97fe3c64e1d4df267980910550"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/SosomLab/nexa-clip/releases/download/v0.1.2/nexa-clip-0.1.2-linux-x64-portable.tar.gz"
      sha256 "44bca89235d0e3c799417ded38f2222190d88dcc5824d5ac3cf03aee813059b8"
    end
  end

  def install
    # 최상위에 폴더가 하나면 brew가 벗겨 주지만, 그 동작에 기대지 않는다 —
    # 포장 구조가 바뀌는 날 조용히 깨지느니 여기서 찾아서 확실히 설치한다.
    exe = Dir["nexa-clip", "*/nexa-clip"].first
    odie "포터블 압축물에서 nexa-clip 실행 파일을 찾지 못했습니다" if exe.nil?
    bin.install exe => "nexa-clip"
    # 이미지 격리 디코드 워커 — 본체가 형제 경로에서 찾는다. 없으면 PNG 썸네일·전파 변환이 빠진다.
    imgdec = Dir["nclip-imgdec", "*/nclip-imgdec"].first
    bin.install imgdec => "nclip-imgdec" unless imgdec.nil?
  end

  def caveats
    <<~EOS
      인자 없이 실행하면 트레이(메뉴 막대)에 상주합니다:
        nexa-clip

      macOS Dock 아이콘·앱 번들이 필요하면 설치본(Cask)을 쓰세요:
        brew install --cask kiros33/tap/nexa-clip
    EOS
  end

  test do
    # 네트워크를 건드리지 않는 경로만(--version은 아무것도 열지 않는다).
    assert_match version.to_s, shell_output("#{bin}/nexa-clip --version")
  end
end
