# Name
nkhkcatのメモアプリです。

# Installation
以下のコマンドをターミナルで実行して下さい
```bash
git clone https://github.com/nkhkcat/sinatra.git
```

# Usage
必要なgemをインストールし、メモアプリを起動するために、以下のコマンドをターミナルで実行してください。
```bash
cd sinatra
git checkout develop
bundle install
bundle exec ruby app.rb 
```

rubocopのチェックをしたい場合は、以下のコマンドをターミナルで実行してください。
```
rubocop
```

erblintのチェックをしたい場合は、以下のコマンドをターミナルで実行してください。
```
bundle exec erblint --lint-all
```
erblintの実行時に、以下のエラーが表示される場合は、`vendor/bundle/ruby/3.2.0/gems/rubocop-1.59.0/assets/output.html`というファイルの`<meta charset='UTF-8'/>` を `<meta charset='UTF-8'>`に修正して下さい。

```
Tag `meta` is a void element, it must end with `>` and not `/>`.
In file: vendor/bundle/ruby/3.2.0/gems/rubocop-1.59.0/assets/output.html.erb:4

1 error(s) were found in ERB files
```
