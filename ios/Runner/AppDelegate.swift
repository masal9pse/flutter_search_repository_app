import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryApi = BatteryApiImplementation()
    BatteryApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: batteryApi)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class BatteryApiImplementation: NSObject, BatteryApi {
  func getBatteryLevel() -> BatteryInfo {
    UIDevice.current.isBatteryMonitoringEnabled = true
    let level = Int64(UIDevice.current.batteryLevel * 100)
    return BatteryInfo(level: level)
  }
}
