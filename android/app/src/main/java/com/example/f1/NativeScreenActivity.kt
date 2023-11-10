package com.example.f1

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class NativeScreenActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native_screen)
        val serviceIntent = Intent(this, MyBackgroundService::class.java)
        startService(serviceIntent)

    }
}