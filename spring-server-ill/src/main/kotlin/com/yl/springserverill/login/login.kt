package com.yl.springserverill.login

import com.yl.springserverill.Base
import org.springframework.stereotype.Component
import org.springframework.web.reactive.function.server.ServerRequest
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.bodyToMono
import reactor.core.publisher.Mono

@Component
class LoginSerVice(var base: Base){
    fun login(res:ServerRequest):Mono<ServerResponse>{

            return res.bodyToMono<Map<String,Any>>().flatMap<ServerResponse?> {
                body->
                val key= body["key"]
                val password= body["password"]
                if (key.toString().trim().isEmpty() && password.toString().trim().isEmpty()){
                    return@flatMap ServerResponse.status(400).bodyValue(mapOf("message" to "参数错误","code" to 400))
                }
                return@flatMap ServerResponse.ok().bodyValue(mapOf("message" to "登录成功","code" to 200))
            }
                .onErrorResume { e->
                    println(e)
                    return@onErrorResume ServerResponse.status(500).bodyValue(mapOf("message" to "服务器错误","code" to 500))
                }
    }
}