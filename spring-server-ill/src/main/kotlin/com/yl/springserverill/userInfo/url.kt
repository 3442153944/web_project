package com.yl.springserverill.userInfo

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.reactive.function.server.RouterFunction
import org.springframework.web.reactive.function.server.ServerResponse
import org.springframework.web.reactive.function.server.router

@Configuration
class UserUrl(
    private val getUserInfoById: getUserInfoById
) {
    @Bean
    fun userRouter():RouterFunction<ServerResponse> = router{
        POST("/getUserInfoById",getUserInfoById::handler)
    }
}