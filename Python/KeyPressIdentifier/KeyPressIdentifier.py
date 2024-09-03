import pynput.keyboard
import time
from datetime import datetime
import tkinter as tk
from tkinter import scrolledtext
import threading
import queue

key_down_times = {}
key_events_queue = queue.Queue()

special_chars = {
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

def on_key_press(key):
    try:
        key_down_times[key.scan_code] = time.time()
    except AttributeError:
        pass

def on_key_release(key):
    try:
        duration = (time.time() - key_down_times.get(key.scan_code, time.time())) * 1000  # Duration in milliseconds
        ascii_repr = key.scan_code if 0 <= key.scan_code <= 127 else "N/A"
        key_name = key.name
        if key.name in special_chars:
            key_name = special_chars[key.name]
        elif len(key.name) > 1 and key.name[-1] in special_chars:
            key_name = special_chars[key.name[-1]]

        line = "| {} | {:03X} | {} | {} | {:.0f} |".format(key.name, key.scan_code, ascii_repr, key_name, duration)

        with open(output_file, "a") as f:
            f.write(line + "\n")

        key_events_queue.put(line)
    except AttributeError:
        pass

    return False  # Suppress key event

def update_text_box():
    while True:
        line = key_events_queue.get()
        text_box.configure(state='normal')
        text_box.insert(tk.END, line + "\n")
        text_box.see(tk.END)
        text_box.configure(state='disabled')

output_file = "keystrokes_{}.txt".format(datetime.now().strftime("%Y%m%d%H%M%S"))

header = "| Key | SC Code | ASCII | Description | Duration (ms) |\n| --- | ------- | ----- | ----------- | ------------- |\n"

with open(output_file, "a") as f:
    f.write(header)

root = tk.Tk()
root.title("Key Press Logger")

frame = tk.Frame(root)
frame.pack(padx=10, pady=10)

text_box = scrolledtext.ScrolledText(frame, wrap=tk.WORD, width=60, height=15)
text_box.pack()
text_box.insert(tk.END, header)
text_box.configure(state='disabled')

with pynput.keyboard.Listener(on_press=on_key_press, on_release=on_key_release) as listener:
    update_text_box_thread = threading_thread = threading.Thread(target=update_text_box, daemon=True)
update_text_box_thread.start()

try:
    root.mainloop()
except KeyboardInterrupt:
    listener.stop()

