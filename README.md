# 画像管理

## 概要

## バージョン情報

Lang/OSS | Version
------------ | -------------
Ruby|2.6.5
Rails|6.0.6
mysql|5.7.35
node|v14.15.1
yarn|1.17.3

## ローカル構築手順

```
$ git clone ~
$ cd ~
$ bundle install
```

### DB設定
```
$ cp config/database.yml.default config/database.yml
$ vi config/database.yml

development:
  <<: *default
  database: xxxxxxxxx
  username: root
  password:
  host: localhost

↑この辺りを自分の環境に合わせて編集

上記で指定したデータベースを作成後・・・
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rails db:seed
```

### 起動
```
$ bundle exec rails s
```

### ユーザーログイン情報
```
user_id: testuser_1
password: password
```

### かかった時間: 6-7時間
