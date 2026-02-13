# Homebrew formula (tap from this repo). Users: brew tap cminhho/cbash https://github.com/cminhho/cbash && brew install cbash-cli
# On new release: update url + sha256 (curl -sL <url> | shasum -a 256)

class CbashCli < Formula < Formula
  desc "Command-line tools for developers (macOS/Linux)"
  homepage "https://github.com/cminhho/cbash"
  url "https://github.com/cminhho/cbash/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "a4ae1b79853fb63916aa4494fcb04ccf7e75d58384c298dac9695674ac6c31a4"
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
