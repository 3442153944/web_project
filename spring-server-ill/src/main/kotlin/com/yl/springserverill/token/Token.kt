package com.yl.springserverill.token

import com.google.gson.*
import org.apache.commons.codec.binary.Base64
import javax.crypto.SecretKey
import javax.crypto.spec.SecretKeySpec

class TokenService(private val cryptOp: CryptOp) {

    companion object {
        private const val TOKEN_VERSION = "1.0"
        private const val DEFAULT_EXPIRATION_DAYS = 30
    }

    // Gson实例
    private val gson = Gson()

    // 这里你之前的code变量内容不应该Base64解码（内容本身不是Base64），这里示范一个签名key
    private val signingKey: SecretKey by lazy {
        // 这里示范一个简单固定签名Key（32字节）
        val keyBytes = "0123456789abcdef0123456789abcdef".toByteArray(Charsets.UTF_8)
        SecretKeySpec(keyBytes, "HmacSHA256")
    }

    /**
     * 生成Token
     */
    fun generateToken(claims: Map<String, Any>, expirationDays: Int = DEFAULT_EXPIRATION_DAYS): String {
        val now = System.currentTimeMillis()
        val expiration = now + expirationDays * 86400000L

        val jsonObj = JsonObject().apply {
            addProperty("ver", "1.1")
            addProperty("iat", now)
            addProperty("exp", expiration)
            claims.forEach { (k, v) ->
                when (v) {
                    is String -> addProperty(k, v)
                    is Number -> addProperty(k, v)
                    is Boolean -> addProperty(k, v)
                    else -> add(k, gson.toJsonTree(v))
                }
            }
        }

        return cryptOp.encrypt(jsonObj.toString())
    }

    /**
     * 解密并解析Token
     */
    fun decodeToken(encryptedToken: String): Map<String, Any> {
        try {
            val json = cryptOp.decrypt(encryptedToken)
            val jsonObj = JsonParser.parseString(json).asJsonObject

            // 验证过期
            val exp = jsonObj.get("exp")?.asLong ?: throw TokenInvalidException("Missing exp")
            if (System.currentTimeMillis() > exp) {
                throw TokenExpiredException()
            }

            val claims = mutableMapOf<String, Any>()
            jsonObj.entrySet().forEach { (k, v) ->
                if (k !in listOf("ver", "iat", "exp")) {
                    claims[k] = when {
                        v.isJsonPrimitive -> {
                            val prim = v.asJsonPrimitive
                            when {
                                prim.isString -> prim.asString
                                prim.isNumber -> prim.asNumber
                                prim.isBoolean -> prim.asBoolean
                                else -> prim.toString()
                            }
                        }
                        else -> gson.fromJson(v, Any::class.java)
                    }
                }
            }
            return claims
        } catch (e: Exception) {
            println("[TokenService.decodeToken] 解码异常: ${e.message}")
            throw e
        }
    }

    /**
     * 验证Token有效性
     */
    fun validateToken(encryptedToken: String): Boolean {
        return try {
            decodeToken(encryptedToken)
            true
        } catch (e: Exception) {
            println("[TokenService.validateToken] 验证失败: ${e.message}")
            false
        }
    }

    /**
     * 刷新Token，延长有效期
     */
    fun refreshToken(encryptedToken: String): String {
        try {
            val claims = decodeToken(encryptedToken)
            // 保留旧claims内容，生成新token延长过期时间
            return generateToken(claims, DEFAULT_EXPIRATION_DAYS)
        } catch (e: Exception) {
            println("[TokenService.refreshToken] 刷新失败: ${e.message}")
            throw e
        }
    }
}

class TokenExpiredException : RuntimeException("Token已过期")
class TokenInvalidException(message: String) : RuntimeException(message)
