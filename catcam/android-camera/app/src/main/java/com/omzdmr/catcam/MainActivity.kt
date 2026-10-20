package com.omzdmr.catcam

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.provider.Settings
import android.widget.Button
import android.widget.TextView
import androidx.activity.ComponentActivity
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat

class MainActivity : ComponentActivity() {
    private lateinit var statusText: TextView
    private lateinit var urlText: TextView

    private val cameraPermission = registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { granted ->
        if (granted) startCameraService()
        else statusText.text = "Kamera izni gerekli."
    }

    override fun onCreate(state: Bundle?) {
        super.onCreate(state)
        setContentView(R.layout.activity_main)
        statusText = findViewById(R.id.statusText)
        urlText = findViewById(R.id.urlText)

        findViewById<Button>(R.id.startButton).setOnClickListener { ensureCameraPermissionAndStart() }
        findViewById<Button>(R.id.batteryButton).setOnClickListener { openBatterySettings() }
        findViewById<Button>(R.id.stopButton).setOnClickListener { stopCameraService() }

        ensureCameraPermissionAndStart()
    }

    private fun ensureCameraPermissionAndStart() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) ==
            PackageManager.PERMISSION_GRANTED) {
            startCameraService()
        } else {
            cameraPermission.launch(Manifest.permission.CAMERA)
        }
    }

    private fun startCameraService() {
        val intent = Intent(this, CameraService::class.java).setAction(CameraService.ACTION_START)
        ContextCompat.startForegroundService(this, intent)
        statusText.text = "Kamera çalışıyor. Ekranı kapatabilirsin."
        urlText.text = "iPhone: http://${NetworkUtils.localIp()}:8080/"
    }

    private fun stopCameraService() {
        stopService(Intent(this, CameraService::class.java))
        statusText.text = "Kamera durduruldu."
    }

    private fun openBatterySettings() {
        try {
            startActivity(
                Intent(
                    Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS,
                    Uri.parse("package:$packageName")
                )
            )
        } catch (_: Exception) {
            startActivity(Intent(Settings.ACTION_IGNORE_BATTERY_OPTIMIZATION_SETTINGS))
        }
    }
}
