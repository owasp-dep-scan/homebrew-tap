# OWASP dep-scan Homebrew Tap

Homebrew formulae for the [OWASP dep-scan](https://github.com/owasp-dep-scan) tools. A `dosai` formula follows with Dosai 5.0.0, the first release whose self-contained build analyzes source without a .NET installation.

| Formula    | Command   | Description                                                                                                     |
| ---------- | --------- | --------------------------------------------------------------------------------------------------------------- |
| `dep-scan` | `depscan` | [dep-scan](https://github.com/owasp-dep-scan/dep-scan): security and risk audit for project dependencies and container images. |
| `blint`    | `blint`   | [blint](https://github.com/owasp-dep-scan/blint): binary linter and SBOM generator for ELF, PE and Mach-O executables.          |

## Usage

```bash
brew tap owasp-dep-scan/tap
brew trust --tap owasp-dep-scan/tap   # only needed if HOMEBREW_REQUIRE_TAP_TRUST is set
brew install dep-scan blint
```

Or install one formula without tapping first, for example `brew install owasp-dep-scan/tap/dep-scan`.

## Supported platforms

macOS on Apple Silicon and Intel, and Linux (glibc) on x86_64 and arm64. Every formula installs the project's standalone release binary, which carries its own runtime: no Python, Node.js or .NET installation is needed. `dep-scan` bundles cdxgen for BOM generation.

## Updating

A scheduled workflow moves each formula to its project's latest release (prereleases are skipped). To pick up a new release:

```bash
brew update && brew upgrade dep-scan blint
```
