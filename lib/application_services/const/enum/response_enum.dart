enum ResponseEnum {
  notYetSearched(message: '検索したいキーワードを入力してください。'),
  success(message: 'サーバーから情報を取得することに成功しました。'),
  invalid(message: '無効な値が返却されました。'),
  noConnection(message: 'インターネットに接続できませんでした'),
  format(message: '無効な方式です。'),
  notModified(message: '変更されていません。同じキーワードが入力されている可能性があります。'),
  badRequest(message: '検証に失敗しました。時間をおいて再度実行してください。'),
  serverProblem(message: '検証に失敗しました。時間をおいて再度実行してください。'),
  timeout(message: 'タイムアウトしました。インターネットに接続してください。'),
  other(message: '例外が発生しました。時間をおいて再度実行してください。'),
  nullData(message: '検索データを取得できませんでした。'),
  zeroData(message: 'データが一件も取得できませんでした。');

  const ResponseEnum({required this.message});
  final String message;
}
