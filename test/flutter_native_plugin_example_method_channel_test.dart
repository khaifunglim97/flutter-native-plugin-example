import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_plugin_example/flutter_native_plugin_example_method_channel.dart';

void main() {
  MethodChannelFlutterNativePluginExample platform = MethodChannelFlutterNativePluginExample();
  const MethodChannel channel = MethodChannel('flutter_native_plugin_example');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
