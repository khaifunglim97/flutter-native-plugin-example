package com.example.flutter_native_plugin_example

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

const val KEY_START_PLATFORM_ACTIVITY = "startPlatformActivityResult"
// Referenced from https://medium.com/theotherdev-s/mastering-flutter-create-a-plugin-e81242b6065
/** FlutterNativePluginExamplePlugin */
class FlutterNativePluginExamplePlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var result: Result? = null
  private var activity: Activity? = null
  private val RESULT_CODE_START_PLATFORM_ACTIVITY = 101

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_native_plugin_example")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    this.result = result
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "startPlatformActivity") {
      val intent = Intent(activity, ImageViewActivity::class.java)
      activity?.startActivityForResult(intent, RESULT_CODE_START_PLATFORM_ACTIVITY)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (requestCode == RESULT_CODE_START_PLATFORM_ACTIVITY) {
      if (resultCode == Activity.RESULT_OK) {
        val res = data?.getBooleanExtra(KEY_START_PLATFORM_ACTIVITY, false)
        result?.success(res ?: false)
        return true
      } else if (resultCode == Activity.RESULT_CANCELED) {
        result?.error("userCancel", "User cancelled.", null)
      }
    }
    return false
  }
}
