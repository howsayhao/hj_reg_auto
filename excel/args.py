EXCEL_REG_HEAD = {
    "RegName": {
        "Entry": {"Location": (1,1), "Name": ("名称", "Name")},
        "Content": {"Location": (1,2), "Pattern": None}
    },
    "BaseAddr": {
        "Entry": {"Location": (2,1), "Name": ("基地址", "Base Address")},
        "Content": {"Location": (2,2), "Pattern": "^0[Xx][0-9A-Fa-f]+|[0-9]+$"}
    },
    "AddrOffset": {
        "Entry": {"Location": (3,1), "Name": ("地址偏移", "Address Offset")},
        "Content": {"Location": (3,2), "Pattern": "^0[Xx][0-9A-Fa-f]+|[0-9]+$"}
    },
    "RegLen": {
        "Entry": {"Location": (4,1), "Name": ("长度", "Length")},
        "Content": {"Location": (4,2), "Pattern": "^(32)|(64)$"}
    },
    "RegAbbr": {
        "Entry": {"Location": (5,1), "Name": ("简写", "Abbreviation")},
        "Content": {"Location": (5,2), "Pattern": None}
    },
    "RegAccType": {
        "Entry": {"Location": (6,1), "Name": ("访问类型", "Access Type")},
        "Content": {"Location": (6,2), "Pattern": "^(RW)|(RO)$"}  # access type
    },
    "RegDesc": {
        "Entry": {"Location": (7,1), "Name": ("描述", "Description")},
        "Content": {"Location": (7,2), "Pattern": None}
    }
}

EXCEL_REG_FIELD = {
    "FieldBit": {
        "Entry": {"Location": (10,1), "Name": ("比特位", "Bit")},
        "Content": {"StartLocation": (11,1), "Pattern": "^[0-9]+:[0-9]+$"}
    },
    "FieldName": {
        "Entry": {"Location": (10,2), "Name": ("域名称", "Field Name")},
        "Content": {"StartLocation": (11,2), "Pattern": None}
    },
    "FieldDesc": {
        "Entry": {"Location": (10,3), "Name": ("描述", "Description")},
        "Content": {"StartLocation": (11,3), "Pattern": None}
    },
    "FieldValue": {
        "Entry": {"Location": (10,4), "Name": ("可选值", "Optional Value")},
        "Content": {"StartLocation": (11,4), "Pattern": "^(([0-9]+,?)+)|([0-9]+~[0-9]+) | Others | All$"}
    },
    "FieldAccType": {
        "Entry": {"Location": (10,5), "Name": ("访问类型", "Access Type")},
        "Content": {"StartLocation": (11,5), "Pattern": "^(RW)|(RO)$"} # Access Type
    },
    "FieldRstVal": {
        "Entry": {"Location": (10,6), "Name": ("复位值", "Reset Value")},
        "Content": {"StartLocation": (11,6), "Pattern": "^0[Xx][0-9A-Fa-f]+|[0-9]+$"}
    },
    "FieldRstSig": {
        "Entry": {"Location": (10,7), "Name": ("复位信号", "Reset Signal")},
        "Content": {"StartLocation": (11,7), "Pattern": None}
    }
}