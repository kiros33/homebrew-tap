# Homebrew Formula — Nexa Beep(포터블 채널: 실행 파일만)
#
# Cask(.app)와 **다른 이름**을 쓴다. 같은 탭에 같은 이름의 cask와 formula가 있으면
# `brew install nexa-beep`이 무엇을 뜻하는지 모호해진다 — 사용자가 고민하게 만드는
# 이름은 쓰지 않는다. 설치본이 필요하면 cask, PATH에 실행 파일만 놓고 싶으면 이쪽.
#
# 버전과 체크섬 자리는 릴리스 워크플로가 실제 산출물 해시로 채운다(render-manifests.sh).
class NexaBeepPortable < Formula
  desc "Zero-config local network messenger (portable binary)"
  homepage "https://github.com/SosomLab/nexa-beep"
  version "0.2.2"
  # PolyForm Noncommercial 1.0.0 — SPDX 식별자가 있다(오픈소스 라이선스는 아니다).
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/SosomLab/nexa-beep/releases/download/v0.2.2/nexa-beep-0.2.2-macos-arm64-portable.tar.gz"
      sha256 "69670cf0084e18e5808e6f204052120bcc8edd9f839278536c37582fe2fe1d2e"
    end
    on_intel do
      url "https://github.com/SosomLab/nexa-beep/releases/download/v0.2.2/nexa-beep-0.2.2-macos-x64-portable.tar.gz"
      sha256 "b87956e9f7b228272348540d139d0d8de6df84a757fd80e2553081cf89be6dfc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/SosomLab/nexa-beep/releases/download/v0.2.2/nexa-beep-0.2.2-linux-x64-portable.tar.gz"
      sha256 "c8df34b21ccede2eaddd9c1645e0e4b17d522b8a706ddc313d4e95fdcc268307"
    end
  end

  def install
    # 최상위에 폴더가 하나면 brew가 벗겨 주지만, 그 동작에 기대지 않는다 —
    # 포장 구조가 바뀌는 날 조용히 깨지느니 여기서 찾아서 확실히 설치한다.
    exe = Dir["nexa-beep", "*/nexa-beep"].first
    odie "포터블 압축물에서 nexa-beep 실행 파일을 찾지 못했습니다" if exe.nil?
    bin.install exe => "nexa-beep"
    # 이미지 격리 디코드(M4-5) — 본체가 형제 경로에서 찾는다. 없으면 아바타 이니셜 폴백
    # 이라 치명적이진 않지만, 있으면 같이 설치한다(구버전 압축물 호환 = 없어도 통과).
    imgdec = Dir["nbeep-imgdec", "*/nbeep-imgdec"].first
    bin.install imgdec => "nbeep-imgdec" unless imgdec.nil?
  end

  def caveats
    <<~EOS
      GUI 앱으로 쓰려면 창 모드로 실행하세요:
        nexa-beep --window

      macOS Dock 아이콘·앱 번들이 필요하면 설치본(Cask)을 쓰세요:
        brew install --cask kiros33/tap/nexa-beep
    EOS
  end

  test do
    # 네트워크를 건드리지 않는 경로만 확인한다(테스트가 LAN에 패킷을 뿌리면 안 된다).
    assert_match version.to_s, shell_output("#{bin}/nexa-beep --version")
  end
end
