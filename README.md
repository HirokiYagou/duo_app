# アプリ名
MyDUO
（俺のDUO）

# 概要
DUO3.0と言う英単語帳の学習ができます。
大きく【POST機能】と【EXERCISE機能】に別れます。
### POST機能
* SNS機能です
* SNSと学習を組み合わせることで学習効率を高めます
  * 身の回りの出来事と学習をリンクさせる
  * 他人に見られている緊張感を与える
  * 他人と共有する満足感を与える
### EXERCISE機能
* 学習機能です
* クイズ形式で単語学習ができます（私が受験生の頃から実際に続けている方法です）
  * クイズ形式で単語、センテンスの暗記ができる
  * 定着度を○×△の3段階評価で記録できる
  * ○×△の定着度を過去3回分保存できる

# 本番環境
### URL
https://duo3exercise.herokuapp.com

### テストアカウント
* Email: test@gmail.com
* password: 1qaz2wsx

# 目指した課題解決
## 誰の
* 英語学習者（学生・社会人）
## どんな問題を解決
* 勉強が思うように進められないという問題
  * 熱意ではなく仕組みで解決（by社長）
  * 学習モードは1日数十分で完結
  * 勉強とSNSを掛け合わせる
* 均等な学習機会を担保するという問題
  * 都市部でも地方でも同じチャンスを
  * 地方創生の一つ
## どこに着眼
* 勉強の仕方がわからないという人が多い
* 平等な勉強機会を与えられるオンライン学習の可能性

# DEMO

# 使用技術
## フロントエンド
### Vue3.0

## サーバーサイド


### 管理者権限を実装
* route.rbに名前空間を実装
  * 管理者権限でのみアクセス可能なtermsコントローラー
  * 管理者権限でのみ単語の新規登録・編集が可能

### APIに徹するRailsアプリ
* Termsテーブルについては拡張性に優れたAPI化
  * 登録単語を利用して誰もが新しいアプリを開発できる

# 工夫したポイント
## フロントエンド
### 全面的なSPA
全ての通信をAjaxで効率的に実装したかったのでJavaScriptのモダンなフレームワークVue.jsを独学。
昨年秋に発表されたVue3を採用したためQiitaなどに解説記事が少なく、参考書と公式リファレンスを読み込みました。
またCSRF-Tokenなど、Railsのヘルパーメソッドが自動で行っていたことを自分で設定しなければいけないため、
結果としてRailsのこともより深く学習する事ができました。
## サーバーサイド
### jsonデータの形成
RailsのサーバーサイドレンダリングではHTMLファイルに直接全てのデータを挿入できましたが（例えばcurrent_user）、
それらを全てjbuilderを駆使してjsonファイルに組み込む事でフロントのVueファイルに伝達しました。
またその時に可読性が損なわれる事がないよう、jsonデータのフォーマットとデータベースのフォーマットを統一しました。
### ウィザード形式のユーザー登録
ユーザー新規登録をする時に、セッションを利用した複数テーブルへの保存機能を実装しました。
この時にdeviseコントローラーをマニュアル設定しました。
### 単語・センテンスを登録するtermsテーブル
全てのレコードを単一テーブルで保存できるようカラム名を工夫しました。
word_idとsentence_idの二つで
* 「センテンスに単語を紐付ける」
* 「単語かセンテンスか区別する」
この2点を同時に解決できました。
### 過去3回分の成績を保存するメソッド
自分の過去の学習経験から記録の保存は過去3回分のみでよいという判断をしました。
その場合に3回以上記録が残っているものはupdate、未満の場合はcreateメソッドを実行するようなメソッド作りをしました。
メソッド内にアクティブレコードメソッドwhereを繰り返し使いつつもN+1問題を考慮するところを工夫しました。
### termsテーブルへアクセスするメソッド
テーブルとカラムを最小限にしたためアクティブレコードメソッドを組み合わせて、
リクエストに対する正しいレスポンスを返せるよう実装しました。
また可読性向上のため異なるアクションから同じメソッドを呼び出し、
引数を変えることで異なる挙動を実装しました。


# 洗い出した要件
### 管理者権限の実装
* 管理者用アカウントでしか単語の新規登録・編集ができない
### ログイン機能
* 学習者用アカウントでログインできる
* 指導者用アカウントでログインできる
* 管理者権限でログインできる
### 写真付き投稿機能
* 写真付きの投稿ができる
* 投稿を編集・削除ができる
* 一覧表示、詳細表示、ユーザーごとの詳細表示ができる
* 検索機能がある
* 登録された単語をタグとして検索できる
* 互いにコメントができる
* お気に入り機能がある
### 学習機能
* 単語、センテンスを見て意味を考えることができる
  * 日本語→英語
  * 英語→日本語
* わかったかどうかを○×△の三段階で評価できる
* 問題の隣に過去の三段階評価を表示することができる
* 英語の発音を聞くことができる

# 課題・実装予定の機能
### SPAの機能向上
* アクションごとにURL表示（以下の方法を検討中）
  * Vue-router
  * JavaScriptのHistory API
* 通信中に他の挙動を制限
  * 通信中であることを判別するパラメータの導入

### 英語の発音機能
* Google Text-to-Speech APIの利用

### テスト機能
* レッスンごとにテストを受けることができる

### 成績管理機能
* 指導者は学習者の成績を表示することができる
* 学習者はStudyplusと連携させることができる

# DB設計
## usersテーブル

| Column             | Type   | Options                       |
| ------------------ | ------ | ----------------------------- |
| username           | string | null: false, uniqueness: true |
| email              | string | null: false, uniqueness: true, case_sensitive: false |
| encrypted_password | string | null: false                   |
| last_name          | string | null: false                   |
| first_name         | string | null: false                   |
| admin      | boolean | null: false, default: false     |

### Association

- has_one :profile

- has_many :posts
- has_many :favorites

- has_many :exercises

## profileテーブル

| Column  | Type      | Options           |
| ------- | --------- | ----------------- |
| user    | reference | null: false, foreign_key: true |
| nickname | string | null: false |
| status | text |       |

### Association

- belongs_to :user, optional: true

- has_one_attach :icon
- has_one_attach :header

## postsテーブル

| Column  | Type      | Options           |
| ------- | --------- | ----------------- |
| user    | reference | null: false, foreign_key: true |
| reply_to | integer |        |
| content | text    | null: false       |

### Association

- has_one_attach :image

- belongs_to :user

- has_many :favorites, dependent: :destroy

- has_many :post_terms, dependent: :destroy
- has_many :terms, through :post_terms

## favoritesテーブル

| Column  | Type      | Options           |
| ------- | --------- | ----------------- |
| user    | reference | null: false foreign_key: true |
| post    | reference | null: false foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## exercisesテーブル

| Column  | Type      | Options           |
| ------- | --------- | ----------------- |
| user | reference | null: false, foreign_key: true |
| term | reference | null: false, foreign_key: true|
| e_or_j | integer | null: false       |
| score | integer | null: false       |

### Association

- belongs_to :user

- belongs_to :term

## termsテーブル

| Column  | Type      | Options           |
| ------- | --------- | ----------------- |
| sentence_id | integer | null: false       |
| word_id | integer | null: false       |
| lesson | integer | null: false       |
| english | string | null: false       |
| japanese | string | null: false       |

### Association

- has_many :post_terms
- has_many :posts, through :post_terms

- has_many :exercises

## post_termsテーブル

| Column  | Type      | Options           |
| ------- | --------- | ----------------- |
| user    | reference | null: false foreign_key: true |
| post    | reference | null: false foreign_key: true |

### Association

- belongs_to :post
- belongs_to :term

# ローカルでの動作方法
* 基本情報

| Name          | Version |
| ------------- | ------- |
| Ruby on Rails | 6.0.0   |
| Ruby          | 2.6.5   |
| MySQL     |   |

* gem

| Name   | Version |
| ------ | ------- |
| devise | 4.7.3  |
| bulma-rails | 0.9.1  |
| bulma-extensions-rails | 6.2.7  |
| aws-sdk-s3 | 1.87.0  |
| rspec-rails | 4.0.1 |

* npm

| Name              | Version |
| ----------------- | ------- |
| vue               | 3.0.5   |
| vue-loader        | 16.1.2  |
| @vue/compiler-sfc | 3.0.5 |
