### 動作
* 何かしらのキーワードを入力できる
* 入力したキーワードで GitHub のリポジトリを検索できる
* 検索結果は一覧で概要（リポジトリ名）を表示する
* 検索結果のアイテムをタップしたら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue
  数）を表示する

### アプリの起動方法

```bash

```

### コマンド
- テストコードのカバレッジ率を確認する
https://tech.andpad.co.jp/entry/2020/11/17/170000#%E3%82%AB%E3%83%90%E3%83%AC%E3%83%83%E3%82%B8%E3%81%AE%E8%A6%8B%E3%81%88%E3%82%8B%E5%8C%96

```bash
$ fvm flutter test --coverage
$ brew install lcov
$ genhtml coverage/lcov.info -o coverage/html

```