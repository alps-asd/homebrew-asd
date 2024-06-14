class Asd < Formula
  desc "Reads ALPS documents and produces a full state diagram and hyperlinked documentation."
  homepage "https://alps-asd.github.io/"
  url "https://github.com/alps-asd/app-state-diagram/releases/download/0.11.7/asd.phar"
  sha256 "baee41878bd92ac1655c6fdbe1c96e6a63b01353a61f3016dd2865d54fcb109a"
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
