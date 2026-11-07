class DepScan < Formula
  desc "Security and risk audit for project dependencies and container images"
  homepage "https://github.com/owasp-dep-scan/dep-scan"
  version "6.3.1"
  license "MIT"

  # Single-file PyInstaller builds with a bundled cdxgen, so neither Python nor Node.js is needed.
  on_macos do
    on_arm do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-darwin-arm64"
      sha256 "f79c591c5983aecbc10575ab6a0cde6c2333927d6742f488e680c5431293086f"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-darwin-amd64"
      sha256 "23bbce49b726a16d5adccc116229e10c720296743267d01589d8a486e8313bce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-linux-arm64"
      sha256 "e3835937ea8bffa74278a2f3235dfab7a6d1a0ed6b608e9040ec8876a4031f2d"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/dep-scan/releases/download/v#{version}/depscan-linux-amd64"
      sha256 "8753a0850e3e5840c532d50fb81e1f287f249f7e89146e23de832f4f5ea2f93a"
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
