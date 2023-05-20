import 'package:flutter_engineer_codecheck/application/const/enum/flavor.dart';

/// フレーバー
final flavor = _readFlavor();

/// 設定されたフレーバーを読み取る
Flavor _readFlavor() {
  const flavorString = String.fromEnvironment('flavor');
  if (flavorString == 'dev') {
    return Flavor.dev;
  } else if (flavorString == 'stg') {
    return Flavor.stg;
  } else if (flavorString == 'prd') {
    return Flavor.prd;
  } else if (flavorString == 'devStg') {
    return Flavor.devStg;
  } else {
    // 指定がないときは dev を使う
    return Flavor.dev;
  }
}