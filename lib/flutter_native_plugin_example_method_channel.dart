import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_native_plugin_example_platform_interface.dart';

/// An implementation of [FlutterNativePluginExamplePlatform] that uses method channels.
class MethodChannelFlutterNativePluginExample extends FlutterNativePluginExamplePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_plugin_example');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> startPlatformActivity() async {
    final state = await methodChannel.invokeMethod<bool>('startPlatformActivity');
    return state;
  }
}
