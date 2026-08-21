class Rv < Formula
  desc "jj-native terminal branch reviewer"
  homepage "https://github.com/Firaenix/rv"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v1.1.0/rv-aarch64-apple-darwin.tar.xz"
      sha256 "0bdcf098048e1bf882181ea0bbaed59affb4b3d8fb1042bf669cf704d68e94b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v1.1.0/rv-x86_64-apple-darwin.tar.xz"
      sha256 "51ec79daa7b4603db9e380daf0c159bc33ff9281cfbac86da0538a85c712e3e0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v1.1.0/rv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "48099c73ce1dcb590f962d0f1bf12cbad5fd8c5badab7f4509408c5f644d7500"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v1.1.0/rv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6ed75f8fa77fab27a69a155dfb368dac2375984b568fe7caf9c134d426498cbc"
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
