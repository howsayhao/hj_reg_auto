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

def debug(msg:str, indent=0, msg_prefix="", raise_err=False):
    """
    Debug message with white color

    Raises
    ------
    Optional:
        `HRDAError`
    """
    print(" " * indent * 2 + msg_prefix + msg)

    if raise_err:
        raise HRDAError(msg)

def info(msg:str, indent=0, msg_prefix="Info: ", raise_err=False):
    """
    Info message with blue color

    Raises
    ------
    Optional:
        `HRDAError`
    """
    print(
        " " * indent * 2 + PrintFormat.BOLD + PrintFormat.OKBLUE +
        msg_prefix + PrintFormat.ENDC + msg
    )

    if raise_err:
        raise HRDAError(msg)

def warning(msg:str, indent=0, msg_prefix="Warning: ", raise_err=False):
    """
    Warning message with yellow color

    Raises
    ------
    Optional:
        `HRDAError`
    """
    print(
        " " * indent * 2 + PrintFormat.BOLD + PrintFormat.WARNING +
        msg_prefix + PrintFormat.ENDC + msg
    )

    if raise_err:
        raise HRDAError(msg)

def error(msg:str, indent=0, msg_prefix="Error: ", raise_err = True):
    """
    Error message with red color

    Raises
    ------
    Optional:
        `HRDAError`
    """
    print(
        " " * indent * 2 + PrintFormat.BOLD + PrintFormat.FAIL +
        msg_prefix + PrintFormat.ENDC + msg
    )

    if raise_err:
        raise HRDAError(msg)