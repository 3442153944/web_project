import re
import pymysql
from ..log.log import Logger

class ComicRecommendation:
    def __init__(self):
        # 初始化 Logger
        self.logger = Logger()

        # 连接到数据库
        self.connection = pymysql.connect(
            host='localhost',
            user='admin',
            password='123456',
            database='admin',
            cursorclass=pymysql.cursors.DictCursor  # 使用字典游标
        )
        self.cursor = self.connection.cursor()

    def get_userid(self, userid, offset=0, limit=9):
        # SQL 查询语句
        watch_sql = 'SELECT * FROM user_watch_table WHERE userid=%s AND type=%s LIMIT %s OFFSET %s'
        like_sql = 'SELECT * FROM user_like_table WHERE userid=%s AND type=%s LIMIT %s OFFSET %s'
        collect_sql = 'SELECT * FROM user_collection_table WHERE userid=%s AND type=%s LIMIT %s OFFSET %s'

        try:
            # 提取用户行为数据
            watch_id_list = self.query_work_ids(watch_sql, userid, offset, limit)
            like_id_list = self.query_work_ids(like_sql, userid, offset, limit)
            collect_id_list = self.query_work_ids(collect_sql, userid, offset, limit)

            # 合并并加权标签
            all_tags = self.get_weighted_tags(watch_id_list, 1) + \
                       self.get_weighted_tags(like_id_list, 2) + \
                       self.get_weighted_tags(collect_id_list, 3)

            # 记录加权后的标签
            tags_str = ', '.join(all_tags)
            print('加权后的标签: %s' % tags_str)

            # 统计标签频率
            tag_frequency = self.count_tag_frequency(all_tags)

            # 从插画信息表中获取所有作品
            all_works = self.query_works(offset, limit)

            # 基于标签频率推荐作品
            recommendations = self.recommend_works(all_works, tag_frequency)

            # 实现分页并处理循环
            total_works = len(recommendations)
            if total_works == 0:
                self.logger.info('没有推荐的作品')
                return []  # 如果没有推荐的作品，返回空列表

            # 计算偏移量并循环
            start_index = offset % total_works
            end_index = start_index + limit
            paginated_recommendations = recommendations[start_index:end_index]

            if end_index > total_works:
                paginated_recommendations.extend(recommendations[:end_index % total_works])

            return paginated_recommendations

        except Exception as e:
            self.logger.error('获取用户推荐时发生错误: %s' % str(e))
            return []

    def query_work_ids(self, sql, userid, offset, limit):
        """执行 SQL 查询并返回 work_ids 列表"""
        try:
            self.cursor.execute(sql, (userid, 'comic', limit, offset))
            results = self.cursor.fetchall()
            return [item['workid'] for item in results]
        except Exception as e:
            self.logger.error('执行查询时发生错误: %s' % str(e))
            return []

    def query_works(self, offset, limit):
        """从插画信息表中获取作品，考虑分页"""
        sql = 'SELECT * FROM comic LIMIT %s OFFSET %s'
        try:
            self.cursor.execute(sql, (limit, offset))
            return self.cursor.fetchall()
        except Exception as e:
            self.logger.error('获取作品信息时发生错误: %s' % str(e))
            return []

    def get_weighted_tags(self, work_ids, weight):
        # 获取带权重的标签
        weighted_tags = []
        for work_id in work_ids:
            tags = self.set_tag_list(work_id)
            weighted_tags.extend(tags * weight)
        return weighted_tags

    def set_tag_list(self, work_id):
        sql = 'SELECT work_tags FROM comic WHERE id=%s'
        try:
            self.cursor.execute(sql, (work_id,))
            result = self.cursor.fetchone()
            if result:
                tags_str = result.get('work_tags', '')
                return self.split_tags(tags_str)
        except Exception as e:
            self.logger.error('获取标签列表时发生错误: %s' % str(e))
        return []

    def split_tags(self, tags_str):
        # 将标签字符串按英文逗号和中文逗号分隔成标签列表
        return re.split(r'[，,]', tags_str.strip())

    def count_tag_frequency(self, tags):
        # 计算每个标签的频率
        frequency = {}
        for tag in tags:
            tag = tag.strip()
            if tag:
                frequency[tag] = frequency.get(tag, 0) + 1
        return frequency

    def recommend_works(self, works, tag_frequency):
        # 根据标签频率对作品进行评分，并按得分排序返回推荐的作品信息字典列表
        recommendations = []
        for work in works:
            # 获取作品标签
            work_tags = self.split_tags(work.get('work_tags', ''))
            # 计算作品得分
            score = sum(tag_frequency.get(tag.strip(), 0) for tag in work_tags)
            # 确保作品包含 'Illustration_id' 键
            if 'id' in work:
                work_id = work['id']
                work_info = self.get_work_info(work_id)
                if work_info:
                    work_info['score'] = score  # 将得分添加到作品信息中
                    recommendations.append(work_info)

        # 按得分排序，返回得分最高的作品信息字典列表
        recommendations.sort(key=lambda x: x.get('score', 0), reverse=True)
        return recommendations

    def get_work_info(self, work_id):
        sql = 'SELECT * FROM comic WHERE id=%s'
        get_author_info = 'SELECT * FROM users WHERE userid=%s'

        try:
            # 查询作品信息
            self.cursor.execute(sql, (work_id,))
            result = self.cursor.fetchone()

            if result:
                userid = result.get('belong_to_userid')
                if userid:
                    # 查询作者信息
                    self.cursor.execute(get_author_info, (userid,))
                    author_info = self.cursor.fetchone()

                    # 删除不需要的字段
                    if author_info:
                        author_info.pop('password', None)
                        author_info.pop('token', None)

                        # 将作者信息添加到作品信息中
                        result['author_info'] = author_info

            return result

        except Exception as e:
            self.logger.error('获取作品信息时发生错误: %s' % str(e))
            return None

    def close(self):
        # 关闭游标和连接
        self.cursor.close()
        self.connection.close()
'''
recommender = ComicRecommendation()
recommendations = recommender.get_userid('f575b4d3-0683-11ef-adf4-00ffc6b98bdb', offset=0, limit=9)
print(recommendations)
'''