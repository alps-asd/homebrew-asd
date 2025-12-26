class Asd < Formula
  desc "Generates state diagrams and documentation from ALPS profiles"
  homepage "https://alps-asd.github.io/"
  url "https://github.com/alps-asd/app-state-diagram.git", branch: "2.x"
  version "2.0.0-alpha.1"
  license "MIT"

  depends_on "node@20"
  depends_on "pnpm"
  depends_on "graphviz" => :optional

  def install
    ENV.prepend_path "PATH", Formula["pnpm"].opt_bin

    # Remove packageManager field to prevent Corepack auto-install loop
    inreplace "package.json", /,?\s*"packageManager":\s*"[^"]*"/, ""

    # Use copy instead of symlinks to prevent broken links after Homebrew moves files
    system "pnpm", "install", "--package-import-method", "copy"
    system "pnpm", "run", "build"

    libexec.install Dir["*"]

    (bin/"asd").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node@20"].opt_bin}/node" "#{libexec}/packages/app-state-diagram/dist/asd.js" "$@"
    EOS
  end

  test do
    system "#{bin}/asd", "--version"
  end
end
