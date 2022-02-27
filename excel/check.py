from openpyxl import load_workbook
from openpyxl.worksheet.worksheet import Worksheet
from excel.args import EXCEL_REG_FIELD, EXCEL_REG_HEAD
import utils.message as message
import sys
import re

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
    
    def CheckTableItem(self):
        """
        检查表格项是否齐全,以及位置是否正确
        """
        table_cnt = 0
        last_row = 1
        last_rows = []
        base_row = 0
        check_ack = True

        while last_row < self.worksheet.max_row:
            for val in EXCEL_REG_HEAD.values():
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
                # 对相应单元格进行正则匹配规则的检查
                pattern = val["Content"]["Pattern"]
                if pattern is not None:
                    # 验证正则表达式
                    if re.match(pattern, str(cell.value)) is None:
                        message.error("cell row:%d col:%d format not match!" %(row, col))
                        check_ack = False

            # 验证表的域定义项
            for val in EXCEL_REG_FIELD.values():
                # 验证表项名是否正确
                off_row, col = val["Entry"]["Location"]
                row = base_row + off_row
                cell = self.worksheet.cell(row=row, column=col)

                if cell.value not in val["Entry"]["Name"]:
                    message.error("cell row:%d col:%d not match!" %(row, col))
                    check_ack = False

                # 验证表项内容是否符合规则
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
                    row += 1
                    cell = self.worksheet.cell(row=row, column=col)
                last_rows.append(row)

            # 保证域定义中每行都是完整的
            if not min(last_rows) == max(last_rows):
                message.error("all field items should not be empty!")
                check_ack = False
            else:
                last_row = last_rows[0]

            table_cnt += 1
            # 每张表的行基数是开头的前一行
            base_row = last_row + 1

            # 如果当前寄存器定义Table出现问题，则直接停止检查后面的Table，直接返回False
            if not check_ack:
                return check_ack


    def check_baseaddr(self) -> bool:
        """
        检查基地址是否合规.
        1. 对齐方式
        2. 地址重合
        """
        pass

    def check_addroffset(self) -> bool:
        """
        检查地址偏移是否有重合
        """
        pass

    def check_reglen(self) -> bool:
        """
        检查寄存器长度
        """
        pass

def check_excel_single(file:str):
    wb = load_workbook(file)
    ws = wb.active
    checker = ExcelRuleChecker(ws)


def check_excel_list(list_file:str):
    pass

def show_rules():
    pass