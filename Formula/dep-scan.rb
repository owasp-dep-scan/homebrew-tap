class DepScan < Formula
  desc "Security and risk audit for project dependencies and container images"
  homepage "https://github.com/owasp-dep-scan/dep-scan"
  version "6.3.0"
  license "MIT"

  # Single-file PyInstaller builds with a bundled cdxgen, so neither Python nor Node.js is needed.
  on_macos do
    on_arm do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-darwin-arm64"
      sha256 "61ff315dd257d40a1513c5b47833953cd4a8108a7e20f0a4542e1a7903452383"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-darwin-amd64"
      sha256 "c143e53684e2b309c3b9a72695c7900b16854772468b22b67a8ef5a61a053dd3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-linux-arm64"
      sha256 "5d0cc08c01e23cfbd0a0e0bfae46072b1eabe4f9c3e5e410cb6eefad172795c9"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-linux-amd64"
      sha256 "bccbf101b91d5ef34ce89a563f8676d4525222ee4f55816afd671e260a9b3af7"
    end
  end

  def install
    binary = Dir["depscan-*"].first
    chmod 0755, binary
    bin.install binary => "depscan"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/depscan --version")
  end
end
