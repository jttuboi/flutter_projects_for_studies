import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

    // method channel
    let batteryChannel = FlutterMethodChannel(name: "methodChannelBatteryService", binaryMessenger: controller.binaryMessenger)
    batteryChannel.setMethodCallHandler({ 
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        guard call.method == "getNativeBatteryLevel" else {
            result(FlutterMethodNotImplemented)
            return
        }
        self.receiveBatteryLevel(result: result)
    })

    // event channel
    let eventChannel = FlutterEventChannel(name: "eventChannelBatteryService", binaryMessenger: controller.binaryMessenger)
    eventChannel.setStreamHandler(BatteryStreamHandler())

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // method channel
  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true

    if device.batteryState == UIDevice.BatteryState.unknown {
      result(FlutterError(code: "UNAVAILABLE", message: "Battery level not available.", details: nil))
    } else {
      result(Int(device.batteryLevel * 100))
    }
  }
}

// event channel
class BatteryStreamHandler: NSObject, FlutterStreamHandler {
    var events : FlutterEventSink?
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.events = events
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        batteryLevelDidChange()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.batteryLevelDidChange),
            name: UIDevice.batteryLevelDidChangeNotification,
            object: nil
        )
        
        return nil
    }                                                                                                                                                                                        

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.events = nil
        return nil
    }
    
    @objc private func batteryLevelDidChange(){
        let device = UIDevice.current
        if device.batteryState == UIDevice.BatteryState.unknown {
            self.events!(FlutterError(code: "ERROR_CODE", message: "Detailed message", details: nil))
        } else {
            let batteryLevel = Int(device.batteryLevel * 100)
            self.events!(batteryLevel)
        }
    }
} 