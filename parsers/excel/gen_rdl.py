import os.path

import utils.message as message
from .args import EXCEL_REG_FIELD, EXCEL_REG_HEAD


class RDLGenerator:
    """
    RDL生成器, 从寄存器模型结构生成SystemRDL代码

    Parameter
    ---------
    `reg_model` : `ExcelParser`解析出来的寄存器模型, 可通过`parsed_model`属性获取
    """
    signal_str = "signal {{\n" \
        "\tname = \"{sig_name}\";\n" \
        "\tdesc = \"{sig_desc}\";\n" \
        "\t{active_mode};\n" \
        "}} {sig_name};\n\n"
    field_str = "\t\t\tfield {{\n" \
        "\t\t\t\tname = \"{FieldName}\";\n" \
        "\t\t\t\tdesc = \"{FieldDesc}\";\n" \
        "{acctype_str}" \
        "\t\t\t\tresetsignal = {FieldRstSig};\n" \
        "\t\t\t}} {FieldName}[{FieldBit[0]}:{FieldBit[1]}] = {FieldRstVal};\n\n"
    acctype_str = "\t\t\t\tsw = {sw};\n" \
        "\t\t\t\t{onread}\n" \
        "\t\t\t\t{onwrite}\n"
    reg_str = "\t\t{ext_str}reg {{\n" \
        "\t\t\tname = \"{RegName}\";\n" \
        "\t\t\tdesc = \"{RegDesc}\";\n" \
        "\t\t\tregwidth = {RegWidth};\n\n" \
        "{fields_str}" \
        "\t\t}} {RegAbbr} @{AddrOffset};\n\n"
    addrmap_str = "addrmap {addrmap_name} {{\n" \
        "\tname = \"{addrmap_name}\";\n" \
        "\tdesc = \"{addrmap_desc}\";\n\n" \
        "{regs_str}" \
        "}};\n"

    def __init__(self, reg_model:dict[str,list]):
        self.reg_model = reg_model
        self._resize_model()

    def _resize_model(self):
        """
        重构寄存器模型Dict, 将Field相关项进行转置,
        并删去在解析和检查Excel时引入的与寄存器无关的多余元素

        i.e. 
        - 重构前:
        {
            'template': [
                {
                    'BaseRow': 1,
                    'RegName': 'TEMPLATE寄存器',
                    'AddrOffset': 0,
                    'RegWidth': 32,
                    'RegAbbr': 'TEM',
                    'RegDesc': '示例寄存器',
                    'FieldBit': [(31, 18), (17, 17), (16, 14), (13, 13), (12, 0)],
                    'FieldName': ['Reserved', 'FIELD_1', 'FIELD_2', 'FIELD_3', 'Reserved'],
                    'FieldDesc': [
                        '保留位',
                        '[功能描述]...',
                        '[功能描述]...',
                        '[功能描述]...',
                        '保留位'
                    ],
                    'FieldRdType': ['R', 'RCLR', 'RSET', 'R', 'R'],
                    'FieldWrType': ['W', 'NA', 'WOSET', 'WOT', 'W'],
                    'FieldRstVal': [0, 0, 0, 1, 0],
                    'FieldRstSig': ['Global Reset', 'Global Reset', 'Global Reset', 'Global Reset', 'Global Reset']
                }
            ]
        }
        - 重构后:
        {
            'template': [
                {
                    'RegName': 'TEMPLATE寄存器',
                    'AddrOffset': 0,
                    'RegWidth': 32,
                    'RegAbbr': 'TEM',
                    'RegDesc': '示例寄存器',
                    'Fields': [
                        {
                            'FieldBit': (31, 18),
                            'FieldName': 'Reserved',
                            'FieldDesc': '保留位',
                            'FieldRdType': 'R',
                            'FieldWrType': 'W',
                            'FieldRstVal': 0,
                            'FieldRstSig': 'global_reset'
                        },
                        {
                            'FieldBit': (17, 17),
                            'FieldName': 'FIELD_1',
                            'FieldDesc': '[功能描述]...',
                            'FieldRdType': 'RCLR',
                            'FieldWrType': 'NA',
                            'FieldRstVal': 0,
                            'FieldRstSig': 'global_reset'
                        },
                        {
                            'FieldBit': (16, 14),
                            'FieldName': 'FIELD_2',
                            'FieldDesc': '[功能描述]...',
                            'FieldRdType': 'RSET',
                            'FieldWrType': 'WOSET',
                            'FieldRstVal': 0,
                            'FieldRstSig': 'global_reset'
                        },
                        {
                            'FieldBit': (13, 13),
                            'FieldName': 'FIELD_3',
                            'FieldDesc': '[功能描述]...',
                            'FieldRdType': 'R',
                            'FieldWrType': 'WOT',
                            'FieldRstVal': 1,
                            'FieldRstSig': 'global_reset'
                        },
                        {
                            'FieldBit': (12, 0),
                            'FieldName': 'Reserved',
                            'FieldDesc': '保留位',
                            'FieldRdType': 'R',
                            'FieldWrType': 'W',
                            'FieldRstVal': 0,
                            'FieldRstSig': 'global_reset'
                        }
                    ]
                }
            ]
        }
        """
        fkeys = EXCEL_REG_FIELD.keys()
        hkeys = EXCEL_REG_HEAD.keys()

        for addrmap_entry in self.reg_model.values():
            for reg in addrmap_entry:
                fld_num = len(reg["FieldBit"])
                fields = []

                # 小改动: 把field reset信号名称修改为小写加下划线风格
                for idx, field_rst in enumerate(reg["FieldRstSig"]):
                    reg["FieldRstSig"][idx] = field_rst.lower().replace(" ","_")

                for idx in range(fld_num):
                    reg_field = {}

                    for fkey in fkeys:
                        reg_field[fkey] = reg[fkey][idx]

                    fields.append(reg_field)

                # 对Field相关元素进行转置
                for inkey in list(reg.keys()):
                    if not inkey in hkeys:
                        reg.pop(inkey)
                reg["Fields"] = fields

    def generate_rdl(self, gen_dir:str, module_name:str, is_aggregated=False, gen_signals=True):
        """
        遍历Register model生成SystemRDL代码, 并保存在指定路径

        Parameter
        ---------
        `gen_dir` :
        `module_name` :
        `is_aggregated` :
        `gen_signals` :

        Return
        ------
        `agg_filename` : `str`类型, `is_aggregated == True`时生成聚合的RDL文件名
        `sep_files` : `list`类型, `is_aggregated == False`时生成的分散的RDL文件名
        """
        if gen_signals:
            sigs_str = ""
            rst_sigs = []

        # 当需要聚合所有输入的寄存器说明文件到一个RDL里时, 检查生成文件名的重名情况
        # 所以只有is_aggregated=True时module_name才会被用到
        if is_aggregated:
            agg_filename = os.path.join(gen_dir, module_name + ".rdl")
            addrmaps_str = ""
            new_name = module_name
            suffix_num = 1

            while os.path.exists(agg_filename):
                message.warning("rdl file %s already exists" % (agg_filename))
                new_name = module_name + "_%d" %(suffix_num)
                agg_filename = os.path.join(gen_dir, new_name + ".rdl")
                suffix_num += 1

            module_name = new_name
        else:
            sep_files = []

        # 生成一个映射(Addrmap)中所有寄存器(Reg)例化代码
        for addrmap_name, addrmap_entry in self.reg_model.items():
            regs_str = ""
            # 生成一个寄存器组(Regfile)中所有寄存器(Reg)例化代码
            for reg in addrmap_entry:
                fields_str = ""
                ext_str = ""

                # 生成一个寄存器(Reg)内所有域(Field)例化代码
                for fld in reg["Fields"]:
                    if fld["FieldName"].lower() == "reserved":
                        continue

                    # 给Field中定义的reset signal分配外部定义的signal
                    if gen_signals:
                        rst_sig = fld["FieldRstSig"]
                        if rst_sig not in rst_sigs:
                            rst_sigs.append(rst_sig)

                    # 生成的SystemRDL代码中以16进制表示复位值
                    fld["FieldRstVal"] = hex(fld["FieldRstVal"])

                    sw = ""
                    rdtype = fld["FieldRdType"].lower()
                    wrtype = fld["FieldWrType"].lower()

                    if "r" in rdtype:
                        sw += "r"
                        if rdtype == "r":
                            onread_str = ""
                        else:
                            onread_str = "onread = {};".format(rdtype)

                        # Fix: 如果reg当中存在field属性onread=ruser,
                        # 则该reg需要被定义为external
                        # Ref: SystemRDL2.0 Spec. 9.6.1 (j)
                        if rdtype == "ruser":
                            ext_str = "external "
                    else:
                        onread_str = ""

                    if "w" in wrtype:
                        sw += "w"
                        if wrtype == "w":
                            onwrite_str = ""
                        else:
                            onwrite_str = "onwrite = {};".format(wrtype)

                        # Fix: 如果reg当中存在field属性onwrite=wuser,
                        # 则该reg需要被定义为external
                        # Ref: SystemRDL2.0 Spec. 9.6.1 (m)
                        if wrtype == "wuser":
                            ext_str = "external "
                    else:
                        onwrite_str = ""

                    acctype_str = self.acctype_str.format(sw=sw, onread=onread_str, onwrite=onwrite_str)
                    fields_str += self.field_str.format(acctype_str=acctype_str, **fld)

                # 生成的SystemRDL代码中以16进制表示地址
                reg["AddrOffset"] = hex(reg["AddrOffset"])
                reg_str = self.reg_str.format(fields_str=fields_str, ext_str=ext_str, **reg)
                regs_str += reg_str

            addrmap_str = self.addrmap_str.format(regs_str=regs_str, addrmap_name=addrmap_name, addrmap_desc="[Reserved for editing.]")

            if is_aggregated:
                addrmaps_str += addrmap_str
            else:
                sep_filename = os.path.join(gen_dir, addrmap_name + ".rdl")
                with open(sep_filename, "w", encoding="utf-8") as file:
                    file.write(addrmap_str)
                    message.info("seperate module rdl file saved as %s" % (sep_filename))
                sep_files.append(sep_filename)

        # 单独列出reset signal, 放到一个单独的signals.rdl
        if gen_signals:
            for rst_sig in rst_sigs:
                sigs_str += self.signal_str.format(sig_name=rst_sig, sig_desc="[Reserved for editing.]", active_mode="activehigh")

        if is_aggregated:
            with open(agg_filename, "w", encoding="utf-8") as file:
                if gen_signals:
                    file.write(sigs_str)
                file.write(addrmaps_str)
            message.info("aggregated Excel-oriented RDL file saved as %s" % (agg_filename))
            return agg_filename
        else:
            if gen_signals:
                sig_filename = os.path.join(gen_dir, "signals.rdl")
                with open(sig_filename, "w", encoding="utf-8") as file:
                    file.write(sigs_str)
                    message.info("signal RDL file saved as %s" % (sig_filename))
                sep_files.insert(0, sig_filename)

            return sep_files