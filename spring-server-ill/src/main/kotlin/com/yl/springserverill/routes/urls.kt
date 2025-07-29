package com.yl.springserverill.routes

import com.yl.springserverill.HelloController
import com.yl.springserverill.login.LoginSerVice
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.RequestEntity.post
import org.springframework.web.reactive.function.server.RouterFunction
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.router

@Configuration
class MainRouter(private val helloController: HelloController,
    private val login: LoginSerVice) {
    @Bean
    fun apiRoutes(): RouterFunction<ServerResponse> = router {
        "/api".nest {
            GET("/hello", helloController::hello)
            post("/login")

            GET("/{path:.*}"){ServerResponse.status(404)
                .bodyValue(mapOf("code" to 405, "msg" to "GET 方法未开放"))}
        }

    }
}