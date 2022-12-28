enum ResponseEnum {
  success,
  invalid,
  noConnection,
  format,
  notModified,
  badRequest,
  serverProblem,
  timeout,
  other,
}

extension ResponseEnumExt on ResponseEnum {
  String get message {
    switch (this) {
      case ResponseEnum.success:
        return 'サーバーから情報を取得することに成功しました。';
      case ResponseEnum.invalid:
        return '無効な値が返却されました。';
      case ResponseEnum.noConnection:
        return 'インターネットに接続できませんでした';
      case ResponseEnum.format:
        return '無効な方式です。';
      case ResponseEnum.notModified:
        return '変更されていません。同じキーワードが入力されている可能性があります。';
      case ResponseEnum.badRequest:
        return '検証に失敗しました。時間をおいて再度実行してください。';
      case ResponseEnum.serverProblem:
        return '検証に失敗しました。時間をおいて再度実行してください。';
      case ResponseEnum.timeout:
        return 'タイムアウトしました。インターネットに接続してください。';
      case ResponseEnum.other:
        return '例外が発生しました。時間をおいて再度実行してください。';
    }
  }

  int get status {
    switch (this) {
      case ResponseEnum.success:
        return 200;
      case ResponseEnum.invalid:
        return 100;
      case ResponseEnum.noConnection:
        return 101;
      case ResponseEnum.format:
        return 102;
      case ResponseEnum.notModified:
        return 103;
      case ResponseEnum.badRequest:
        return 104;
      case ResponseEnum.serverProblem:
        return 105;
      case ResponseEnum.timeout:
        return 106;
      case ResponseEnum.other:
        return 107;
    }
  }
}
