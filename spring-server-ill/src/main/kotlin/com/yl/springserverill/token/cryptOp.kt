package com.yl.springserverill.token

import java.util.*
import javax.crypto.Cipher
import javax.crypto.SecretKey
import javax.crypto.spec.GCMParameterSpec
import javax.crypto.spec.SecretKeySpec
import org.apache.commons.codec.binary.Base64
import org.springframework.stereotype.Component

@Component
class CryptOp {
    companion object {
        private const val ALGORITHM = "AES/GCM/NoPadding"
        private const val TAG_LENGTH_BIT = 128 // 认证标签长度
        private const val IV_LENGTH_BYTE = 12   // GCM推荐的IV长度
    }

    // 从Base64编码的字符串解码密钥
    private val secretKey: SecretKey by lazy {
        val decodedKey = Base64.decodeBase64("lgYdcCA1tc5odYAkri_fYg2UuAlhhInFzTUSnSRpPzY=")
        SecretKeySpec(decodedKey, "AES")
    }

    /**
     * AES-GCM 加密
     * @param plainText 明文
     * @return Base64编码的字符串（格式：IV + 密文）
     */
    fun encrypt(plainText: String): String {
        try {
            val iv = ByteArray(IV_LENGTH_BYTE).apply {
                Random().nextBytes(this) // 生成随机IV
            }

            val cipher = Cipher.getInstance(ALGORITHM).apply {
                init(Cipher.ENCRYPT_MODE, secretKey, GCMParameterSpec(TAG_LENGTH_BIT, iv))
            }

            val cipherText = cipher.doFinal(plainText.toByteArray(Charsets.UTF_8))

            // 组合IV + 密文
            val encryptedData = iv + cipherText
            return Base64.encodeBase64String(encryptedData)
        } catch (e: Exception) {
            println("加密失败，失败原因：${e.message}")
            return  ""
        }
    }

    /**
     * AES-GCM 解密
     * @param cipherText Base64编码的加密字符串（必须包含IV）
     * @return 解密后的明文
     */
    fun decrypt(cipherText: String): String {
        try {
            val decodedData = Base64.decodeBase64(cipherText)
            require(decodedData.size >= IV_LENGTH_BYTE) { "Invalid cipher text" }

            val iv = decodedData.copyOfRange(0, IV_LENGTH_BYTE)
            val actualCipherText = decodedData.copyOfRange(IV_LENGTH_BYTE, decodedData.size)

            val cipher = Cipher.getInstance(ALGORITHM).apply {
                init(Cipher.DECRYPT_MODE, secretKey, GCMParameterSpec(TAG_LENGTH_BIT, iv))
            }

            return String(cipher.doFinal(actualCipherText), Charsets.UTF_8)
        } catch (e: Exception) {
            println("解密失败，失败原因：${e.message}")
            return ""
        }
    }
}
