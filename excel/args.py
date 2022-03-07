EXCEL_REG_HEAD = {
    "RegName": {
        "Entry": {
            "Loc": (1,1),
            "Name": ("名称", "Name")
        },
        "Content": {
            "Loc": (1,2),
            "Format": "str",
            "Pattern": None
        }
    },
    "AddrOffset": {
        "Entry": {
            "Loc": (2,1),
            "Name": ("地址偏移", "Address Offset")
        },
        "Content": {
            "Loc": (2,2),
            "Format": "hex",
            "Pattern": "^0[Xx][0-9A-Fa-f]+|[0-9]+$"
        }
    },
    "RegWidth": {
        "Entry": {
            "Loc": (3,1),
            "Name": ("位宽", "Width")
        },
        "Content": {
            "Loc": (3,2),
            "Format": "int",
            "Pattern": "^(32)|(64)$"
        }
    },
    "RegAbbr": {
        "Entry": {
            "Loc": (4,1),
            "Name": ("简写", "Abbreviation")
        },
        "Content": {
            "Loc": (4,2),
            "Format": "str",
            "Pattern": None
        }
    },
    "RegDesc": {
        "Entry": {
            "Loc": (5,1),
            "Name": ("描述", "Description")
        },
        "Content": {
            "Loc": (5,2),
            "Format": "str",
            "Pattern": None
        }
    }
}

EXCEL_REG_FIELD = {
    "FieldBit": {
        "Entry": {
            "Loc": (8,1),
            "Name": ("比特位", "Bit")
        },
        "Content": {
            "StartLoc": (9,1),
            "Format": "range",
            "Pattern": "^[0-9]+:[0-9]+$"
        }
    },
    "FieldName": {
        "Entry": {
            "Loc": (8,2),
            "Name": ("域名称", "Field Name")
        },
        "Content": {
            "StartLoc": (9,2),
            "Format": "str",
            "Pattern": None
        }
    },
    "FieldDesc": {
        "Entry": {
            "Loc": (8,3),
            "Name": ("描述", "Description")
        },
        "Content": {
            "StartLoc": (9,3),
            "Format": "str",
            "Pattern": None
        }
    },
    "FieldRdType": {
        "Entry": {
            "Loc": (8,4),
            "Name": ("读属性", "Read Type")
        },
        "Content": {
            "StartLoc": (9,4),
            "Format": "str",
            "Pattern": "^(R)|(NA)|(RCLR)|(RSET)|(RUSER)$"
        } # Access Type
    },
    "FieldWrType": {
        "Entry": {
            "Loc": (8,5),
            "Name": ("写属性", "Write Type")
        },
        "Content": {
            "StartLoc": (9,5),
            "Format": "str",
            "Pattern": "^(W)|(NA)|(WOSET)|(WOCLR)|(WOT)|(WZS)|(WZC)|(WZT)|(WUSER)$"
        }
    },
    "FieldRstVal": {
        "Entry": {
            "Loc": (8,6),
            "Name": ("复位值", "Reset Value")
        },
        "Content": {
            "StartLoc": (9,6),
            "Format": "hex",
            "Pattern": "^0[Xx][0-9A-Fa-f]+|[0-9]+$"
        }
    },
    "FieldRstSig": {
        "Entry": {
            "Loc": (8,7),
            "Name": ("复位信号", "Reset Signal")
        },
        "Content": {
            "StartLoc": (9,7),
            "Format": "str",
            "Pattern": None
        }
    }
}