def decorate_with_hearts(text: str) -> str:
    """
    Decorates the given text with heart emojis before and after.

    Args:
        text (str): The input text to be decorated.

    Returns:
        str: The decorated text with heart emojis.
    """
    heart_emoji = "❤️"
    return f"{heart_emoji} {text} {heart_emoji}"
