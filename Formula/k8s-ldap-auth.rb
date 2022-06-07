class K8sLdapAuth < Formula
  desc "Kubernetes webhook token authentication plugin implementation using ldap"
  homepage "https://github.com/vbouchaud/k8s-ldap-auth/"
  url "https://github.com/vbouchaud/k8s-ldap-auth", using: :git, revision: "ef268b9a39df600b7ce0ed2652fff71fd3063ef3"
  version "4.0.0"
  license "MPL-2.0"

  head "https://github.com/vbouchaud/k8s-ldap-auth", using: :git, branch: "master"

  depends_on "go" => :build

  def install
    # go version should be available through something like:
    # system("go", "version", "|", "sed", "-e", "s/go version go\([0-9]\{1,3\}\.[0-9]\{1,3\}\).*/\1/g").to_s

    ENV["CGO_ENABLED"] = "0"

    system "go", "build", "-a", "-o", "k8s-ldap-auth",
           "-ldflags", "\
-X vbouchaud/k8s-ldap-auth/version.APPNAME=k8s-ldap-auth \
-X vbouchaud/k8s-ldap-auth/version.VERSION=#{version} \
-X vbouchaud/k8s-ldap-auth/version.GOVERSION=UNSUPPORTED \
-X vbouchaud/k8s-ldap-auth/version.BUILDTIME=#{DateTime.now} \
-X vbouchaud/k8s-ldap-auth/version.COMMITHASH=ef268b9a39df600b7ce0ed2652fff71fd3063ef3"

    libexec.install "k8s-ldap-auth"
    bin.install_symlink libexec/"k8s-ldap-auth"
  end

  test do
    system bin/"k8s-ldap-auth"
  end
end
