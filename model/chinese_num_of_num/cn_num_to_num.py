class ChineseNum:
    def __init__(self):
        self.units = ['', '一', '二', '三', '四', '五', '六', '七', '八', '九']
        self.tens = ['', '十', '二十', '三十', '四十', '五十', '六十', '七十', '八十', '九十']
        self.big_units = ['', '千', '万']

    def chinese_to_num(self, chinese_num):
        units = {'一': 1, '二': 2, '三': 3, '四': 4, '五': 5, '六': 6, '七': 7, '八': 8, '九': 9}
        tens = {'十': 10, '二十': 20, '三十': 30, '四十': 40, '五十': 50, '六十': 60, '七十': 70, '八十': 80,
                '九十': 90}
        big_units = {'千': 1000, '万': 10000, '亿': 100000000}  # 示例中仅处理到万位

        num = 0
        factor = 1
        last_unit = 1  # 上一个单位的数值，初始化为1以防止第一个单位前缺失数字的情况
        current_num = 0  # 当前连续数字的值
        for char in reversed(chinese_num):
            if char in units:
                current_num += units[char]
            elif char in tens:
                current_num += tens[char]
            elif char in big_units:
                factor *= big_units[char]
                num += current_num * factor
                current_num = 0
                # 更新上一个单位的数值
                last_unit = big_units[char]
            else:
                return "输入错误，包含无效的汉字"
        # 将最后一个连续数字的值加到总数中
        num += current_num * factor
        # 如果最后一个单位是万，则需要再乘以上一个单位的数值
        if last_unit == 10000:
            num *= last_unit
        return num

    def num_to_chinese(self, num):
        if not isinstance(num, int) or num < 0 or num >= 10000:
            return "输入错误，请输入0-9999之间的整数"

        result = []
        for idx, unit in enumerate(reversed(self.big_units)):
            if unit == '万' and idx > 0:  # 截断，只处理到万位
                break
            digit = (num // (10 ** (4 * idx))) % 10
            if digit == 0:
                continue
            if digit < 10:
                result.append(self.units[digit] + self.tens[num % 10] if num % 10 else self.units[digit])
            else:
                result.append(self.units[digit // 10] + self.tens[digit % 10])
            result.append(unit)
        result.reverse()
        return ''.join(result).rstrip('零')  # 移除末尾的'零'

chinese= ChineseNum()
print(chinese.chinese_to_num("一万一千零一"))
print(chinese.num_to_chinese(10001))