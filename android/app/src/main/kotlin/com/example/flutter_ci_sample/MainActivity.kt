package com.example.flutter_engineer_codecheck

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        BatteryApi.setUp(flutterEngine.dartExecutor.binaryMessenger, BatteryApiImpl(this))
    }
}
