package com.example.flutter_engineer_codecheck

import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // デバッグ用ログ
        Log.d("MainActivity", "onCreate called")
        println("MainActivity: onCreate called")
    }
}
