class Asd < Formula
  desc "Generates state diagrams and documentation from ALPS profiles"
  homepage "https://alps-asd.github.io/"
  url "https://github.com/alps-asd/app-state-diagram.git", branch: "v2-suite"
  version "2.0.0-dev"
  license "MIT"

  depends_on "node@18"
  depends_on "pnpm"
  depends_on "graphviz" => :optional  # Better multibyte character support in SVG output

  def install
    system "pnpm", "install"
    system "pnpm", "build"

    libexec.install Dir["*"]

    (bin/"asd").write <<~EOS
      #!/bin/bash
      exec node "#{libexec}/packages/cli/dist/asd.js" "$@"
    EOS
  end

  test do
    system "#{bin}/asd", "--version"
  end
end
