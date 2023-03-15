package com.example.flutter_native_plugin_example

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.flutter_native_plugin_example.databinding.ImageViewActivityBinding

class ImageViewActivity: AppCompatActivity() {
    private lateinit var binding: ImageViewActivityBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ImageViewActivityBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)

        binding.btnDone.setOnClickListener {
            finishAndReturnResult(
                Activity.RESULT_OK,
                Intent().putExtra(KEY_START_PLATFORM_ACTIVITY, true)
            )
        }
    }

    private fun finishAndReturnResult(resultCode: Int, intent: Intent) {
        setResult(resultCode, intent)
        finish()
    }
}