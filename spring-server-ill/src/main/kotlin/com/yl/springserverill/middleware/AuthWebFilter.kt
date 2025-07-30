package com.yl.springserverill.middleware

import com.yl.springserverill.Base
import com.yl.springserverill.token.TokenService
import org.springframework.stereotype.Component
import org.springframework.web.server.ServerWebExchange
import org.springframework.web.server.WebFilter
import org.springframework.web.server.WebFilterChain
import reactor.core.publisher.Mono
import reactor.core.scheduler.Schedulers
import java.time.LocalDateTime
import java.sql.Timestamp

@Component
class AuthWebFilter(
    private val tokenService: TokenService,
    private val base: Base
) : WebFilter {

    override fun filter(exchange: ServerWebExchange, chain: WebFilterChain): Mono<Void> {
        val rawHeader = exchange.request.headers.getFirst("Authorization") ?: ""
        println("原始头部：$rawHeader")
        val token = extractTokenStrict(rawHeader)

        val attributes = exchange.attributes

        if (token != null) {
            if (token.isNotBlank()) {
                return Mono.fromCallable {
                    try {
                        println("中间件获取到的token为：$token")
                        val decoded = tokenService.decodeToken(token)
                        val mutable = mutableMapOf<String, Any?>()
                        decoded.forEach { (k, v) -> mutable[k] = v }
                        mutable["is_login"] = true
                        val user = User(mutable)

                        // 查询 VIP 状态
                        val sql = "SELECT vip_last_date FROM users WHERE userid = ?"
                        val result = base.safeQuery(sql, listOf(user.id))
                        val now = LocalDateTime.now()

                        if (result.isNotEmpty()) {
                            val vipLastDate = (result[0]["vip_last_date"] as? Timestamp)?.toLocalDateTime()
                            if (vipLastDate == null || now.isAfter(vipLastDate)) {
                                base.executeUpdate("UPDATE users SET vip = 0, vip_last_date = NULL WHERE userid = ?", listOf(user.id))
                                user.vip = false
                            } else {
                                base.executeUpdate("UPDATE users SET vip = 1 WHERE userid = ?", listOf(user.id))
                                user.vip = true
                            }
                        }

                        attributes["loginUser"] = user
                    } catch (e: Exception) {
                        println("Token解码失败: ${e.message}")
                        attributes.remove("loginUser")
                    }
                }
                    .subscribeOn(Schedulers.boundedElastic())
                    .then(chain.filter(exchange)) // 无论成功失败都放行
            }
        }

        // 没有 token 也正常放行
        println("无token，直接放行")
        attributes.remove("loginUser")
        return chain.filter(exchange)
    }
    fun extractTokenStrict(header: String?): String? {
        if (header.isNullOrBlank()) return null

        var cleaned = header.trim()

        // 去除首尾的引号
        if (cleaned.startsWith("\"") && cleaned.endsWith("\"") && cleaned.length > 2) {
            cleaned = cleaned.substring(1, cleaned.length - 1)
        }

        val prefix = "token "
        return if (cleaned.lowercase().startsWith(prefix)) {
            val token = cleaned.substring(prefix.length).trim()
            token.ifBlank { null }
        } else {
            null
        }
    }


}

class User(private val data: MutableMap<String, Any?>) {

    val id: String
        get() = data["userid"]?.toString() ?: ""

    val username: String
        get() = data["username"]?.toString() ?: ""

    val email: String?
        get() = data["email"]?.toString()

    val phone: String?
        get() = data["phone"]?.toString()

    val sex: String?
        get() = data["sex"]?.toString()

    val avatar: String?
        get() = data["avatar"]?.toString()

    val role: String
        get() = data["role"]?.toString() ?: "user"

    var vip: Boolean
        get() = data["vip"]?.toString() == "1"
        set(value) {
            data["vip"] = if (value) "1" else "0"
        }

    val isLogin: Boolean
        get() = data["is_login"] == true

    fun get(key: String): Any? = data[key]

    override fun toString(): String = data.toString()
}
