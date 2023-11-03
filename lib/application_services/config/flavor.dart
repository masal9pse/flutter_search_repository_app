import 'package:flutter_engineer_codecheck/application_services/const/enum/flavor.dart';

/// フレーバー
final flavor = _readFlavor();

/// 設定されたフレーバーを読み取る
Flavor _readFlavor() {
  const flavorString = String.fromEnvironment('flavor');
  if (flavorString == Flavor.dev.arg) {
    return Flavor.dev;
  } else if (flavorString == Flavor.stg.arg) {
    return Flavor.stg;
  } else if (flavorString == Flavor.prd.arg) {
    return Flavor.prd;
  } else if (flavorString == Flavor.devStg.arg) {
    return Flavor.devStg;
  } else {
    // 指定がないときは dev を使う
    return Flavor.dev;
  }
}