class DepScan < Formula
  desc "Security and risk audit for project dependencies and container images"
  homepage "https://github.com/owasp-dep-scan/dep-scan"
  version "6.3.2"
  license "MIT"

  # Single-file PyInstaller builds with a bundled cdxgen, so neither Python nor Node.js is needed.
  on_macos do
    on_arm do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-darwin-arm64"
      sha256 "e8e551f8dfb4b9497d8ffaf223f531a91b06fb371ae624c771b858b5b18b216b"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-darwin-amd64"
      sha256 "57bebc0d34f4fb2a4d97c82fc26c093420de1b28d70588e2015c2af24b982dd9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-linux-arm64"
      sha256 "b70f9c22f94369b91a6dd31054df1615b9eab04387a7de4eb6b2873ae50b9608"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-linux-amd64"
      sha256 "290cf634a8ab15c2a96355d1e46c5a488b669359fd82d789b63452073b8c7e4c"
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
