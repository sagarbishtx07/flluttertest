package com.example.f1

import android.content.Intent
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "sample.flutter.dev/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL).setMethodCallHandler { call, result ->
            if(call.method =="getNativeMessage"){
                Log.d("Native Code","Channel1")
                val intent: Intent = Intent(this,NativeScreenActivity::class.java)
                startActivity(intent)
                val message = getNativeMessage()
                result.success(message)
            }
            else
                result.notImplemented()
        }
    }
    private fun getNativeMessage():String{
        return "Hello From Andorid"
    }

}
