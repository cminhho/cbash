# Homebrew formula for cbash-cli (personal tap)
#
# 1. Create tap: brew tap-new <user>/homebrew-tap
# 2. Copy this file to Formula/cbash-cli.rb in the tap repo
# 3. Create a GitHub release v1.0.0, then: shasum -a 256 < path/to/v1.0.0.tar.gz
# 4. Put the sha256 in the formula below, push tap, then: brew tap <user>/tap && brew install cbash-cli

class CbashCli < Formula
  desc "Command-line tools for developers (macOS/Linux)"
  homepage "https://github.com/cminhho/cbash"
  url "https://github.com/cminhho/cbash/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "" # fill after release: curl -sL <url> | shasum -a 256
  license "MIT"
  head "https://github.com/cminhho/cbash.git", branch: "master"

  depends_on "bash"

  def install
    libexec.install Dir["*"]
    (bin/"cbash").write <<~EOS
      #!/usr/bin/env bash
      export CBASH_DIR="#{libexec}"
      exec "#{libexec}/cbash.sh" "$@"
    EOS
  end

  test do
    assert_match "USAGE", shell_output("#{bin}/cbash 2>&1")
  end
end
