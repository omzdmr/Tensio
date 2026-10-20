package com.omzdmr.catcam

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.Environment
import androidx.camera.core.CameraSelector
import androidx.camera.core.ImageAnalysis
import androidx.camera.core.Quality
import androidx.camera.lifecycle.LifecycleService
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.camera.video.FallbackStrategy
import androidx.camera.video.FileOutputOptions
import androidx.camera.video.QualitySelector
import androidx.camera.video.Recorder
import androidx.camera.video.Recording
import androidx.camera.video.VideoCapture
import androidx.camera.video.VideoRecordEvent
import androidx.core.app.NotificationCompat
import androidx.core.app.ServiceCompat
import androidx.core.content.ContextCompat
import java.io.File
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import java.util.concurrent.Executors

class CameraService : LifecycleService() {
    companion object {
        const val ACTION_START = "com.omzdmr.catcam.START"
        private const val CHANNEL_ID = "catcam_camera"
        private const val NOTIFICATION_ID = 1001
    }

    private var server: MjpegServer? = null
    private var capture: VideoCapture<Recorder>? = null
    private var recording: Recording? = null
    private val executor = Executors.newSingleThreadExecutor()
    private var stopping = false

    private val recordingDir by lazy {
        File(getExternalFilesDir(Environment.DIRECTORY_MOVIES) ?: filesDir, "catcam").apply { mkdirs() }
    }

    override fun onCreate() {
        super.onCreate()
        createChannel()
        val type = if (Build.VERSION.SDK_INT >= 29) ServiceInfo.FOREGROUND_SERVICE_TYPE_CAMERA else 0
        ServiceCompat.startForeground(this, NOTIFICATION_ID, notification(), type)
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (server == null) startCamera()
        return START_STICKY
    }

    private fun startCamera() {
        server = MjpegServer(8080, filesDir, recordingDir).also { it.start() }
        val future = ProcessCameraProvider.getInstance(this)
        future.addListener({
            try {
                val provider = future.get()
                val qualityIndex = getSharedPreferences("catcam", MODE_PRIVATE).getInt("quality", 4)
                val selectedQuality = when (qualityIndex) {
                    0, 1, 2 -> Quality.SD
                    3 -> Quality.HD
                    5 -> Quality.UHD
                    else -> Quality.FHD
                }
                val liveSize = when (qualityIndex) {
                    0 -> android.util.Size(426, 240)
                    1 -> android.util.Size(640, 360)
                    2 -> android.util.Size(854, 480)
                    3 -> android.util.Size(1280, 720)
                    5 -> android.util.Size(3840, 2160)
                    else -> android.util.Size(1920, 1080)
                }

                val recorder = Recorder.Builder()
                    .setQualitySelector(
                        QualitySelector.from(
                            selectedQuality,
                            FallbackStrategy.higherQualityOrLowerThan(selectedQuality)
                        )
                    ).build()
                capture = VideoCapture.withOutput(recorder)

                val analysis = ImageAnalysis.Builder()
                    .setTargetResolution(liveSize)
                    .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                    .setOutputImageFormat(ImageAnalysis.OUTPUT_IMAGE_FORMAT_YUV_420_888)
                    .build()

                analysis.setAnalyzer(executor) { image ->
                    try { server?.updateFrame(YuvJpegAnalyzer.encode(image)) }
                    finally { image.close() }
                }

                provider.unbindAll()
                provider.bindToLifecycle(this, CameraSelector.DEFAULT_BACK_CAMERA, capture, analysis)
                startSegment()
            } catch (_: Exception) {
                stopEverything()
            }
        }, ContextCompat.getMainExecutor(this))
    }

    private fun startSegment() {
        if (stopping) return
        val c = capture ?: return
        cleanup()
        val file = File(
            recordingDir,
            SimpleDateFormat("yyyyMMdd_HHmmss", Locale.US).format(Date()) + ".mp4"
        )
        recording = c.output
            .prepareRecording(this, FileOutputOptions.Builder(file).build())
            .start(ContextCompat.getMainExecutor(this)) { event ->
                if (event is VideoRecordEvent.Finalize) {
                    recording = null
                    if (!stopping && !event.hasError()) startSegment()
                }
            }

        android.os.Handler(mainLooper).postDelayed(
            { if (!stopping) recording?.stop() },
            5 * 60 * 1000L
        )
    }

    private fun cleanup() {
        val cutoff = System.currentTimeMillis() - 48 * 60 * 60 * 1000L
        recordingDir.listFiles { f ->
            f.extension.lowercase(Locale.US) == "mp4"
        }?.forEach {
            if (it.lastModified() < cutoff) it.delete()
        }
    }

    private fun stopEverything() {
        stopping = true
        recording?.stop()
        recording = null
        server?.stop()
        server = null
        executor.shutdown()
        stopForeground(STOP_FOREGROUND_REMOVE)
        stopSelf()
    }

    private fun createChannel() {
        if (Build.VERSION.SDK_INT >= 26) {
            getSystemService(NotificationManager::class.java).createNotificationChannel(
                NotificationChannel(
                    CHANNEL_ID,
                    "CatCam camera",
                    NotificationManager.IMPORTANCE_LOW
                )
            )
        }
    }

    private fun notification() =
        NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.ic_menu_camera)
            .setContentTitle("CatCam")
            .setContentText("Kamera arka planda çalışıyor")
            .setOngoing(true)
            .build()

    override fun onDestroy() {
        if (!stopping) {
            stopping = true
            recording?.stop()
            server?.stop()
        }
        executor.shutdown()
        super.onDestroy()
    }
}
