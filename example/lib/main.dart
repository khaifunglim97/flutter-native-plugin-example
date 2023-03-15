import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_native_plugin_example/flutter_native_plugin_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const MyAppBody(),
      ),
    );
  }
}


class MyAppBody extends StatefulWidget {
  const MyAppBody({super.key});

  @override
  State<MyAppBody> createState() => _MyAppBodyState();
}

class _MyAppBodyState extends State<MyAppBody> {
  String _platformVersion = 'Unknown';
  String _platformActivity = 'Activity have not started';
  final _flutterNativePluginExamplePlugin = FlutterNativePluginExample();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _flutterNativePluginExamplePlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Running on: $_platformVersion\n'),
          ElevatedButton(
            onPressed: () async {
              try {
                final res = await _flutterNativePluginExamplePlugin.startPlatformActivity()
                    ?? false;
                setState(() {
                  _platformActivity = res ? 'Activity Succeeded!' : 'Activity Failed!';
                });
              } on PlatformException catch(e) {
                final snackBar = SnackBar(
                  content: Text('${e.code}: ${e.message}'),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            child: const Text('Start Platform Activity'),
          ),
          Text('Status: $_platformActivity'),
        ],
      ),
    );
  }
}
