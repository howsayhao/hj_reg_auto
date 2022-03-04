from args import EXCEL_REG_FIELD, EXCEL_REG_HEAD

signal_str = """signal {{
    name = "Generic Reset Signal";
    desc = "This is a generic reset signal used to reset";
}} {rst_sig};
"""

field_str = """field {{
    name = "{field_name}";
    desc = "{field_desc}";

    {accesstype_str}

    resetsignal = {field_rst_sig};
    }} {field_name}[{field_bit_high}:{field_bit_low}] = {field_rst_val};
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

    {reg_fields}

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

def insert_regfile(regs:list[dict]):
    """
    重构寄存器list, 插入regfile级,
    默认将相同基地址的register归入相同regfile

    Return
    ------
    `dict` : `root_addrmap`, 多了一级regfile

    i.e.
    {'regfile_0': {'baseaddr': 0,
                   'regs': [{'RegName': 'TEMPLATE寄存器',
                             'BaseAddr': 0,
                             'AddrOffset': 0,
                             'RegLen': 32,
                             'RegAbbr': 'TEM',
                             'RegAccType': 'RW',
                             'RegDesc': '示例寄存器',
                             'Fields': [{'FieldBit': (xx, xx),
                                         'FieldName': 'FIELD_xx',
                                         'FieldDesc': 'xxxxxxx',
                                         'FieldValue': '0',
                                         'FieldAccType': 'RW',
                                         'FieldRstVal': 0,
                                         'FieldRstSig': 'Global Reset'},
                                        {'FieldBit': (xx, xx),
                                         'FieldName': 'FIELD_xx',
                                         'FieldDesc': 'xxxxxxx',
                                         'FieldValue': '0,1',
                                         'FieldAccType': 'RW',
                                         'FieldRstVal': 0,
                                         'FieldRstSig': 'Global Reset'}
                                        ]
                            }]}
     'regfile_1': {
         ......}
    }
    """
    root_addrmap = {}
    regfiles = {}
    regfile_num = 0
    field_elements = EXCEL_REG_FIELD.keys()

    for reg in regs:
        field_num = len(reg["FieldBit"])
        reg_baseaddr = reg["BaseAddr"]

        reg_fields = []
        regfile_name = "regfile_%d" % (regfile_num)
    
        if reg_baseaddr not in regfiles.values():

            regfiles[regfile_name] = reg_baseaddr
            regfile_num += 1
            root_addrmap[regfile_name] = {"baseaddr": reg_baseaddr,
                                          "regs":[reg]}
        else:
            root_addrmap[regfile_name]["regs"].append(reg)

        for idx in range(field_num):
            reg_field = {}

            for fkey in field_elements:
                reg_field[fkey] = reg[fkey][idx]

            reg_fields.append(reg_field)

        for fkey in field_elements:
            reg.pop(fkey)

        reg["Fields"] = reg_fields

    return root_addrmap

test_regs = [{'RegName': 'TEMPLATE寄存器',
              'BaseAddr': 0,
              'AddrOffset': 0,
              'RegLen': 32,
              'RegAbbr': 'TEM',
              'RegAccType': 'RW',
              'RegDesc': '示例寄存器',
              'FieldBit': [(31, 18), (17, 17), (16, 14), (13, 13), (12, 0)],
              'FieldName': ['Reserved', 'FIELD_1', 'FIELD_2', 'FIELD_3', 'Reserved'],
              'FieldDesc': ['保留位', '[功能描述]\n[0：可选说明，该FIELD为0时的作用\n1：可选说明，该FIELD为1时的作用]',
                            '[功能描述]\n[0：可选说明，该FIELD为0时的作用\n1：该FIELD为1时的作用\n…\n7：该FIELD为7时的作用]',
                            '[功能描述]\n[0：可选说明，该FIELD为0时的作用\n1：可选说明，该FIELD为1时的作用]', '保留位'],
              'FieldValue': ['0', '0,1', '0~7', '0,1', '0'],
              'FieldAccType': ['RW', 'RW', 'RW', 'RW', 'RW'],
              'FieldRstVal': [0, 0, 0, 1, 0],
              'FieldRstSig': ['Global Reset', 'Global Reset', 'Global Reset', 'Global Reset', 'Global Reset']}]
