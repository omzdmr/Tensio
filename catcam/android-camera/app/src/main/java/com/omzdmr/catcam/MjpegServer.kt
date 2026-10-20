package com.omzdmr.catcam

import java.io.BufferedReader
import java.io.File
import java.io.InputStreamReader
import java.net.ServerSocket
import java.net.Socket
import java.net.URLDecoder
import java.nio.charset.StandardCharsets
import kotlin.concurrent.thread

class MjpegServer(private val port: Int, private val filesDir: File, private val recordingDir: File) {
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
                    val client = socket?.accept() ?: break
                    thread { serve(client) }
                }
            } catch (_: Exception) {}
        }
    }

    fun updateFrame(frame: ByteArray) { latest = frame }

    private fun serve(s: Socket) {
        s.use { sock ->
            val reader = BufferedReader(InputStreamReader(sock.getInputStream(), StandardCharsets.US_ASCII))
            val first = reader.readLine() ?: return
            val parts = first.split(" ")
            if (parts.size < 2) return
            while (true) { val line = reader.readLine() ?: break; if (line.isEmpty()) break }
            val path = URLDecoder.decode(parts[1].substringBefore("?"), "UTF-8")
            when {
                path == "/" -> asset(sock)
                path == "/live.mjpeg" -> mjpeg(sock)
                path == "/snapshot.jpg" -> snapshot(sock)
                path == "/api/status" -> status(sock)
                path == "/api/recordings" -> recordings(sock)
                path.startsWith("/recordings/") -> video(sock, path.removePrefix("/recordings/"))
                else -> text(sock, "404 Not Found", "Not Found")
            }
        }
    }

    private fun asset(s: Socket) {
        val file = File(filesDir, "web/index.html")
        if (!file.isFile) { text(s, "404 Not Found", "Web UI missing"); return }
        val b = file.readBytes()
        val o = s.getOutputStream()
        o.write(("HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: " + b.size + "\r\nConnection: close\r\n\r\n").toByteArray())
        o.write(b); o.flush()
    }

    private fun mjpeg(s: Socket) {
        val o = s.getOutputStream()
        o.write("HTTP/1.1 200 OK\r\nContent-Type: multipart/x-mixed-replace; boundary=frame\r\nCache-Control: no-cache\r\nConnection: close\r\n\r\n".toByteArray())
        o.flush()
        while (running && !s.isClosed) {
            val f = latest
            if (f == null) { Thread.sleep(100); continue }
            try {
                o.write(("--frame\r\nContent-Type: image/jpeg\r\nContent-Length: " + f.size + "\r\n\r\n").toByteArray())
                o.write(f); o.write("\r\n".toByteArray()); o.flush(); Thread.sleep(120)
            } catch (_: Exception) { break }
        }
    }

    private fun snapshot(s: Socket) {
        val b = latest ?: run { text(s, "503 Service Unavailable", "No frame yet"); return }
        val o = s.getOutputStream()
        o.write(("HTTP/1.1 200 OK\r\nContent-Type: image/jpeg\r\nContent-Length: " + b.size + "\r\nCache-Control: no-store\r\nConnection: close\r\n\r\n").toByteArray())
        o.write(b); o.flush()
    }

    private fun status(s: Socket) {
        val fs = recordingDir.listFiles { f -> f.extension.lowercase() == "mp4" } ?: emptyArray()
        val bytes = fs.sumOf { it.length() }
        json(s, "{\"online\":true,\"recordings\":" + fs.size + ",\"storageBytes\":" + bytes + ",\"retentionHours\":48}")
    }

    private fun recordings(s: Socket) {
        val fs = recordingDir.listFiles { f -> f.extension.lowercase() == "mp4" }?.sortedByDescending { it.lastModified() } ?: emptyList()
        val body = buildString {
            append("[")
            fs.forEachIndexed { i, f ->
                if (i > 0) append(",")
                append("{\"name\":\"").append(f.name).append("\",\"size\":").append(f.length())
                    .append(",\"modified\":").append(f.lastModified()).append(",\"url\":\"/recordings/").append(f.name).append("\"}")
            }
            append("]")
        }
        json(s, body)
    }

    private fun video(s: Socket, name: String) {
        val file = File(recordingDir, name)
        if (!file.isFile || file.canonicalFile.parentFile != recordingDir.canonicalFile) {
            text(s, "404 Not Found", "Recording not found"); return
        }
        val o = s.getOutputStream()
        o.write(("HTTP/1.1 200 OK\r\nContent-Type: video/mp4\r\nContent-Length: " + file.length() + "\r\nAccept-Ranges: bytes\r\nConnection: close\r\n\r\n").toByteArray())
        file.inputStream().use { it.copyTo(o) }; o.flush()
    }

    private fun json(s: Socket, body: String) {
        val b = body.toByteArray(StandardCharsets.UTF_8); val o = s.getOutputStream()
        o.write(("HTTP/1.1 200 OK\r\nContent-Type: application/json; charset=utf-8\r\nContent-Length: " + b.size + "\r\nConnection: close\r\n\r\n").toByteArray())
        o.write(b); o.flush()
    }

    private fun text(s: Socket, status: String, body: String) {
        val b = body.toByteArray(StandardCharsets.UTF_8); val o = s.getOutputStream()
        o.write(("HTTP/1.1 " + status + "\r\nContent-Type: text/plain; charset=utf-8\r\nContent-Length: " + b.size + "\r\nConnection: close\r\n\r\n").toByteArray())
        o.write(b); o.flush()
    }

    fun stop() { running = false; try { socket?.close() } catch (_: Exception) {} }
}