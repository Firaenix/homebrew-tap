class Rv < Formula
  desc "jj-native terminal branch reviewer"
  homepage "https://github.com/Firaenix/rv"
  version "2.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v2.4.0/rv-aarch64-apple-darwin.tar.xz"
      sha256 "5651bc78d1e52b2012d370fbf7f19164de1d16510c0b6435cbe2205951a141e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v2.4.0/rv-x86_64-apple-darwin.tar.xz"
      sha256 "37df8a9b36bf1e6d8af08954349318f2bbabd81d81e2f1403f7015e7aa1c921c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v2.4.0/rv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "51acf11a8152b97c18f627a89703cb469b96f04d50f87559182c693d0f37a284"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v2.4.0/rv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9ac88c167d81f9ec4edb434f9c00dfd692278c33fc087eb873b7089a106ba306"
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
