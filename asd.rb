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
      # PHARファイルをlibexecにインストール
      libexec.install "asd.phar"

      # PHARファイルを解凍
      system "php -r \"(new Phar('#{libexec}/asd.phar'))->extractTo('#{libexec}');\""

      # npm install の実行
      system "npm", "install", "--prefix", "#{libexec}/asd-sync"

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

      # asd.phar 実行スクリプトの作成
      (bin/"asd").write <<~EOS
        #!/bin/bash
        php "#{libexec}/asd.phar" "$@"
      EOS
      (bin/"asd").chmod 0755
    end
    test do
        system "#{bin}/asdw"
        system "#{bin}/asd"
    end
end
