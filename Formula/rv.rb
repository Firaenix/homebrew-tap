class Rv < Formula
  desc "jj-native terminal branch reviewer"
  homepage "https://github.com/Firaenix/rv"
  version "2.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v2.6.0/rv-aarch64-apple-darwin.tar.xz"
      sha256 "7ac233aba2ca3652435ff138893d94b4c1ceabd9e5b067ed594b13e0c3b888dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v2.6.0/rv-x86_64-apple-darwin.tar.xz"
      sha256 "f76ef88fb40645075a89e0ba1d43ddc87823bddfda94f93cf5828161da358c81"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v2.6.0/rv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "36c92d45ef9badee646482646961413e045b463a25f37d3b3841c82b590d82c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v2.6.0/rv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "01e716fe95939e6e823773e6562323ae15f6179226b6fef156727b697a21d671"
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
