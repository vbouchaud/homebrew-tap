class Keyring < Formula
  desc "Very basic cli tool to use accross various OS"
  homepage "https://github.com/vbouchaud/keyring/"
  url "https://github.com/vbouchaud/keyring", using: :git, revision: "c5aced33f1f8cea8e4d584b0fb871e41609c967b"
  version "1.0.1"
  license "MPL-2.0"

  head "https://github.com/vbouchaud/keyring", using: :git, branch: "main"

  depends_on "go" => :build

  def install
    # go version should be available through something like:
    # system("go", "version", "|", "sed", "-e", "s/go version go\([0-9]\{1,3\}\.[0-9]\{1,3\}\).*/\1/g").to_s

    ENV["CGO_ENABLED"] = "0"

    system "go", "build", "-a", "-o", "keyring",
           "-ldflags", "\
-X vbouchaud/keyring/version.APPNAME=keyring \
-X vbouchaud/keyring/version.VERSION=#{version} \
-X vbouchaud/keyring/version.GOVERSION=UNSUPPORTED \
-X vbouchaud/keyring/version.BUILDTIME=#{DateTime.now} \
-X vbouchaud/keyring/version.COMMITHASH=c5aced33f1f8cea8e4d584b0fb871e41609c967b"

    libexec.install "keyring"
    bin.install_symlink libexec/"keyring"
  end

  test do
    system bin/"keyring"
  end
end
