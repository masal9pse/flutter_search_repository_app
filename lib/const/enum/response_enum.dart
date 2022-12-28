enum ResponseEnum {
  success(message: 'サーバーから情報を取得することに成功しました。', status: 200),
  invalid(message: '無効な値が返却されました。', status: 100),
  noConnection(message: 'インターネットに接続できませんでした', status: 101),
  format(message: '無効な方式です。', status: 102),
  notModified(message: '変更されていません。同じキーワードが入力されている可能性があります。', status: 103),
  badRequest(message: '検証に失敗しました。時間をおいて再度実行してください。', status: 104),
  serverProblem(message: '検証に失敗しました。時間をおいて再度実行してください。', status: 105),
  timeout(message: 'タイムアウトしました。インターネットに接続してください。', status: 106),
  other(message: '例外が発生しました。時間をおいて再度実行してください。', status: 107);

  const ResponseEnum({required this.message, required this.status});
  final String message;
  final int status;
}
