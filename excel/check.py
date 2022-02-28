import re
import sys
from tabnanny import check

import utils.message as message
from openpyxl import load_workbook
from openpyxl.worksheet.worksheet import Worksheet

from excel.args import EXCEL_REG_FIELD, EXCEL_REG_HEAD

class ExcelRuleChecker:
    """
    定义和检查用Excel表格编写的寄存器Spec的规则约束。
    目前已有规则:
    1. 

    2. 

    3. 

    4. 
    """
    def __init__(self, ws:Worksheet):
        self.worksheet = ws
        self.reg_spec = []
    
    def check_table_format(self):
        """
        检查基础格式,包括表格项是否齐全,位置是否正确,特定单元格是否符合要求等.

        1. 基地址格式必须为十六进制0X(x)前缀开头

        2. 地址偏移必须为十六进制0X(x)前缀开头

        3. 支持的访问类型

        4. 寄存器长度只能为32或64bit

        5. 域的比特位范围必须为xx:xx格式


        Return
        ------
        bool : 检查格式出错时直接返回False

        dict : 所有格式检查通过后返回各表项内容构成的字典
        """
        last_row = 1
        base_row = 0
        max_row = self.worksheet.max_row
        check_ack = True

        while last_row < max_row:
            item_dict = {}
            last_rows = []
            for key, val in EXCEL_REG_HEAD.items():
                # 验证表项名是否正确
                off_row, col = val["Entry"]["Location"]
                row = base_row + off_row
                cell = self.worksheet.cell(row=row, column=col)

                if cell.value not in val["Entry"]["Name"]:
                    message.error("cell row:%d col:%d not match!" %(row, col))
                    check_ack = False

                # 验证表项内容是否符合规则
                off_row, col = val["Content"]["Location"]
                row = base_row + off_row
                cell = self.worksheet.cell(row=row, column=col)

                if cell.value is None:
                    message.error("cell row:%d col: %d cannot be empty!" %(row, col))
                    check_ack = False
                else:
                    # 对相应单元格进行正则匹配规则的检查
                    pattern = val["Content"]["Pattern"]
                    if pattern is not None:
                        # 验证正则表达式
                        if re.match(pattern, str(cell.value)) is None:
                            message.error("cell row:%d col:%d format not match!" %(row, col))
                            check_ack = False

                if check_ack:
                    item_dict[key] = cell.value

            # 验证表的域定义项: 包括表项名和内容
            for key, val in EXCEL_REG_FIELD.items():
                item_dict[key] = []
                # 验证表项名是否正确: 比特位、域名称等
                off_row, col = val["Entry"]["Location"]
                row = base_row + off_row
                cell = self.worksheet.cell(row=row, column=col)

                if cell.value not in val["Entry"]["Name"]:
                    message.error("cell row:%d col:%d not match!" %(row, col))
                    check_ack = False

                # 验证表项内容是否符合规则: 比特位、域名称等下面的内容
                off_row, col = val["Content"]["StartLocation"]
                row = base_row + off_row
                cell = self.worksheet.cell(row=row, column=col)

                # 域定义不能为空，至少要写明所有bit为Reserved
                if cell.value is None:
                    message.error("cell row:%d col: %d cannot be empty!" %(row, col))
                    check_ack = False
                    message.info("if this register need to be empty, please mark all field bits as Reserved.")

                while cell.value is not None:
                    # 对相应单元格进行正则匹配规则的检查
                    pattern = val["Content"]["Pattern"]
                    if pattern is not None:
                        # 验证正则表达式
                        if re.match(pattern, str(cell.value)) is None:
                            message.error("cell row:%d col:%d format not match!" %(row, col))
                            check_ack = False

                    if check_ack:
                        item_dict[key].append(cell.value)

                    row += 1
                    cell = self.worksheet.cell(row=row, column=col)

                last_rows.append(row)

            # 保证域定义中每行都是完整的
            if not min(last_rows) == max(last_rows):
                message.error("all field items should not be empty!")
                check_ack = False
            else:
                last_row = last_rows[0]

            # 每张表的行基数是开头的前一行
            base_row = last_row + 1

            # 如果当前寄存器定义Table出现问题，则直接停止检查后面的Table，直接返回False
            if not check_ack:
                return check_ack

            self.reg_spec.append(item_dict)

        return check_ack

    def check_baseaddr(self):
        """
        检查基地址是否合规.
        1. 对齐方式
        2. 地址重合
        """
        pass

    def check_addroffset(self):
        """
        检查地址偏移是否有重合
        """
        pass

    def check_reglen(self):
        """
        检查寄存器长度
        """
        pass

def check_excel_single(file:str):
    wb = load_workbook(file)
    ws = wb.active
    checker = ExcelRuleChecker(ws)
    # 执行所有规则检查
    for attr in dir(checker):
        if not attr.startswith("__"):
            check_func = getattr(checker, attr)
            if callable(check_func):
                check_func()
            


def check_excel_list(list_file:str):
    pass

def show_rules():
    pass
