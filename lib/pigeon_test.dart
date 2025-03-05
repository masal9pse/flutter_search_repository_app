import 'package:pigeon/pigeon.dart';

class BatteryInfo {
  int level;
  BatteryInfo(this.level);
}

@HostApi()
abstract class BatteryApi {
  BatteryInfo getBatteryLevel();
}