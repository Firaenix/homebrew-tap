class Rv < Formula
  desc "jj-native terminal branch reviewer"
  homepage "https://github.com/Firaenix/rv"
  version "1.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v1.5.0/rv-aarch64-apple-darwin.tar.xz"
      sha256 "54d470f8ebd9ac0326002c827cdfc184c946e7a045991da78bfd61787b167eab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v1.5.0/rv-x86_64-apple-darwin.tar.xz"
      sha256 "83eef3a492d0c14d792492f2d2d757bffe352b8e685c97b7e17825b4d70a1f7b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v1.5.0/rv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "78ec108c8c3e8de4c11e13fd984fca3bf6dc0e0cab3aa15264445a0f35cbea82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v1.5.0/rv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "aaa82c9f246e68a59fef713c4cfbc2f11456d4111df924e030c3d1bc1c513365"
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
