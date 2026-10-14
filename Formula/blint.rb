class Blint < Formula
  desc "Binary linter and SBOM generator for ELF, PE and Mach-O executables"
  homepage "https://github.com/owasp-dep-scan/blint"
  version "4.0.1"
  license "MIT"

  # Single-file PyInstaller builds: Python and blint's dependencies are inside the executable.
  on_macos do
    on_arm do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-darwin-arm64"
      sha256 "505436d4bcde97126900f4d35bd417a880a1d9bab91c94cdb47dd0c7a4a830b8"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-darwin-amd64"
      sha256 "efcad3a600eb1e52c8e8b1629a5637d30f410a924a45082fd29a4afde0331128"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-linux-arm64"
      sha256 "d3a0d35c7fc2f4ee70c6fe39a2f0194dd30a23e5e1c6e83b57e2c83256f25e2b"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-linux-amd64"
      sha256 "584189333db16a126c2604071b6e1fb0fe6c39e60fd44d7b467dd0269f08a27f"
    end
  end

  def install
    binary = Dir["blint-*"].first
    chmod 0755, binary
    bin.install binary => "blint"
  end

  test do
    assert_match "usage: blint", shell_output("#{bin}/blint --help")
  end
end
