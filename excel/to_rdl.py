from args import EXCEL_REG_FIELD, EXCEL_REG_HEAD

class RDLGenerator:
    signal_str = """signal {{
    name = "{}";
    desc = "{}";
    }} {rst_sig};
    """
    field_str = """field {{
        name = "{FieldName}";
        desc = "{FieldDesc}";

        {accesstype_str}

        resetsignal = {field_rst_sig};
        }} {FieldName}[{FieldBit[0]}:{FieldBit[1]}] = {FieldRstVal};
    """
    accesstype_str = """
        sw = {field_sw_acc_type};

        onread = {field_read_effect};
        onwrite = {field_write_effect};
    """
    reg_str = """reg {{
        name = "{reg_name}";
        desc = "{reg_desc}";

        regwidth = {reg_len};

        {fields}

        }} {reg_abbr} @{reg_addr_offset};
    """
    regfile_str = """regfile {{
        name = "{regfile_name}";
        desc = "{regfile_desc}";

        {regfile_regs}

        }} {regfile_name} @{regfile_base_addr};
    """
    addrmap_str = """addrmap {{
        {addrmap_regfiles}
    }} {addrmap_name};
    """

    @staticmethod
    def resize_model(reg_model:dict[str,list]):
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
                    'FieldRdType': ['R', 'RCLR', 'RSET', 'RUSER', 'R'],
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
                            'FieldRdType': 'RUSER',
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

        for rfile_entry in reg_model.values():
            for reg in rfile_entry:
                fld_num = len(reg["FieldBit"])
                fields = []

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
        print(reg_model)

    def generate_rdl(root_addrmap:dict):
        """
        根据root_addrmap生成SystemRDL代码.
        """
        for regf_name, regf_entry in root_addrmap.items():
            baseaddr = regf_entry["baseaddr"]
            regs = regf_entry["regs"]
            for reg in regs:
                for field in reg["Fields"]:
                    acc_type = field["FieldAccType"]


test_regs = {
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
            'FieldRdType': ['R', 'RCLR', 'RSET', 'RUSER', 'R'],
            'FieldWrType': ['W', 'NA', 'WOSET', 'WOT', 'W'],
            'FieldRstVal': [0, 0, 0, 1, 0],
            'FieldRstSig': ['Global Reset', 'Global Reset', 'Global Reset', 'Global Reset', 'Global Reset']
        }
    ]
}