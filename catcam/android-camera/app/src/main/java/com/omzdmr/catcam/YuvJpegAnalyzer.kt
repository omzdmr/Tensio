package com.omzdmr.catcam

import android.graphics.ImageFormat
import android.graphics.Rect
import android.graphics.YuvImage
import androidx.camera.core.ImageAnalysis
import androidx.camera.core.ImageProxy
import java.io.ByteArrayOutputStream

class YuvJpegAnalyzer(private val onFrame: (ByteArray) -> Unit) : ImageAnalysis.Analyzer {
    override fun analyze(image: ImageProxy) {
        try {
            onFrame(encode(image))
        } finally {
            image.close()
        }
    }

    companion object {
        fun encode(image: ImageProxy): ByteArray {
            val nv21 = yuv420ToNv21(image)
            val yuv = YuvImage(nv21, ImageFormat.NV21, image.width, image.height, null)
            val output = ByteArrayOutputStream()
            yuv.compressToJpeg(Rect(0, 0, image.width, image.height), 70, output)
            return output.toByteArray()
        }

        private fun yuv420ToNv21(image: ImageProxy): ByteArray {
            val y = image.planes[0]
            val u = image.planes[1]
            val v = image.planes[2]
            val width = image.width
            val height = image.height
            val out = ByteArray(width * height * 3 / 2)

            val yBytes = ByteArray(y.buffer.remaining()).also { y.buffer.get(it) }
            var pos = 0
            for (row in 0 until height) {
                for (col in 0 until width) {
                    val i = row * y.rowStride + col * y.pixelStride
                    if (i < yBytes.size) out[pos++] = yBytes[i]
                }
            }

            val uBytes = ByteArray(u.buffer.remaining()).also { u.buffer.get(it) }
            val vBytes = ByteArray(v.buffer.remaining()).also { v.buffer.get(it) }
            for (row in 0 until height / 2) {
                for (col in 0 until width / 2) {
                    val ui = row * u.rowStride + col * u.pixelStride
                    val vi = row * v.rowStride + col * v.pixelStride
                    if (ui < uBytes.size && vi < vBytes.size) {
                        out[pos++] = vBytes[vi]
                        out[pos++] = uBytes[ui]
                    }
                }
            }
            return out
        }
    }
}
