package com.omzdmr.catcam

import java.net.Inet4Address
import java.net.NetworkInterface

object NetworkUtils {
    fun localIp(): String =
        findIpv4 { address, iface ->
            !address.isLoopbackAddress &&
                !iface.name.lowercase().contains("tun") &&
                !iface.name.lowercase().contains("tailscale") &&
                isPrivateLan(address)
        } ?: findIpv4 { address, _ -> !address.isLoopbackAddress && !isTailscale(address) } ?: "PHONE-IP"

    fun tailscaleIp(): String? =
        findIpv4 { address, iface ->
            isTailscale(address) || iface.name.lowercase().contains("tailscale")
        }

    private fun isPrivateLan(address: java.net.InetAddress): Boolean {
        val parts = (address.hostAddress ?: "").split('.').mapNotNull { it.toIntOrNull() }
        if (parts.size != 4) return false
        val a = parts[0]
        val b = parts[1]
        return a == 10 || (a == 172 && b in 16..31) || (a == 192 && b == 168)
    }

    private fun isTailscale(address: java.net.InetAddress): Boolean {
        if (address !is Inet4Address) return false
        val parts = (address.hostAddress ?: "").split('.').mapNotNull { it.toIntOrNull() }
        return parts.size == 4 && parts[0] == 100 && parts[1] in 64..127
    }

    private fun findIpv4(predicate: (java.net.InetAddress, NetworkInterface) -> Boolean): String? = try {
        NetworkInterface.getNetworkInterfaces().toList()
            .flatMap { iface -> iface.inetAddresses.toList().map { address -> address to iface } }
            .firstOrNull { (address, iface) -> address is Inet4Address && predicate(address, iface) }
            ?.first?.hostAddress
    } catch (_: Exception) {
        null
    }
}
