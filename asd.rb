class Asd < Formula
  desc "Reads ALPS documents and produces a full state diagram and hyperlinked documentation."
  homepage "https://alps-asd.github.io/"
  url "https://github.com/alps-asd/app-state-diagram/releases/download/0.17.0/asd.phar"
  sha256 "a8238d89d212e0b769fd9fbb4427bfb4aed5fbb5b980ffa7af924821216bad5d"
  license "MIT"

  depends_on "shivammathur/php/php@8.4"
  depends_on "node"
  depends_on "graphviz"


  def install
      # Get the PHP binary path from the dependency
      php_bin = Formula["shivammathur/php/php@8.4"].opt_bin/"php"

      # PHARファイルをlibexecにインストール
      libexec.install "asd.phar"

      # PHARファイルを解凍
      system php_bin, "-r", "(new Phar('#{libexec}/asd.phar'))->extractTo('#{libexec}');"

      # npm install の実行
      system "npm", "install", "--prefix", "#{libexec}/asd-sync"

      # alps2dot のビルド
      system "npm", "install", "--prefix", "#{libexec}/alps2dot"
      Dir.chdir("#{libexec}/alps2dot") do
        system "npm", "run", "build"
      end

      # 必要なファイルに実行権限を付与し、shebangを追加
      bin_asd = "#{libexec}/bin/asd"
      chmod 0755, bin_asd
      File.open(bin_asd, 'r+') do |file|
        content = file.read
        file.seek(0)
        file.write("#!/usr/bin/env php\n" + content)
      end

      # npmプロジェクト実行スクリプトの作成
      (bin/"asdw").write <<~EOS
        #!/bin/bash
        cd "#{libexec}/asd-sync" && npm start -- --profile "$@"
      EOS
      (bin/"asdw").chmod 0755

      # asd.phar 実行スクリプトの作成 (use shivammathur php@8.4 explicitly)
      (bin/"asd").write <<~EOS
        #!/bin/bash
        "#{Formula["shivammathur/php/php@8.4"].opt_bin}/php" "#{libexec}/asd.phar" "$@"
      EOS
      (bin/"asd").chmod 0755
    end
    test do
        system "#{bin}/asdw"
        system "#{bin}/asd"
    end
end
