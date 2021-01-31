# アプリ名
DUO3.0の学習と写真投稿型コミュニティをマッチさせたアプリ（仮）

# 概要
## 技術面
### Vue.jsの採用
* 全面的なSFC化（SingleFileComponent)
  * 可読性の向上
  * コンポーネント間のデータのやりとりがスムーズ
* 全面的なAjax化（ログイン機能を除く)
  * 全ての通信をAjaxにすることで完全なSPAを実現
### APIに徹するRailsアプリ
* Termsテーブルについては拡張性に優れたAPI化

## 機能面
### 写真投稿機能
* 身の回りの出来事と学習をリンクさせる
* 他人に見られている緊張感を与える
* 他人と共有する満足感を与える

### 学習機能
* クイズ形式で単語、センテンスの暗記ができる
* 定着度を○×△の3段階評価で記録できる
* 音声を再生することができる
  * Google Text-to-Speech APIの利用

### 管理者権限の実装
* 管理者用アカウントでしか単語の新規登録・編集ができない

# URL
https://duo3exercise.herokuapp.com

# テストアカウント
* Email: test@gmail.com
* password: 1qaz2wsx

# 利用方法

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

# 洗い出した要件
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


# 実装した機能の説明(GIF)

# 実装予定の機能
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

- belongs_to :user

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

- has_many :favorites

- has_many :post_terms
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
| aws-sdk-s3 | 1.87.0  |

* npm

| Name              | Version |
| ----------------- | ------- |
| vue               | 3.0.5   |
| vue-loader        | 16.1.2  |
| @vue/compiler-sfc | 3.0.5 |