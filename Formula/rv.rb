class Rv < Formula
  desc "jj-native terminal branch reviewer"
  homepage "https://github.com/Firaenix/rv"
  version "1.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v1.6.1/rv-aarch64-apple-darwin.tar.xz"
      sha256 "5a35e2d05607574157b3d53b29a8e9ab89ceb0fe39637beea5ad72ed0d977306"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v1.6.1/rv-x86_64-apple-darwin.tar.xz"
      sha256 "bd3972e1e0e2116be78d43d38541cfab2646a1c330c95bde10c9056e7c4d7caa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v1.6.1/rv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6d2824fcebe9006f185773a767c9badfa280a7696252b13247fff51beb600bb3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v1.6.1/rv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8576d1cb971f3d202091e3cac56028b3ef15394ed5071aa3f654b53c6562c323"
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
