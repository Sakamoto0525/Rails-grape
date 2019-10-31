# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## 初回プロジェクト構築

以下手順でプロジェクト構築を行う

1. プロジェクト作成
2. ビルド
3. データベース設定
4. データベース作成

### プロジェクト作成
```bash
# --api : APIモードで作成
# --force --database=postgresql : Dbにpostgresqlを使用
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