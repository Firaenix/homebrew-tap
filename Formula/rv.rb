class Rv < Formula
  desc "jj-native terminal branch reviewer"
  homepage "https://github.com/Firaenix/rv"
  version "2.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v2.2.0/rv-aarch64-apple-darwin.tar.xz"
      sha256 "44e0456e2d6c6880010c1dad808956d3df198c6df7c8fc6ff033fd099a4d9520"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v2.2.0/rv-x86_64-apple-darwin.tar.xz"
      sha256 "c8b428844e02b27b97845f82defa25ef069cdea3fe4755aa4103e643d01c3c2a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v2.2.0/rv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c203d433ad14afd095b004d9de0c66f22608600c525f068480ac3bf00040147b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v2.2.0/rv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "209c3112f0f61c0aec8a4096693bdf6e385c08711b110ed2859eee707d898741"
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
