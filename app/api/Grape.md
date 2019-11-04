# Grapeメモ

## Grape導入

#### Gemfileの修正とインストール

Gemfileに以下を追加

```bash:Gemfile
gem 'grape'
gem 'grape-entity'
```

そしたら `bundle install`

```bash
$ bundle install
```

#### 必要フォルダ作成

必要なファイルを作成する

- app/api
- app/api/base
- app/api/v1

#### Base::API の作成とマウント

app/api/base/api.rb を作成。

```ruby:app/api/base/api.rb
module Base
  class API < Grape::API
    # あとあと↓のようにしてAPIをマウントするが、今はV1::Rootが無いのでコメントアウトしておく。
    # mount V1::Root
  end
end
```

Base::API を config/routes.rb にてマウント。

```ruby:config/routes.rb
Rails.application.routes.draw do
  mount Base::API => '/'
end
```

rails routesコマンドで確認。base_apiの項目があればOK。

```ruby:Command
$ rails routes
# app ディレクトリ以下にあるファイルはRailsが自動で読み込んでくれるはずであるが、うまくいかない場合は以下のコマンドでspringを停止し、cacheをクリアしてから実行すると良い。
```

#### V1::Rootの作成とマウント

APIの実装は app/api/v1 ディレクトリ以下に置いていくことになる。まずは、 Base::API からマウントするためのrootファイルを作る。

また、 V1::Root 内で、各APIをマウントするのを忘れないようにする。

```ruby:app/api/v1/root.rb
module V1
  class Root < Grape::API
    version :v1
    format :json

    mount V1::Users
  end
end
```

V1::Root を作ったので、 Base::API のコメントアウト解除も忘れずに。

```ruby:app/api/base/api.rb
module Base
  class API < Grape::API
    mount V1::Root # ←コメントアウト解除
  end
end
```

#### APIの実装










