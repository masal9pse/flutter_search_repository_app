## 目次
- [環境構築](#環境構築)
- [このアプリケーションの仕様](#このアプリケーションの仕様)
- [ディレクトリ構成](#ディレクトリ構成)
- [１度目に提出したコードからの改善点](#１度目に提出したコードからの改善点)
- [その他アピールポイント](#その他アピールポイント)
- [反省点](#反省点)

## 環境構築
[こちらの記事](https://zenn.dev/altiveinc/articles/flutter-version-management#%E5%8F%82%E5%8A%A0%E3%81%97%E3%81%9F%E3%83%97%E3%83%AD%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E3%81%A7fvm%E3%81%8C%E4%BD%BF%E3%82%8F%E3%82%8C%E3%81%A6%E3%81%84%E3%81%9F%E6%99%82%E3%81%AB%E3%81%99%E3%82%8B%E3%81%93%E3%81%A8)を参考にして環境を構築しました。

<br />

### バージョン情報

```bash

$ fvm --version
2.4.1

$ fvm flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.3.10, on macOS 12.5 21G72 darwin-arm, locale ja-JP)
[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.1)
[✓] Xcode - develop for iOS and macOS (Xcode 14.2)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2021.3)
[✓] VS Code (version 1.74.2)
[✓] Connected device (3 available)
[✓] HTTP Host Availability

• No issues found!
```

### アプリの起動方法

```bash
$ cd このプロジェクトのルートディレクトリ

$ fvm install

$ fvm flutter --version
Flutter 3.3.10
Dart 2.18.6

$ fvm flutter run

```

- [目次に戻る](#目次)
<br />

<br />
<br />

## アーキテクチャー
オニオンアーキテクチャー

## このアプリケーションの仕様
DDDのメリットである[ビジネスロジック層の肥大化防止を実感したい](#https://little-hands.hatenablog.com/entry/2019/07/26/domain-knowledge)ため、ドメイン層を厚くするための仕様をいくつか追加しています。UX体験が悪くなりますが、ご理解お願いします。

### なぜこのアプリケーションが必要か
> GitHubのリポジトリを検索したいユーザーがいる。

- 夜中の3~5時はAPI検索が出来ない。
- リポジトリ名が30字を超えたらそのリポジトリだけ表示しない。
- 検索結果が30件を超えたらそれ以上表示しない。
- 10回検索したら、アプリを再起動するまで検索できなくなる。

- ユーザー
  - 夜中の3時~5時はAPI検索が出来ない。



## １度目に提出したコードからの改善点

- [１度目に提出したコード](https://github.com/masal9pse/flutter_engineer_codecheck/tree/5d222fbeba6776e10ddd66c2f05939d34d6299d7)にフィードバックいただいた部分に対して修正を行いました。

| １度目に頂いた技術的な改善点 | 修正点（特に１つ目と２つ目が今回のアピールポイント） |
|:-----------|------------:|
| 同じ例外をキャッチする処理を書いている箇所がいくつかあるので、SearchApiService で例外をキャッチした後、アプリ独自のデータに変換して以降の処理に渡すようにすると、それ以降の処理で例外をキャッチする必要がなくなり、可読性・保守性も向上するためおすすめです。  |   Result<T,E>を使用して２重例外を防ぐようにしました。      |
| Widgetが1つの大きめのbuildメソッドで組まれていて可読性がやや低い     | Atomic Designを導入してコンポーネント化のルール化をしました。
| 一覧で要素をタップしても何も起こらない     | 詳細ページに飛べるよう修正しました。
| 文言はすべて lib/const/response_message.dart に定義するか、 多言語対応も見据えての arb ファイルに記載するようにするとより保守性が向上するためおすすめです。| constファイルに記載するようにしました。|
| pedantic_monoがpubspec.yamlで指定されているのにanalysis_options.yamlでは使われておらずチグハグ    |   静的解析のパッケージをFlutter公式が提示した推奨ルールを用いているflutter_listに変更しました。   |

<br />
<br />

## その他アピールポイント
- MVVM+Serviceのアーキテクチャを採用しました。
- 例外処理をAPIReferenceを参照しながら細かく定義しました。
- mockを使用したテストコードを記載することで依存度を減らすことに成功しました。
- providerを使用した状態管理を利用することで、リビルドしたい部分のみ更新することができ、パフォーマンスの向上に繋がった気がします。
- 静的解析を導入して、不要なコードを減らしていきました。
- PR,issueテンプレートを導入して記載する内容の方針を決めました。
- 検索ボタンをタップすると検索結果が取得するまでindicatorを表示したり、正しく結果の取得できなかった際に原因を表示するなど、UXの向上をある程度意識しました。

<br />
<br />

## 反省点
- Atomic Designの粒度を曖昧にした状態で実装に入ってしまったため戻りが発生してしまった。
- issue,PRテンプレートの導入が開発の後半になってしまったこと。
- riverpodを導入できなかったこと。余裕があればそれに加えてhooks_riverpod + StateNotifierも使ってみたい。
- CIを導入できなかったこと。
- [目次に戻る](#目次)
<br />