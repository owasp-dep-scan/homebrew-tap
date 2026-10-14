#!/usr/bin/env python3
"""Moves formulae to their upstream's latest GitHub release.

Each formula names its release assets in url lines of the form
`https://github.com/<owner>/<repo>/releases/download/v#{version}/<asset>`, each followed by its
sha256 line. The sha256 comes from the release's asset digest, or from hashing the asset when
GitHub has no digest for it. Prints `<formula> <version>` for every formula it changed.

Usage: update_formula.py Formula/<name>.rb [...]   (needs an authenticated `gh`)
"""

import hashlib
import json
import re
import subprocess
import sys
import urllib.request
from pathlib import Path

URL = re.compile(r'^\s*url "https://github\.com/([^/]+/[^/]+)/releases/download/v#\{version\}/([^"]+)"\s*$')
SHA256 = re.compile(r'^(\s*)sha256 "[0-9a-f]*"\s*$')
VERSION = re.compile(r'^  version "([^"]*)"$', re.MULTILINE)


def latest_release(repo):
    result = subprocess.run(["gh", "api", f"repos/{repo}/releases/latest"], check=True, capture_output=True, text=True)
    return json.loads(result.stdout)


def hash_download(url):
    digest = hashlib.sha256()
    with urllib.request.urlopen(url) as response:
        for chunk in iter(lambda: response.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def asset_sha256(asset):
    digest = asset.get("digest") or ""
    if digest.startswith("sha256:"):
        return digest.removeprefix("sha256:")
    return hash_download(asset["browser_download_url"])


def update(formula):
    text = formula.read_text()
    lines = text.splitlines(keepends=True)
    repos = {match.group(1) for line in lines if (match := URL.match(line))}
    if len(repos) != 1:
        sys.exit(f"{formula}: expected release urls from one repository, found {sorted(repos)}")
    repo = repos.pop()
    release = latest_release(repo)
    tag = release["tag_name"]
    if not tag.startswith("v"):
        sys.exit(f"{formula}: latest {repo} release {tag} is not a v<version> tag")
    version = tag.removeprefix("v")
    current = VERSION.search(text)
    if current is None:
        sys.exit(f"{formula}: no version line")
    if current.group(1) == version:
        return None

    assets = {asset["name"]: asset for asset in release["assets"]}
    updated = []
    pending = None
    for line in lines:
        if match := URL.match(line):
            name = match.group(2)
            if name not in assets:
                sys.exit(f"{formula}: {repo} {tag} has no asset {name}")
            pending = asset_sha256(assets[name])
        elif pending is not None and (match := SHA256.match(line)):
            line = f'{match.group(1)}sha256 "{pending}"\n'
            pending = None
        updated.append(line)
    if pending is not None:
        sys.exit(f"{formula}: a url line has no sha256 line after it")
    formula.write_text(VERSION.sub(f'  version "{version}"', "".join(updated), count=1))
    return version


def main():
    for path in sys.argv[1:]:
        formula = Path(path)
        if version := update(formula):
            print(formula.stem, version)


if __name__ == "__main__":
    main()
