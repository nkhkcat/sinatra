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
