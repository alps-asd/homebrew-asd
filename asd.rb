class Asd < Formula
  desc "Reads ALPS documents and produces a full state diagram and hyperlinked documentation."
  homepage "https://alps-asd.github.io/"
  url "https://github.com/alps-asd/app-state-diagram/releases/download/0.11.6/asd.phar"
  sha256 ""
  license "MIT"

  depends_on "php@8.3"
  depends_on "composer" => :build
  depends_on "node"

  def install
     bin.install "asd.phar"
     mv bin/"asd.phar", bin/"asd"
  end

  test do
      assert_match "Expected output", shell_output("#{bin}/asd")
  end
end
