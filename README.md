Ziita
=====

概要
--
技術ブログサービス  
* レスポンシブデザイン対応
* 自動下書き保存
* Markdown対応
* Preview機能
* Twitter/GitHub認証

  
  
バージョン情報
--
Ruby 2.2.0  
Rails 4.2.0  
node.js 0.10 以上  
Bower 1.3 以上  
  
  
環境構築
--

#### OSX

```
$ brew install mysql
$ brew install redis
$ brew install node
$ brew install libxml2
$ brew install libxslt
$ sudo npm install -g bower
```

#### Ubuntu

```
$ sudo apt-get -y install software-properties-common python-software-properties
$ sudo add-apt-repository -y ppa:brightbox/ruby-ng
$ sudo add-apt-repository -y ppa:ondrej/mysql-5.6
$ sudo add-apt-repository -y ppa:chris-lea/redis-server
$ sudo add-apt-repository -y ppa:chris-lea/node.js
$ sudo apt-get update
$ sudo apt-get -y install ruby2.2-dev mysql-server-5.6 libmysqlclient-dev
$ sudo apt-get -y install redis-server nodejs git libxml2-dev libxslt-dev
$ sudo npm install -g bower
$ sudo gem install bundler
```

Bower
--

```
$ bin/bundle
$ bower install # Bower パッケージ群をインストールする
$ bower prune   # 使われていない Bower パッケージ群を削除する
$ bin/rake db:setup
```

テスト
--
`bin/rspec spec/`  

このリポジトリにないファイル
--
`config/application.yml`  
`config/deploy.rb`  
`config/deploy/production.rb`  
`config/environments/production.rb`  
`config/initializers/google_analytics.rb`  

環境によって違うファイル
--
`config/secrets.yml`  
`config/database.yml`  

動作環境
--
#### OS
Ubuntu 14.04.1 LTS  
#### WEBサーバ
nginx/1.6.2  
#### Rackアプリケーションサーバ
unicorn v4.7.0  
