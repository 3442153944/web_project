package com.yl.springserverill.userInfo

import com.yl.springserverill.Base
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Component
import org.springframework.web.reactive.function.server.ServerRequest
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.bodyToMono
import reactor.core.publisher.Mono
import reactor.core.scheduler.Schedulers

@Component
class getUserInfoById(private val base: Base) {
    fun handler(req: ServerRequest):Mono<ServerResponse>{
        return req.bodyToMono<Map<String, Any>>().flatMap{body->
            println("使用id查询用户信息，请求体为：$body")
            val id=body["id"] as String
            val sql="""select userid,username,sex,user_avatar,select_work,
                vip,account_status,birthday,user_self_introduction
                 from users where userid=?""".trimIndent()
            Mono.fromCallable {
                base.safeQuery(sql, listOf(id))
            }
                .subscribeOn(Schedulers.boundedElastic())
                .flatMap { list ->
                    if(list.isEmpty()){
                        return@flatMap ServerResponse.ok().bodyValue(mapOf("code" to 404,"msg" to "用户不存在"))
                    }
                    else{
                        return@flatMap ServerResponse.ok().bodyValue(mapOf("code" to 200,"msg" to "查询成功","data" to list))
                    }
                }
                .onErrorResume { e ->
                    println("使用id 查询用户信息时出错：$e")
                    return@onErrorResume ServerResponse.status(HttpStatus.INTERNAL_SERVER_ERROR).bodyValue(mapOf("code" to 500,"msg" to "服务器内部错误"))
                }
        }
    }
}