class Rv < Formula
  desc "jj-native terminal branch reviewer"
  homepage "https://github.com/Firaenix/rv"
  version "1.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v1.7.0/rv-aarch64-apple-darwin.tar.xz"
      sha256 "028f7edfdf8bc6a07e051a97901662d3d6b9e17c5bb87aebe6c4d79933871617"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v1.7.0/rv-x86_64-apple-darwin.tar.xz"
      sha256 "77a43a7e5201954e56519ac65caed674ac81ebf83a0e6be62765cb89725e7d09"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Firaenix/rv/releases/download/v1.7.0/rv-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fd1453f3b29455b13a1a9552820c576550b3cb07839e4236e382f6e2bb4e91f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Firaenix/rv/releases/download/v1.7.0/rv-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "073cb4f69418bdce9a0ae0c4a7535e7ea3f291a15a118c3aa459145ff4606901"
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
