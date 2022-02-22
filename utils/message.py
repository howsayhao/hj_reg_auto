"""
在命令行终端下打印不同格式的信息: INFO, WARNING, ERROR
"""
class PrintFormat:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def info(msg: str):
    print(PrintFormat.OKBLUE + "Info: " + msg + PrintFormat.ENDC)

def warning(msg: str):
    print(PrintFormat.WARNING + PrintFormat.BOLD + "Warning: " + msg + PrintFormat.ENDC)
    
def error(msg: str):
    print(PrintFormat.FAIL + PrintFormat.BOLD + "Error: " + msg + PrintFormat.ENDC)