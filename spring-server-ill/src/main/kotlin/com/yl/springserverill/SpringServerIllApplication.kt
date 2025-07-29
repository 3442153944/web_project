package com.yl.springserverill

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.stereotype.Component
import org.springframework.web.reactive.function.server.ServerRequest  // 关键修改
import org.springframework.web.reactive.function.server.ServerResponse
import reactor.core.publisher.Mono

@SpringBootApplication
class MyKotlinApp

fun main(args: Array<String>) {
	runApplication<MyKotlinApp>(*args)
}

@Component
class HelloController {
	fun hello(request: ServerRequest): Mono<ServerResponse> {
		return ServerResponse.ok()
			.bodyValue(mapOf("message" to "Hello Kotlin Spring"))
	}
}