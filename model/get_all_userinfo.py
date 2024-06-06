from model.CORSMixin import CORSMixin
import tornado
import tornado.web
from model.connect_sqlsever import *
import json
from model.log.log import Logger

logger = Logger()


class get_all_userinfo(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        self.set_status(200)
        self.set_header('Content-Type', 'application/json')
        try:
            body = json.loads(self.request.body)
            username = body['user_name']
            conn = self.conn.connect()
            cursor = conn.cursor()
            sql = "SELECT * FROM users WHERE username=%s"
            cursor.execute(sql, (username,))
            result = cursor.fetchone()
            if result:
                column_names = [desc[0] for desc in cursor.description]
                user_info = dict(zip(column_names, result))
                # 移除密码字段
                if 'password' in user_info:
                    del user_info['password']
                print(user_info)
                self.write(json.dumps({"status": "success", "data": user_info}))
            else:
                self.write(json.dumps({"status": "error", "message": "用户不存在"}))
            cursor.close()
            conn.close()
        except Exception as e:
            print(f"获取用户信息时发生错误: {e}")
            self.write(json.dumps({"status": "error", "message": "服务器内部错误", "error": str(e)}))

class UserIdGetAllUserInfo(tornado.web.RequestHandler,CORSMixin):
    conn=connMysql()
    def post(self):
        try:
            conn=self.conn.connect()
            cursor=conn.cursor()
            data=json.loads(self.request.body.decode('utf-8'))
            user_id=data['user_id']
            sql="SELECT * FROM users WHERE userid=%s"
            cursor.execute(sql,(user_id,))
            result=cursor.fetchall()
            if result:
                column_names=[desc[0] for desc in cursor.description]
                result_list=[dict(zip(column_names,row)) for row in result]
                logger.info("获取用户信息成功"+str(result_list)+json.dumps(data)+"\n")
                print(result_list)
                self.write(json.dumps({"status":"success","data":result_list}))
            else:
                self.write(json.dumps({"status":"error","message":"用户不存在"}))
        except Exception as e:
            print(e)
            print(61)
            logger.error("获取用户信息失败"+str(e)+"\n")

class update_user_info(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        self.set_status(200)
        self.set_header('Content-Type', 'application/json')
        try:
            conn = self.conn.connect()
            cursor = conn.cursor()
            body = json.loads(self.request.body)
            user_id = body['user_id']
            username = body['user_name']
            user_self_introduction = body['user_self_introduction']
            sex = body['sex']
            user_address = body['user_address']
            user_self_website = body['user_self_website']
            birthday = body['birthday']
            print(birthday)
            occupation = body['occupation']
            sql = ("update users set username=%s,user_self_introduction=%s,sex=%s,user_address=%s,user_self_website=%s"
                   ",birthday=%s,occupation=%s where userid=%s")
            cursor.execute(sql, (username, user_self_introduction, sex, user_address, user_self_website, birthday,
                                 occupation, user_id))
            conn.commit()
            logger.info("更新的内容" + str(body))
            # 被更改行大于等于一
            if cursor.rowcount >= 1:
                self.write(json.dumps({"status": "success", "message": "更新成功"}))
                logger.info("更新成功")
            else:
                self.write(json.dumps({"status": "error", "message": "更新失败"}))
                logger.info("更新失败")
        except Exception as e:
            print(e)
            logger.error(e)
            self.write(json.dumps({"status": "error", "message": "服务器内部错误"}))
        finally:
            cursor.close()
            conn.close()


class updateUserSelectWork(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        try:
            self.set_status(200)
            self.set_header('Content-Type', 'application/json')
            data = json.loads(self.request.body)
            user_id = data['user_id']
            username = data['username']
            work_id = data['work_id']
            ill_id = data['ill_id']
            conn = self.conn.connect()
            cursor = conn.cursor()
            select_works = json.dumps({"ill_id": ill_id, "work_id": work_id})
            print('选择的列表' + select_works)
            update_sql = "update users set select_work=%s where userid=%s and username=%s"
            cursor.execute(update_sql, (select_works, user_id, username))
            conn.commit()
            if cursor.rowcount >= 1:
                self.write(json.dumps({"status": "success", "message": "更新成功"}))
                logger.info("更新成功" + str(data))
        except Exception as e:
            self.write(json.dumps({"status": "error", "message": "参数错误"}))
            logger.error(e)
            print(e)
        finally:
            cursor.close()
            conn.close()


class getSelectWorkList(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        try:
            self.set_status(200)
            self.set_header('Content-Type', 'application/json')
            data = json.loads(self.request.body.decode('utf-8'))
            user_id = data['user_id']
            username = data['username']
            conn = self.conn.connect()
            cursor = conn.cursor()
            select_work_sql = "select select_work from users where userid=%s and username=%s"
            cursor.execute(select_work_sql, (user_id, username))
            conn.commit()
            select_work_list = cursor.fetchall()
            if select_work_list:
                print(select_work_list[0][0])
                select_work_list = json.loads(select_work_list[0][0])
                self.write(json.dumps({"status": "success", "data": select_work_list}))
                logger.info("获取选择的作品列表成功" + str(data))
            else:
                self.write(json.dumps({"status": "error", "message": "没有选择的作品"}))
                logger.info("没有选择的作品" + str(data))
        except Exception as e:
            print(e)
            logger.error(e)
        finally:
            cursor.close()
            conn.close()


class useIdGetWorkInfo(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        try:
            self.set_status(200)
            conn = self.conn.connect()
            cursor = conn.cursor()
            data = json.loads(self.request.body.decode('utf-8'))
            work_type = data['type']
            if work_type == 'ill':
                ill_id = data['ill_id']
                sql = "select * from illustration_work where Illustration_id=%s"
                cursor.execute(sql, (ill_id,))
                conn.commit()
                work_info = cursor.fetchall()
                if work_info:
                    #字段名和值对应
                    column_names=[desc[0] for desc in cursor.description]
                    result_list=[dict(zip(column_names,row)) for row in work_info]
                    self.write(json.dumps({"status": "success", "data": result_list}))
                    logger.info("获取作品信息成功" + str(data))
                    print(work_info)
                else:
                    self.write(json.dumps({"status": "error", "message": "没有该作品"}))
                    logger.info("没有该作品" + str(data))
            if work_type == 'work':
                work_id = data['work_id']
                sql = "select * from novel_work where work_id=%s"
                cursor.execute(sql, (work_id,))
                conn.commit()
                work_info = cursor.fetchall()
                if work_info:
                    #字段名和值对应
                    column_names=[desc[0] for desc in cursor.description ]
                    result_dict=[dict(zip(column_names,row)) for row in work_info]
                    self.write(json.dumps({"status": "success", "data": result_dict}))
                    logger.info("获取作品信息成功" + str(data))
                else:
                    self.write(json.dumps({"status": "error", "message": "没有该作品"}))
                    logger.info("没有该作品" + str(data))
        except Exception as e:
            logger.error(e)
            print(e)
        finally:
            cursor.close()
            conn.close()

class EditSelectWorkList(tornado.web.RequestHandler, CORSMixin):
    conn=connMysql()
    def post(self):
        try:
            self.set_status(200)
            data=json.loads(self.request.body.decode('utf-8'))
            user_id=data['user_id']
            username=data['username']
            select_work_list=data['select_work_list']
            #格式化select_work_list
            select_work_list=json.dumps(select_work_list)
            conn=self.conn.connect()
            cursor=conn.cursor()
            sql="update users set select_work=%s where userid=%s and username=%s"
            cursor.execute(sql,(select_work_list,user_id,username))
            conn.commit()
            if cursor.rowcount>0:
                self.write(json.dumps({"status":"success","message":"修改成功"}))
                logger.info("修改成功"+str(data))
            else:
                self.write(json.dumps({"status":"error","message":"修改失败"}))
                logger.info("修改失败"+str(data))
        except Exception as e:
            print(e)
            logger.error(e)
