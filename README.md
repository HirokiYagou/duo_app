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
http://35.72.186.128/

### テストアカウント
* Email: test@gmail.com
* password: 1qaz2wsx

# 目指した課題解決
## 誰の
* 英語学習者（学生・社会人）
## どんな問題を解決
* 勉強が思うように進められないという問題
  * 熱意ではなく仕組みで解決
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
Vue3

## サーバーサイド
Ruby on Rails 6

# 工夫したポイント
## フロントエンド
### 全面的なSPA
アプリケーションの設計を考えた時に、SPAと親和性が高いと判断し全ての通信をAjaxで実装しました。
この時、効率的に実装したかったこととフロントエンドの開発にも興味があったことから
JavaScriptのモダンなフレームワークVue.jsを独学。
昨年秋に発表されたVue3を採用し、参考書と公式リファレンスを読み込みました。
### Vue.jsのシングルファイルコンポーネントの採用
可読性に優れたSFCを採用し、コンポーネント間のデータの受け渡しを柔軟に行いました。
またコンポーネント化することで投稿の表示に関するコーディング量を大幅に削減できました。
### データの送信
Railsのヘルパーメソッドが自動で行っていたCSRF-Tokenの設定やフォームの形成を自分でしなければならないため、
HTMLやセキュリティについてしっかり学ぶ事ができ、Railsのこともより深く理解する事ができました。
### 配列操作
全てのデータを保持する配列と表示させるデータを保持する配列を用意し、
JavaScriptの基本的な配列操作で全てのアクションを実装しました。
### トップページ
トップページのデザインについて多くのWebページを参考にしながらユーザーにストレスを与えずに
伝えたいことを伝えるにはどうするべきか考えました。
具体的にはアニメーション、カルーセルやモーダルなどメリット・デメリットをよく考えてページを構成しました。
## サーバーサイド
### APIに徹するRailsアプリ
この単語帳の優れた点は様々な学習方法を取り入れる事ができる点です。
単語帳が本来的に持っている拡張性を損なう事がないよう
APIに徹することでアプリケーションにも拡張性を持たせる事ができました。
これによりこの単語帳を愛する全ての人が
登録単語を利用して新しいアプリを開発できるようにしました。
### 管理者権限を実装
上記の通りtermsテーブルへのアクセスを開放している一方で
データの登録・編集には管理者権限のあるユーザーのみができるようにしました。
方法として、以下の3通りを実装しています。
* usersテーブルにadminカラムを用意
* route.rbに名前空間を実装しその中にコントローラーを配置
* コントローラーでも管理者か否かチェックする
### termsテーブルの設計
全てのレコードを単一テーブルで保存できるようカラム名を工夫しました。
word_idとsentence_idの二つで
* 「センテンスに単語を紐付ける」
* 「単語かセンテンスか区別する」
この2点を同時に解決できました。
### termsテーブルへアクセスするメソッド
テーブルとカラムを最小限にしたためアクティブレコードメソッドを組み合わせて、
リクエストに対する正しいレスポンスを返せるよう実装しました。
また可読性向上のため異なるアクションから同じメソッドを呼び出し、
引数を変えることで異なる挙動を実装しました。
### jsonデータの形成
Railsのサーバーサイドレンダリングでは便利なヘルパーメソッドを駆使してHTMLファイルに直接全てのデータを挿入できましたが（例えばcurrent_user）、
それらを全てjbuilderを駆使してjsonファイルに組み込む事でフロントに伝達しました。
またその時に可読性が損なわれる事がないよう、jsonデータのフォーマットとデータベースのフォーマットを統一しました。
### ウィザード形式のユーザー登録
ユーザー新規登録をする時に、セッションを利用した複数テーブルへの保存機能を実装しました。
この時にdeviseコントローラーをマニュアル設定しました。
### 過去3回分の成績を保存するメソッド
自分の過去の学習経験から記録の保存は過去3回分のみでよいという判断をしました。
その場合に3回以上記録が残っているものはupdate、未満の場合はcreateメソッドを実行するようなメソッド作りをしました。
メソッド内にアクティブレコードメソッドwhereを繰り返し使いつつもN+1問題を考慮するところを工夫しました。


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
