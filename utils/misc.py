
size_name = (
    "B", "KB", "MB", "GB",
    "TB", "PB", "EB", "ZB", "YB"
)

def convert_size(byte_size:int, digit = 0) -> str:
    if byte_size == 0:
        return
    elif byte_size >= 1024:
        return "{} {}{}".format(
            convert_size(byte_size // 1024, digit + 1),
            byte_size % 1024,
            size_name[digit]
        )
    else:
        return "{}{}".format(byte_size, size_name[digit])