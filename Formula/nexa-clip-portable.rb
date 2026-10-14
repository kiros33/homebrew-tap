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
  version "0.2.2"
  # PolyForm Noncommercial 1.0.0 — SPDX 식별자가 있다(오픈소스 라이선스는 아니다).
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    on_arm do
      url "https://github.com/SosomLab/nexa-clip/releases/download/v0.2.2/nexa-clip-0.2.2-macos-arm64-portable.tar.gz"
      sha256 "6271210bee40c70298521c6ecad7b95520d6e27138885e09ce09f9e77158c055"
    end
    on_intel do
      url "https://github.com/SosomLab/nexa-clip/releases/download/v0.2.2/nexa-clip-0.2.2-macos-x64-portable.tar.gz"
      sha256 "3afa5d8e3093a1abdb4bf0a193387578b2d53cb888d835f55942fea9091be156"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/SosomLab/nexa-clip/releases/download/v0.2.2/nexa-clip-0.2.2-linux-x64-portable.tar.gz"
      sha256 "8ced2c6d8d2460178c4caba8cd3f9484b345a416ffbc06b5d892f03b8cbeb7fc"
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
