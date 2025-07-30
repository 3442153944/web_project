package com.yl.springserverill.login

import com.yl.springserverill.Base
import com.yl.springserverill.middleware.User
import org.springframework.stereotype.Component
import org.springframework.web.reactive.function.server.ServerRequest
import org.springframework.web.reactive.function.server.ServerResponse
import reactor.core.publisher.Mono

@Component
class VerifyLogin(private val base: Base) {

    fun handle(req: ServerRequest): Mono<ServerResponse> {
        val user = req.exchange().attributes["loginUser"] as? User
        println("验证登录，解析的用户信息为：$user")

        if (user == null || !user.isLogin) {
            return ServerResponse.status(401).bodyValue(mapOf(
                "code" to 401,
                "msg" to "未登录"
            ))
        }

        return ServerResponse.ok().bodyValue(mapOf(
            "code" to 200,
            "msg" to "验证成功",
            "userId" to user.id,
            "username" to user.username,
            "vip" to user.vip
        ))
    }
}
