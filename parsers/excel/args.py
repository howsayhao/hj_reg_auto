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
            "Pattern": "^(0[Xx][0-9A-Fa-f]+)$"
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
            "Pattern": "^((32)|(64))$"
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
            "Pattern": "^([0-9]+:[0-9]+)$"
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
    "FieldSwRdType": {
        "Entry": {
            "Loc": (8,4),
            "Name": ("软件读属性", "SW Read Type")
        },
        "Content": {
            "StartLoc": (9,4),
            "Format": "str",
            "Pattern": "^((R)|(NA)|(RCLR)|(RSET))$"
        } # Access Type
    },
    "FieldSwWrType": {
        "Entry": {
            "Loc": (8,5),
            "Name": ("软件写属性", "SW Write Type")
        },
        "Content": {
            "StartLoc": (9,5),
            "Format": "str",
            "Pattern": "^((W)|(NA)|(W1)|(WOSET)|(WOCLR)|(WOT)|(WZS)|(WZC)|(WZT))$"
        }
    },
    "FieldHwAccType": {
        "Entry": {
            "Loc": (8,6),
            "Name": ("硬件访问属性", "HW Access Type")
        },
        "Content": {
            "StartLoc": (9,6),
            "Format": "str",
            "Pattern": "^((R)|(W)|(RW)|(CLR)|(SET)|(NA))$"
        }
    },
    "FieldRstVal": {
        "Entry": {
            "Loc": (8,7),
            "Name": ("复位值", "Reset Value")
        },
        "Content": {
            "StartLoc": (9,7),
            "Format": "hex",
            "Pattern": "^(0[Xx][0-9A-Fa-f]+)$"
        }
    },
    "FieldSyncRstSig": {
        "Entry": {
            "Loc": (8,8),
            "Name": ("同步复位信号", "Sync. Reset Signal")
        },
        "Content": {
            "StartLoc": (9,8),
            "Format": "str",
            "Pattern": "^(([Nn][Oo][Nn][Ee])|([^0-9_]\w*(,\s*[^0-9_]\w*)*))$"
        }
    }
}