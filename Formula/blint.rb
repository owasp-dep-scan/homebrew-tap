class Blint < Formula
  desc "Binary linter and SBOM generator for ELF, PE and Mach-O executables"
  homepage "https://github.com/owasp-dep-scan/blint"
  version "4.1.0"
  license "MIT"

  # Single-file PyInstaller builds: Python and blint's dependencies are inside the executable.
  on_macos do
    on_arm do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-darwin-arm64"
      sha256 "506e3d71105d79f3e3cf8469d711d4394917b35f95ba0b96aa38f3075ebdd870"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-darwin-amd64"
      sha256 "18f0108757ba3fa39c2b3b4e7e5f50e40b0ecaf421ff7c68c57987467f9a24e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-linux-arm64"
      sha256 "14d228a34ad6b0f345dc7b1efaacaccdb48b96f78f02ee6b39f0afba82a2f4b9"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/blint/releases/download/v#{version}/blint-linux-amd64"
      sha256 "d09ef80129bd1395b9bb6b0025a08dd92274b0734cd2340e702f6565ca24c5ff"
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
