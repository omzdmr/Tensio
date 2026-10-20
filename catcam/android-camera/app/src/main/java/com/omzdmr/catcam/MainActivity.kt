package com.omzdmr.catcam

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import android.os.Environment
import android.widget.TextView
import androidx.activity.ComponentActivity
import androidx.camera.core.CameraSelector
import androidx.camera.core.ImageAnalysis
import androidx.camera.core.Quality
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.camera.video.FileOutputOptions
import androidx.camera.video.FallbackStrategy
import androidx.camera.video.QualitySelector
import androidx.camera.video.Recorder
import androidx.camera.video.Recording
import androidx.camera.video.VideoCapture
import androidx.camera.video.VideoRecordEvent
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import java.io.File
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.concurrent.Executors

class MainActivity : ComponentActivity() {
    private lateinit var statusText: TextView
    private lateinit var urlText: TextView
    private var server: MjpegServer? = null
    private var capture: VideoCapture<Recorder>? = null
    private var recording: Recording? = null
    private val executor = Executors.newSingleThreadExecutor()
    private var stopping = false
    private val dir by lazy { File(getExternalFilesDir(Environment.DIRECTORY_MOVIES), "catcam").apply { mkdirs() } }

    override fun onCreate(state: Bundle?) {
        super.onCreate(state)
        setContentView(R.layout.activity_main)
        statusText = findViewById(R.id.statusText)
        urlText = findViewById(R.id.urlText)

        if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.CAMERA), 10)
        } else startCamera()
    }

    override fun onRequestPermissionsResult(code: Int, permissions: Array<out String>, results: IntArray) {
        super.onRequestPermissionsResult(code, permissions, results)
        if (code == 10 && ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) == PackageManager.PERMISSION_GRANTED) startCamera()
        else statusText.text = "Camera permission is required."
    }

    private fun installWebUi() {\n        val dir = File(filesDir, "web").apply { mkdirs() }\n        val target = File(dir, "index.html")\n        if (!target.exists()) assets.open("index.html").use { input -> target.outputStream().use { output -> input.copyTo(output) } }\n    }\n\n    private fun startCamera() {
        installWebUi()\n        server = MjpegServer(8080, filesDir, dir).also { it.start() }
        val future = ProcessCameraProvider.getInstance(this)
        future.addListener({
            try {
                val provider = future.get()
                val recorder = Recorder.Builder()
                    .setQualitySelector(QualitySelector.from(Quality.FHD, FallbackStrategy.higherQualityOrLowerThan(Quality.FHD)))
                    .build()
                capture = VideoCapture.withOutput(recorder)

                val analysis = ImageAnalysis.Builder()
                    .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                    .setOutputImageFormat(ImageAnalysis.OUTPUT_IMAGE_FORMAT_YUV_420_888)
                    .build()
                analysis.setAnalyzer(executor) { image ->
                    try { server?.updateFrame(YuvJpegAnalyzer.encode(image)) } finally { image.close() }
                }

                provider.unbindAll()
                provider.bindToLifecycle(this, CameraSelector.DEFAULT_BACK_CAMERA, capture, analysis)
                startSegment()
                statusText.text = "Camera + rolling recording running"
                urlText.text = "Open http://" + NetworkUtils.localIp() + ":8080/ on the iPhone"
            } catch (e: Exception) {
                statusText.text = "Camera failed: " + e.message
            }
        }, ContextCompat.getMainExecutor(this))
    }

    private fun startSegment() {
        if (stopping) return
        val c = capture ?: return
        cleanup()
        val name = SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date()) + ".mp4"
        val file = File(dir, name)
        val output = FileOutputOptions.Builder(file).build()
        recording = c.output.prepareRecording(this, output).start(ContextCompat.getMainExecutor(this)) { event ->
            if (event is VideoRecordEvent.Finalize) {
                recording = null
                if (!stopping && !event.hasError()) startSegment()
            }
        }
        android.os.Handler(mainLooper).postDelayed({ if (!stopping) recording?.stop() }, 5 * 60 * 1000L)
    }

    private fun cleanup() {
        val cutoff = System.currentTimeMillis() - 48 * 60 * 60 * 1000L
        dir.listFiles { f -> f.extension.lowercase(Locale.US) == "mp4" }?.forEach {
            if (it.lastModified() < cutoff) it.delete()
        }
    }

    override fun onDestroy() {
        stopping = true
        recording?.stop()
        recording = null
        server?.stop()
        executor.shutdown()
        super.onDestroy()
    }
}