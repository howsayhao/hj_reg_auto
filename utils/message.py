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

class HRDAError(Exception):
    """
    Base class for all HRDA exceptions except for SystemRDL Compiler
    """
    pass

def debug(msg:str, raise_err = False):
    """
    Debug message with cyan color
    """
    print(PrintFormat.OKCYAN + msg + PrintFormat.ENDC)

    if raise_err:
        raise HRDAError(msg)

def info(msg:str, raise_err = False):
    """
    Info message with blue color
    """
    print(PrintFormat.OKBLUE + "Info: " + msg + PrintFormat.ENDC)

    if raise_err:
        raise HRDAError(msg)

def warning(msg:str, raise_err = False):
    """
    Warning message with yellow color
    """
    print(PrintFormat.WARNING + PrintFormat.BOLD + "Warning: " + msg + PrintFormat.ENDC)

    if raise_err:
        raise HRDAError(msg)

def error(msg:str, raise_err = True):
    """
    Error message with red color

    Raises
    ------
    `HRDAError`
    """
    print(PrintFormat.FAIL + PrintFormat.BOLD + "Error: " + msg + PrintFormat.ENDC)

    if raise_err:
        raise HRDAError(msg)