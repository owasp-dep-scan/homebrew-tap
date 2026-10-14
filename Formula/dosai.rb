class Dosai < Formula
  desc "Inspect .NET source and assemblies for call graphs, data flows and crypto"
  homepage "https://github.com/owasp-dep-scan/dosai"
  version "4.1.0"
  license "MIT"

  # Self-contained single-file builds: the .NET runtime is inside the executable, so no
  # `dotnet` dependency.
  on_macos do
    on_arm do
      url "https://github.com/owasp-dep-scan/dosai/releases/download/v#{version}/Dosai-osx-arm64-full"
      sha256 "032a88b5f182ae0754059a2d1eeae9a4c139d12b976a8d1b2f17ab198acdba44"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/dosai/releases/download/v#{version}/Dosai-osx-x64-full"
      sha256 "ac8cc1cde41961a1cf149c8ce419e3945b07b12466f4310a9e11fd873826e6fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/owasp-dep-scan/dosai/releases/download/v#{version}/Dosai-linux-arm64-full"
      sha256 "13baa7fe6c86278e1e7731dad6e92da7678fd4156a718b0a79cb24f7f4d7719c"
    end
    on_intel do
      url "https://github.com/owasp-dep-scan/dosai/releases/download/v#{version}/Dosai-linux-amd64-full"
      sha256 "51c91b8595c4d4eb74200fcbd039ec077e96057285d76cb60bea97fa4796d1e4"
    end
  end

  def install
    binary = Dir["Dosai-*-full"].first
    chmod 0755, binary
    bin.install binary => "dosai"
  end

  test do
    (testpath/"Program.cs").write <<~CS
      public static class Program
      {
          public static void Main(string[] args) => System.Console.WriteLine(args[0]);
      }
    CS
    system bin/"dosai", "methods", "--path", testpath/"Program.cs", "--o", testpath/"dosai.json"
    assert_match "System.Console.WriteLine", (testpath/"dosai.json").read
  end
end
