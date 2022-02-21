
class ExcelRuleCheck:
    """
    定义和检查用Excel表格编写的寄存器Spec的规则约束。
    目前已有规则:
    1. 
    2. 
    3. 
    4. 
    """
    def __init__(self) -> None:
        pass

    def CheckTableItem(self) -> bool:
        """
        检查表格项是否齐全,以及位置是否正确
        """
        pass

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