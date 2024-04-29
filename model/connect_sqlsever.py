import pymysql


class connMysql:
    def __init__(self):
        print("数据库连接初始化")

    def connect(self):
        try:
            conn = pymysql.connect(host='127.0.0.1', user='admin', passwd='123456', database='admin')
            print("数据库连接成功")
            return conn
        except pymysql.Error as e:
            print(e)
            raise

    def close(self, conn):
        conn.close()
        print("数据库连接已关闭")
