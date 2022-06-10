import os.path
from shutil import copy

import utils.message as message
from openpyxl import load_workbook
from openpyxl.worksheet.cell_range import CellRange
from parsers.excel.args import EXCEL_REG_HEAD


def gen_excel_template(dir:str, name:str, rnum:int, rname:list, language:str, table_interval=4):
    """
    generate templates in Excel worksheet (.xlsx) format

    Parameter
    ---------
    `dir` : directory to generated template file
    `name` : 生成模板的名字, 后续将作为regfile的名称使用
    `rnum` : 生成模板中寄存器的数量
    `rname` : 生成模板中各个寄存器的名字
    `language` : 生成模板的语言格式, 支持中文/English
    """
    temp_file = os.path.join(os.path.dirname(__file__), "template_{}.xlsx".format(language))
    gen_file = os.path.join(dir, name)

    # handle duplicate file names
    suffix_num = 1
    while os.path.exists(os.path.join(dir, name)):
        has_duplicate = True
        name = "{}_{}{}".format(os.path.splitext(name)[0], suffix_num, os.path.splitext(name)[1])
        suffix_num += 1

    gen_file = os.path.join(dir, name)
    copy(temp_file, gen_file)

    if rnum > 1:
        wb = load_workbook(gen_file)
        ws = wb.active
        # length and width of each register table
        row_num, col_num = ws.max_row, ws.max_column
        source_cells = list(ws.rows)

        for row in range(1, row_num + 1):
            for col in range(1, col_num + 1):
                source_cell = source_cells[row-1][col-1]

                for regidx in range(rnum):
                    new_row = row + (row_num + table_interval) * regidx
                    new_cell = ws.cell(row=new_row, column=col)

                    if regidx >= 1:
                        # copy values and formats
                        new_cell.value = source_cell.value
                        new_cell._style = source_cell._style
                        new_cell.number_format = source_cell.number_format

                    # update register name and address offset of each table
                    if (row, col) == EXCEL_REG_HEAD["RegName"]["Content"]["Loc"]:
                        new_cell.value = rname[regidx].upper()
                    elif (row, col) == EXCEL_REG_HEAD["RegAbbr"]["Content"]["Loc"]:
                        new_cell.value = rname[regidx].upper()
                    elif (row, col) == EXCEL_REG_HEAD["AddrOffset"]["Content"]["Loc"]:
                        new_cell.value = "{0:#0{1}X}".format(regidx<<2, 10)

        # FIX: 上面Style Copy存在不能复制被合并的单元格的问题,
        # 原因是在openpyxl里单元格合并不是一个Style,
        # 而是将被合并单元格变成MergedCell Object,
        # 与普通的Cell Object不同
        area = CellRange(min_row=1, max_row=row_num, min_col=1, max_col=col_num)
        for mcr in ws.merged_cells:
            if mcr.coord not in area:
                continue
            cr = CellRange(mcr.coord)
            for regidx in range(1, rnum):
                cr.shift(row_shift=row_num+table_interval)
                ws.merge_cells(cr.coord)

        wb.save(gen_file)

    if has_duplicate:
        message.warning("same template file name already exists, generate %s" % (gen_file))
    else:
        message.info("generate template: %s" % (gen_file))

def gen_rdl_template(dir:str, name:str):
    """
    generate templates in SystemRDL (.rdl) format
    """
    temp_file = os.path.join(os.path.dirname(__file__), "template.rdl")

    # handle duplicate file names
    suffix_num = 1
    while os.path.exists(os.path.join(dir, name)):
        name = "{}_{}{}".format(os.path.splitext(name)[0], suffix_num, os.path.splitext(name)[1])
        suffix_num += 1

    gen_file = os.path.join(dir, name)
    copy(temp_file, gen_file)
    message.info("generate template: %s" % (gen_file))
