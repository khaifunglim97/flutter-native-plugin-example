import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_plugin_example/flutter_native_plugin_example.dart';
import 'package:flutter_native_plugin_example/flutter_native_plugin_example_platform_interface.dart';
import 'package:flutter_native_plugin_example/flutter_native_plugin_example_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNativePluginExamplePlatform
    with MockPlatformInterfaceMixin
    implements FlutterNativePluginExamplePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterNativePluginExamplePlatform initialPlatform = FlutterNativePluginExamplePlatform.instance;

  test('$MethodChannelFlutterNativePluginExample is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterNativePluginExample>());
  });

  test('getPlatformVersion', () async {
    FlutterNativePluginExample flutterNativePluginExamplePlugin = FlutterNativePluginExample();
    MockFlutterNativePluginExamplePlatform fakePlatform = MockFlutterNativePluginExamplePlatform();
    FlutterNativePluginExamplePlatform.instance = fakePlatform;

    expect(await flutterNativePluginExamplePlugin.getPlatformVersion(), '42');
  });
}
