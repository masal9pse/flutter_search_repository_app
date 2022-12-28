## アピールポイント
1. MVVM+Serviceのアーキテクチャを採用しました。
2. 例外処理をAPIReferenceを参照しながら細かく定義しました。
3. mockを使用したテストコードを記載することで依存度を減らすことに成功しました。
4. providerを使用した状態管理を利用することで、リビルドしたい部分のみ更新することができ、パフォーマンスの向上に繋がった気がします。
5. 静的解析を導入して、不要なコードを減らしていきました。

## ディレクトリ構成
- ui
  - atoms
    - widgetの最小パーツ、またはwidgetを組み合わせてはいるもののそれをmoleculesのパーツとして使っているwidget。response_list_tile.dartやresponse_count.dartがそれに該当する。
  - molecules
    - テキストやボタンを組み合わせた最小構成
  - organisms
    - Moleculesを複数合わせたもの
  - pages
    - 実際にページにデータを入れ込んだものでユーザーが触れる状態