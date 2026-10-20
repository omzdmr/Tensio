package com.omzdmr.catcam

import java.net.NetworkInterface

object NetworkUtils {
    fun localIp(): String = findIpv4 { !it.isLoopbackAddress && it.hostAddress?.contains(':') == false }
        ?: "PHONE-IP"

    fun tailscaleIp(): String? = findIpv4 { address ->
        val host = address.hostAddress ?: return@findIpv4 false
        val parts = host.split('.')
        if (parts.size != 4) return@findIpv4 false
        val first = parts[0].toIntOrNull() ?: return@findIpv4 false
        val second = parts[1].toIntOrNull() ?: return@findIpv4 false
        first == 100 && second in 64..127
    }

    private fun findIpv4(predicate: (java.net.InetAddress) -> Boolean): String? = try {
        NetworkInterface.getNetworkInterfaces().toList()
            .flatMap { it.inetAddresses.toList() }
            .firstOrNull(predicate)
            ?.hostAddress
    } catch (_: Exception) {
        null
    }
}
