# Homebrew formula for cbash-cli
# Copy to: https://github.com/cminhho/homebrew-tap → Formula/cbash-cli.rb
# After each release: update url + sha256 (see .github/workflows/release.yml output)

class CbashCli < Formula
  desc "Command-line tools for developers (macOS/Linux)"
  homepage "https://github.com/cminhho/cbash"
  url "https://github.com/cminhho/cbash/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "REPLACE_AFTER_RELEASE"
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

  def caveats
    <<~EOS
      Optional: add to ~/.zshrc for aliases and plugins (CBASH_DIR is set automatically):
        source "#{opt_libexec}/cbash.sh"
    EOS
  end

  test do
    assert_match "USAGE", shell_output("#{bin}/cbash 2>&1")
  end
end
