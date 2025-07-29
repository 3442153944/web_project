package com.yl.springserverill

import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.jdbc.core.PreparedStatementCreator
import org.springframework.jdbc.core.PreparedStatementSetter
import org.springframework.jdbc.support.GeneratedKeyHolder
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.sql.PreparedStatement
import javax.sql.DataSource

@Service
class Base(
    private val jdbc: JdbcTemplate,
    private val dataSource: DataSource
) {
    companion object {
        private val logger = org.slf4j.LoggerFactory.getLogger(Base::class.java)
    }

    // region 查询操作
    /**
     * 安全执行查询，返回结果列表
     * @param sql SQL语句，支持预编译参数(?)
     * @param params 参数列表
     * @return 结果列表，每个元素为一行记录的键值对
     */
    @Transactional(readOnly = true)
    fun safeQuery(sql: String, params: List<Any> = emptyList()): List<Map<String, Any>> {
        return try {
            jdbc.queryForList(sql, *params.toTypedArray()).also {
                logger.debug("Executed query: $sql with params: $params")
            }
        } catch (e: Exception) {
            logger.error("Query failed. SQL: $sql, Params: $params", e)
            emptyList()
        }
    }

    /**
     * 查询单条记录
     * @return 单行记录，找不到时返回null
     */
    @Transactional(readOnly = true)
    fun querySingle(sql: String, params: List<Any> = emptyList()): Map<String, Any>? {
        return safeQuery(sql, params).firstOrNull()
    }
    // endregion

    // region 更新操作
    /**
     * 执行更新操作（INSERT/UPDATE/DELETE）
     * @param returnGeneratedKeys 是否返回自增ID
     * @return 影响行数 或 自增ID（当returnGeneratedKeys=true）
     */
    @Transactional
    fun executeUpdate(
        sql: String,
        params: List<Any> = emptyList(),
        returnGeneratedKeys: Boolean = false
    ): Any {
        return if (returnGeneratedKeys) {
            val keyHolder = GeneratedKeyHolder()
            jdbc.update(
                { conn: java.sql.Connection ->
                    val ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)
                    params.forEachIndexed { index, param ->
                        when (param) {
                            is Int -> ps.setInt(index + 1, param)
                            is String -> ps.setString(index + 1, param)
                            // 添加其他类型处理...
                            else -> ps.setObject(index + 1, param)
                        }
                    }
                    ps
                },
                keyHolder
            )
            keyHolder.keys?.values?.firstOrNull() ?: 0
        } else {
            try {
                jdbc.update(sql, *params.toTypedArray()).also {
                    logger.debug("Executed update: $sql with params: $params")
                }
            } catch (e: Exception) {
                logger.error("Update failed. SQL: $sql, Params: $params", e)
                throw DatabaseOperationException("Update operation failed", e)
            }
        }
    }
    // endregion

    // region 批量操作
    /**
     * 批量更新
     * @return 每行操作影响的行数数组
     */
    @Transactional
    fun batchUpdate(sql: String, batchParams: List<Array<Any>>): IntArray {
        return try {
            jdbc.batchUpdate(sql, batchParams)
        } catch (e: Exception) {
            logger.error("Batch update failed. SQL: $sql, Params: $batchParams", e)
            throw DatabaseOperationException("Batch update failed", e)
        }
    }

    // endregion

    // region 事务控制
    /**
     * 在事务中执行代码块
     */
    @Transactional
    fun <T> inTransaction(block: () -> T): T {
        return try {
            block()
        } catch (e: Exception) {
            logger.error("Transaction failed", e)
            throw e
        }
    }
    // endregion

    // region 实用方法
    /**
     * 检查表是否存在
     */
    fun tableExists(tableName: String): Boolean {
        val count: Long = when (val dbType = dataSource.connection.metaData.databaseProductName) {
            "MySQL" -> {
                val result = safeQuery(
                    "SELECT COUNT(*) AS cnt FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = ?",
                    listOf(tableName)
                )
                result.firstOrNull()?.get("cnt")?.toString()?.toLongOrNull() ?: 0L
            }

            "PostgreSQL" -> {
                val result = safeQuery(
                    "SELECT COUNT(*) AS cnt FROM pg_tables WHERE schemaname = 'public' AND tablename = ?",
                    listOf(tableName)
                )
                result.firstOrNull()?.get("cnt")?.toString()?.toLongOrNull() ?: 0L
            }

            else -> throw UnsupportedOperationException("Unsupported database: $dbType")
        }

        return count == 1L
    }
    // endregion

}

class DatabaseOperationException(message: String, cause: Throwable? = null) :
    RuntimeException(message, cause)