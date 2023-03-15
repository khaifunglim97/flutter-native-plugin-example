import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_native_plugin_example_method_channel.dart';

abstract class FlutterNativePluginExamplePlatform extends PlatformInterface {
  /// Constructs a FlutterNativePluginExamplePlatform.
  FlutterNativePluginExamplePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativePluginExamplePlatform _instance = MethodChannelFlutterNativePluginExample();

  /// The default instance of [FlutterNativePluginExamplePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNativePluginExample].
  static FlutterNativePluginExamplePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativePluginExamplePlatform] when
  /// they register themselves.
  static set instance(FlutterNativePluginExamplePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> startPlatformActivity() {
    throw UnimplementedError('platformActivity() has not been implemented.');
  }
}
