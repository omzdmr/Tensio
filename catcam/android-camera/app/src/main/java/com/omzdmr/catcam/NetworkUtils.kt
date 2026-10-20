package com.omzdmr.catcam

import java.net.NetworkInterface

object NetworkUtils {
    fun localIp(): String = try {
        NetworkInterface.getNetworkInterfaces().toList()
            .flatMap { it.inetAddresses.toList() }
            .firstOrNull { !it.isLoopbackAddress && it.hostAddress?.contains(':') == false }
            ?.hostAddress ?: "PHONE-IP"
    } catch (_: Exception) { "PHONE-IP" }
}
