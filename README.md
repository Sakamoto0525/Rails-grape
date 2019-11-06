# Rails-grape

grapeを使用したAPI作成学習

## 初回プロジェクト構築

以下手順でプロジェクト構築を行う

1. プロジェクト作成
2. ビルド
3. データベース設定
4. データベース作成

### プロジェクト作成
```bash
# --api : APIモードで作成
# --force : ファイルが存在する場合には上書きされる
# --database=postgresql : Dbにpostgresqlを使用
$ docker-compose run web rails new . --api --force --database=postgresql
```

### ビルド
```bash
$ docker-compose build
```

### データベース設定
```ruby:config/database.yml
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password:
  pool: 5

development:
  <<: *default
  database: myapp_development


test:
  <<: *default
  database: myapp_test
```

### データベース作成
```bash
$ docker-compose web rake db:create
```

### Docker
```bash
# 起動
$ docker-compose up
# 停止
$ docker-compose stop
```

### エラー対処

原因：Rails に付随しているWEBサーバが正常に終了していない。docker-compose kill や 何かの拍子でコンテナが終了すると起きてしまう。

pid は、開発用WEBサーバを起動するときに tmp/pids/server.pidに書き込まれ、終了するときに削除されます。
server.pid に pid が書かれていると開発用WEBサーバが起動中（プロセスがある）と判断されてしまいます。

```ruby:Error
A server is already running. Check /myapp/tmp/pids/server.pid.
```

対処：pid の情報を削除

```bash:Command
$ rm tmp/pids/server.pid
```