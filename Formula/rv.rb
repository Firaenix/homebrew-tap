class Rv < Formula
  desc "jj-native terminal branch reviewer"
  homepage "https://github.com/Firaenix/rv"
  version "1.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v1.7.1/rv-aarch64-apple-darwin.tar.xz"
      sha256 "0e09e066e41b19cf80079e271d20adaf1027e4f0d8a5e93c6a65e0786dfccaaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v1.7.1/rv-x86_64-apple-darwin.tar.xz"
      sha256 "07f671075a99e5d1ef7aadc3db01705f65fee2811fb104c66cf43297a8777435"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v1.7.1/rv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "efcd71c9600116a780b7ddf06259ff819f3f702c0192b1098c74a828d5dfe7ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v1.7.1/rv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d1e6fa4c9d800d4557261c0eb030604421873d0174be733d139d187621e42224"
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
