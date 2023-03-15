import 'flutter_native_plugin_example_platform_interface.dart';

class FlutterNativePluginExample {
  Future<String?> getPlatformVersion() {
    return FlutterNativePluginExamplePlatform.instance.getPlatformVersion();
  }

  Future<bool?> startPlatformActivity() {
    return FlutterNativePluginExamplePlatform.instance.startPlatformActivity();
  }
}
