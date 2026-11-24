class Blint < Formula
  desc "Binary linter and SBOM generator for ELF, PE and Mach-O executables"
  homepage "https://github.com/owasp-dep-scan/blint"
  version "4.1.1"
  license "MIT"

  # Single-file PyInstaller builds: Python and blint's dependencies are inside the executable.
  on_macos do
    on_arm do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-darwin-arm64"
      sha256 "89b061dce93fef8285f38abad42ed67a18109ee128ef7ff2a0c3912469f55823"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-darwin-amd64"
      sha256 "47b1e433e1bc086b5240b15ba98891952ee14b74cf7d8c4d62564ccff5c10b53"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-linux-arm64"
      sha256 "09c75925f94c15e971af7a97bd70d3bf0dfd40cf92a24efa07e63c2bbe4380f7"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-linux-amd64"
      sha256 "a61450fd408ccc4b9a1114eb50714b3c6485b9adc3bfd6989925f66eec3f21d3"
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
