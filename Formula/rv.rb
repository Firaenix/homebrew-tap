class Rv < Formula
  desc "jj-native terminal branch reviewer"
  homepage "https://github.com/Firaenix/rv"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v2.0.0/rv-aarch64-apple-darwin.tar.xz"
      sha256 "f2ef118151c2851f8b0a416d5969d9f277bdc000fce7a5139c0ebcb93ac2c3ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v2.0.0/rv-x86_64-apple-darwin.tar.xz"
      sha256 "9f7484fe8389755c15bad1baa96e25292676be96edf435fed62deb3f1b552e81"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v2.0.0/rv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7fa082d34f95b52b47eb8ee17027567564669dae6f194a92a7777d799b952f5e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v2.0.0/rv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7623c987fc3d5d6b8aeb338cb46925fe9a7f49b0761c06372243bfbe3b1c0c5b"
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
