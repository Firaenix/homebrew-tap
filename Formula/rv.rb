class Rv < Formula
  desc "jj-native terminal branch reviewer"
  homepage "https://github.com/Firaenix/rv"
  version "2.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v2.1.0/rv-aarch64-apple-darwin.tar.xz"
      sha256 "ea25ca8d08d9b6d63d661f742b3b290b6da6d23cc2e37f94cbbeecb4c6de581c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v2.1.0/rv-x86_64-apple-darwin.tar.xz"
      sha256 "549f8581353ea2d3aa18d25baf360359f007fe80e150fbfa785f560e74ef6a8e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v2.1.0/rv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "67141ed660d91785321ec4e4c3de408df0a1bb25d882d470fb80c04f4fae5bb0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v2.1.0/rv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "72c7c3cacc7b69f568ad5c59efa7773963d8ff9db99771a1b54b72a5164e564a"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]
  depends_on "difftastic"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "rv"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rv"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rv"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rv"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
