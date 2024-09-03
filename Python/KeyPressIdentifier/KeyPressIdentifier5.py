import tkinter as tk
from tkinter import scrolledtext
import threading
from pynput import keyboard
import time

# Dictionary for special characters
special_chars = {
    '\n': 'Enter',
    '\t': 'Tab',
    ' ': 'Space',
    '\b': 'Backspace',
    '`': 'backtick',
    '~': 'tilde',
    '@': 'at',
    '#': 'hash',
    '$': 'dollar',
    '%': 'percent',
    '^': 'caret',
    '&': 'ampersand',
    '*': 'asterisk',
    '(': 'left parenthesis',
    ')': 'right parenthesis',
    '-': 'minus',
    '_': 'underscore',
    '=': 'equals',
    '+': 'plus',
    '[': 'left square bracket',
    '{': 'left curly brace',
    ']': 'right square bracket',
    '}': 'right curly brace',
    '\\': 'backslash',
    '|': 'pipe',
    ';': 'semicolon',
    ':': 'colon',
    "'": 'single quote',
    '"': 'double quote',
    ',': 'comma',
    '<': 'less than',
    '.': 'period',
    '>': 'greater than',
    '/': 'forward slash',
    '?': 'question mark'
}

# Function to handle key press
def on_key_press(key):
    try:
        char = key.char
        char_name = special_chars.get(char, char)
        key_code = key.vk
    except AttributeError:
        char_name = key.name
        key_code = key.value

    timestamp = time.time()
    duration = 0

    log = f"{timestamp}: {char_name} ({key_code}), Duration: {duration}s"
    log_to_file(log)
    update_text_box(log)

# Function to handle key release
def on_key_release(key):
    if key == keyboard.Key.esc:
        return False

# Function to log keystrokes to a text file
def log_to_file(log):
    with open("keystrokes.txt", "a") as f:
        f.write(log + "\n")

# Function to update the text box in the GUI
def update_text_box(log):
    text_box.configure(state='normal')
    text_box.insert(tk.END, log + "\n")
    text_box.configure(state='disabled')
    text_box.yview(tk.END)

# Thread function to listen for keystrokes
def listen_for_keystrokes():
    with keyboard.Listener(on_press=on_key_press, on_release=on_key_release) as listener:
        listener.join()

# Create the GUI window
root = tk.Tk()
root.title("Keystroke Logger")
root.geometry("600x400")

# Create the scrolling text box
text_box = scrolledtext.ScrolledText(root, wrap=tk.WORD, width=60, height=20, state='disabled')
text_box.pack(expand=True, fill=tk.BOTH)

# Create and start the keystroke listener thread
keystroke_listener_thread = threading.Thread(target=listen_for_keystrokes, daemon=True)
keystroke_listener_thread.start()

# Run the GUI event loop
root.mainloop()
