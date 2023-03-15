import Flutter
import UIKit

public class FlutterNativePluginExamplePlugin: NSObject, FlutterPlugin, ImageViewDelegate {
  var navigationController: UINavigationController!
  var result: FlutterResult?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_native_plugin_example", binaryMessenger: registrar.messenger())
    let instance = FlutterNativePluginExamplePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    self.result = result
    if call.method == "getPlatformVersion" {
        result("iOS " + UIDevice.current.systemVersion)
    } else if call.method == "startPlatformActivity" {
        let vc = ImageViewController()
        vc.imgViewDelegate = self
//         let vc = ImageViewControllerObjC()
//         vc.plugin = self
        self.navigationController.pushViewController(vc, animated: true)
    } else {
        result(FlutterMethodNotImplemented)
    }
  }

  public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
    let controller = application.delegate?.window??.rootViewController as! FlutterViewController

    self.navigationController = UINavigationController(rootViewController: controller)
    application.delegate?.window??.rootViewController = self.navigationController
    self.navigationController.setNavigationBarHidden(true, animated: false)
    application.delegate?.window??.makeKeyAndVisible()

    return true
  }
    
  @objc public func onBack(result: Bool, sender: String) {
    setResultAndReturn(result: FlutterError(
        code: "userCancel", message: "User cancelled.", details: nil))
  }

  @objc public func onDone(result: Bool, sender: String) {
    setResultAndReturn(result: result)
  }
    
  func setResultAndReturn(result: Any) {
    if self.result != nil {
      self.result!(result)
    }
    self.navigationController?.popViewController(animated: true)
    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }
}
