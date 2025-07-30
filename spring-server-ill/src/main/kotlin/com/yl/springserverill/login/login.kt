package com.yl.springserverill.login

import com.yl.springserverill.Base
import com.yl.springserverill.token.TokenService
import org.springframework.stereotype.Component
import org.springframework.web.reactive.function.server.ServerRequest
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.bodyToMono
import reactor.core.publisher.Mono
import reactor.core.scheduler.Schedulers

@Component
class LoginSerVice(var base: Base, private val tokenService: TokenService) {

    fun login(res: ServerRequest): Mono<ServerResponse> {
        return res.bodyToMono<Map<String, Any>>()
            .flatMap { body ->
                val key = body["key"]?.toString()?.trim().orEmpty()
                val password = body["password"]?.toString()?.trim().orEmpty()

                if (key.isEmpty() || password.isEmpty()) {
                    return@flatMap ServerResponse.status(400)
                        .bodyValue(mapOf("message" to "参数错误", "code" to 400))
                }

                val sql = """
                    select username,user_self_introduction,birthday,userid,user_avatar,
                     user_back_img,sex,phone,email,select_work,vip,account_status,
                      role,vip_last_date,user_register from users 
                    where (username=? or userid=? or email=? or phone=?) and password=? 
                """.trimIndent()

                Mono.fromCallable {
                    base.safeQuery(sql, listOf(key, key, key, key, password))
                }
                    .subscribeOn(Schedulers.boundedElastic())
                    .flatMap { data ->
                        println(data)
                        if (data.isEmpty()) {
                            ServerResponse.ok()
                                .bodyValue(mapOf("msg" to "用户名或密码错误", "code" to 400))
                        } else {
                            val res = filterData(data[0])
                            val token = tokenService.generateToken(res)
                            ServerResponse.ok()
                                .bodyValue(mapOf("msg" to "登录成功", "code" to 200, "token" to token))
                        }
                    }
            }
            .onErrorResume { e ->
                println("[LoginService.login] 登录异常: ${e.message}")
                ServerResponse.status(500)
                    .bodyValue(mapOf("msg" to "服务器错误", "code" to 500))
            }
    }

    fun filterData(data: Map<String, Any?>): Map<String, Any?> {
        val excludeKeys = listOf("password", "token", "token_expiry", "token_createtime")

        return data.filterKeys { it !in excludeKeys }
            .mapValues { (_, value) ->
                when (value) {
                    is java.time.LocalDateTime -> value.toString() // 转字符串
                    is java.sql.Timestamp -> value.toLocalDateTime().toString()
                    else -> value
                }
            }
    }

}
