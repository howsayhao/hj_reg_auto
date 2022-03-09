import utils.message as message
from args import EXCEL_REG_FIELD, EXCEL_REG_HEAD
import os.path

class RDLGenerator:
    """
    RDL生成器, 从寄存器模型结构生成SystemRDL代码

    Parameter
    ---------
    `reg_model` : `ExcelParser`解析出来的寄存器模型, 可通过`parsed_model`属性获取
    `module_name` : 输入寄存器模型的顶层模块名, 即root addrmap的名字, 默认为`unnamed`
    `gen_path` : 生成后的RDL文件保存路径 
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
    regfile_str = "\tregfile {{\n" \
        "\t\tname = \"{rfile_name}\";\n" \
        "\t\tdesc = \"{rfile_desc}\";\n\n" \
        "{regs_str}" \
        "\t}} {rfile_name};\n\n"
    addrmap_str = "addrmap {addrmap_name}{{\n" \
        "{regfiles_str}" \
        "}};"

    def __init__(self, reg_model:dict[str,list], gen_path:str, module_name:str="unnamed"):
        self.reg_model = reg_model
        self.gen_path = gen_path
        self.module_name = module_name

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
                            'FieldRstSig': 'Global Reset'
                        },
                        {
                            'FieldBit': (17, 17),
                            'FieldName': 'FIELD_1',
                            'FieldDesc': '[功能描述]...',
                            'FieldRdType': 'RCLR',
                            'FieldWrType': 'NA',
                            'FieldRstVal': 0,
                            'FieldRstSig': 'Global Reset'
                        },
                        {
                            'FieldBit': (16, 14),
                            'FieldName': 'FIELD_2',
                            'FieldDesc': '[功能描述]...',
                            'FieldRdType': 'RSET',
                            'FieldWrType': 'WOSET',
                            'FieldRstVal': 0,
                            'FieldRstSig': 'Global Reset'
                        },
                        {
                            'FieldBit': (13, 13),
                            'FieldName': 'FIELD_3',
                            'FieldDesc': '[功能描述]...',
                            'FieldRdType': 'R',
                            'FieldWrType': 'WOT',
                            'FieldRstVal': 1,
                            'FieldRstSig': 'Global Reset'
                        },
                        {
                            'FieldBit': (12, 0),
                            'FieldName': 'Reserved',
                            'FieldDesc': '保留位',
                            'FieldRdType': 'R',
                            'FieldWrType': 'W',
                            'FieldRstVal': 0,
                            'FieldRstSig': 'Global Reset'
                        }
                    ]
                }
            ]
        }
        """
        fkeys = EXCEL_REG_FIELD.keys()
        hkeys = EXCEL_REG_HEAD.keys()

        for rfile_entry in self.reg_model.values():
            for reg in rfile_entry:
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

    def generate_rdl(self):
        """
        遍历Register model生成SystemRDL代码, 并保存在指定路径
        """
        regfiles_str = ""
        sigs_str = ""
        rst_sigs = []

        filename = os.path.join(self.gen_path, self.module_name + ".rdl")

        # module_name重名处理
        new_name = self.module_name
        suffix_num = 1

        while os.path.exists(filename):
            message.warning("rdl file %s already exists" % (filename))
            new_name = self.module_name + "_%d" %(suffix_num)
            filename = os.path.join(self.gen_path, new_name + ".rdl")
            suffix_num += 1

        self.module_name = new_name

        # 生成一个映射(Addrmap)中所有寄存器组(Regfile)例化代码
        for rfile_name, rfile_entry in self.reg_model.items():
            regs_str = ""
            # 生成一个寄存器组(Regfile)中所有寄存器(Reg)例化代码
            for reg in rfile_entry:
                fields_str = ""
                ext_str = ""

                # 生成一个寄存器(Reg)内所有域(Field)例化代码
                for fld in reg["Fields"]:
                    if fld["FieldName"].lower() == "reserved":
                        continue
                    
                    # 给Field中定义的reset signal分配外部定义的signal
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
            
            regfile_str = self.regfile_str.format(regs_str=regs_str, rfile_name=rfile_name, rfile_desc="Default")
            regfiles_str += regfile_str

        addrmap_str = self.addrmap_str.format(regfiles_str=regfiles_str, addrmap_name=self.addrmap_str)

        for rst_sig in rst_sigs:
            sigs_str += self.signal_str.format(sig_name=rst_sig, sig_desc="Default", active_mode="activehigh")

        with open(filename, "w", encoding="utf-8") as file:
            file.write(sigs_str)
            file.write(addrmap_str)