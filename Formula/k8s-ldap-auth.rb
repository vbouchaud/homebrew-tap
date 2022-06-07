class K8sLdapAuth < Formula
  desc "Kubernetes webhook token authentication plugin implementation using ldap"
  homepage "https://github.com/vbouchaud/k8s-ldap-auth/"
  url "https://github.com/vbouchaud/k8s-ldap-auth", using: :git, revision: "ef268b9a39df600b7ce0ed2652fff71fd3063ef3"
  version "4.0.0"
  license "MPL-2.0"

  head "https://github.com/vbouchaud/k8s-ldap-auth", using: :git, branch: "master"

  depends_on "git" => :build
  depends_on "go" => :build

  def install
    ENV["VERSION"] = "4.0.0"
    ENV["COMMITHASH"] = "ef268b9a39df600b7ce0ed2652fff71fd3063ef3"
    ENV["PKG"] = "vbouchaud/k8s-ldap-auth"
    ENV["APPNAME"] = "k8s-ldap-auth"
    ENV["BUILDTIME"] = DateTime.now
    ENV["GOVERSION"] =
      system "go", "version", "|", "sed", "-e", "s/go version go\([0-9]\{1,3\}\.[0-9]\{1,3\}\).*/\1/g"

    ENV["CGO_ENABLED"] = "0"

    system "go", "build", "-a", "-o", "k8s-ldap-auth",
           "-ldflags", "-X ${PKG}/version.APPNAME=${APPNAME} \
                        -X ${PKG}/version.VERSION=${VERSION} \
                        -X ${PKG}/version.GOVERSION=${GOVERSION} \
                        -X ${PKG}/version.BUILDTIME=${BUILDTIME} \
                        -X ${PKG}/version.COMMITHASH=${COMMITHASH}"

    cp "k8s-ldap-auth", bin.to_s
  end

  test do
    system "k8s-ldap-auth"
  end
end
