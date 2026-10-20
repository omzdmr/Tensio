package com.omzdmr.catcam

import java.net.ServerSocket
import java.net.Socket
import kotlin.concurrent.thread

class MjpegServer(private val port: Int) {
    @Volatile private var running = false
    @Volatile private var latest: ByteArray? = null
    private var socket: ServerSocket? = null

    fun start() {
        if (running) return
        running = true
        thread(name = "CatCamServer") {
            try {
                socket = ServerSocket(port)
                while (running) {
                    val client = socket!!.accept()
                    thread { serve(client) }
                }
            } catch (_: Exception) { }
        }
    }

    fun updateFrame(frame: ByteArray) { latest = frame }

    private fun serve(client: Socket) {
        client.use { s ->
            val out = s.getOutputStream()
            out.write(("HTTP/1.1 200 OK\r\nContent-Type: multipart/x-mixed-replace; boundary=frame\r\n" +
                "Cache-Control: no-cache\r\nConnection: close\r\n\r\n").toByteArray())
            out.flush()
            while (running && !s.isClosed) {
                val frame = latest ?: run { Thread.sleep(100); continue }
                try {
                    out.write("--frame\r\nContent-Type: image/jpeg\r\nContent-Length: ${frame.size}\r\n\r\n".toByteArray())
                    out.write(frame); out.write("\r\n".toByteArray()); out.flush()
                    Thread.sleep(100)
                } catch (_: Exception) { break }
            }
        }
    }

    fun stop() {
        running = false
        try { socket?.close() } catch (_: Exception) {}
    }
}
