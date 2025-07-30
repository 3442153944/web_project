package com.yl.springserverill.token

fun main() {
    val cryptOp = CryptOp()

    val originalText = "这是测试字符串123!@# 中文和特殊符号"
    println("原文: $originalText")

    val encrypted = cryptOp.encrypt(originalText)
    println("加密后 (Base64): $encrypted")

    val decrypted = cryptOp.decrypt(encrypted)
    println("解密后: $decrypted")

    if (originalText == decrypted) {
        println("测试通过 ✅")
    } else {
        println("测试失败 ❌")
    }
}
