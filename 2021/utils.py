def header(text: str, lw: int = 60, nl: bool = True) -> str:
    return ("\n" if nl else "") + text + "\n" + "-" * lw
