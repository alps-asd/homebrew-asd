class Asd < Formula
  desc "Reads ALPS documents and produces a full state diagram and hyperlinked documentation."
  homepage "https://alps-asd.github.io/"
  url "https://github.com/alps-asd/app-state-diagram/archive/refs/tags/0.11.0.tar.gz"
  sha256 "6fac52fde2081e935c05f11b93baee640a3e68ff2b0ed5728f862d2f7bcff1ec"
  license "MIT"

  depends_on "php@8.3"
  depends_on "composer" => :build
  depends_on "node"

  def install
     system "composer", "install"
     bin.install "bin/asd"
  end

  test do
      assert_match "Expected output", shell_output("#{bin}/asd")
  end
end
